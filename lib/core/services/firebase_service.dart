import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../../models/user_model.dart';
import '../../models/product_model.dart';
import '../../models/consignment_model.dart';
import '../../models/wallet_model.dart';
import '../../models/transaction_model.dart';
import '../../models/order_model.dart';
import '../../models/order_item_model.dart';
import 'mock_database.dart';

class FirebaseService {
  static final FirebaseService instance = FirebaseService._internal();
  FirebaseService._internal();

  // ImgBB API Key - Thay thế bằng API Key của bạn từ https://api.imgbb.com/ nếu muốn
  static const String imgBBApiKey = "4f9d2d0b57e754ef24483758b9cf2a6b";

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Khởi tạo và đồng bộ dữ liệu mẫu lên Firestore nếu database trống
  Future<void> initializeData() async {
    try {
      final userSnapshot = await _db.collection('users').limit(1).get();
      if (userSnapshot.docs.isEmpty) {
        print('Firestore is empty. Seeding mock data...');
        final mock = MockDatabase.instance;

        // 1. Thêm Người dùng
        for (var user in mock.danhSachNguoiDung) {
          await _db.collection('users').doc(user.id).set(user.thanhJson());
        }

        // 2. Thêm Ví
        for (var wallet in mock.danhSachVi) {
          await _db.collection('wallets').doc(wallet.id).set(wallet.thanhJson());
        }

        // 3. Thêm Giao dịch ví
        for (var transaction in mock.danhSachGiaoDich) {
          await _db.collection('transactions').doc(transaction.id).set(transaction.thanhJson());
        }

        // 4. Thêm Sản phẩm
        for (var product in mock.danhSachSanPham) {
          await _db.collection('products').doc(product.id).set(product.thanhJson());
        }

        // 5. Thêm Ký gửi
        for (var consignment in mock.danhSachKyGui) {
          await _db.collection('consignments').doc(consignment.id).set(consignment.thanhJson());
        }

        // 6. Thêm Đơn hàng
        for (var order in mock.danhSachDonHang) {
          await _db.collection('orders').doc(order.id).set(order.thanhJson());
        }

        // 7. Thêm Chi tiết đơn hàng
        for (var detail in mock.danhSachChiTietDonHang) {
          await _db.collection('order_items').doc(detail.id).set(detail.thanhJson());
        }

        print('Mock data seeded successfully.');
      } else {
        print('Firestore already initialized.');
      }
    } catch (e) {
      print('Error seeding database: $e');
    }
  }

  // Đăng nhập bằng tài khoản test qua Firebase Auth
  // Tự động đăng ký nếu chưa có tài khoản trên Auth
  Future<UserCredential?> authenticateTestAccount(NguoiDungModel userModel) async {
    final email = userModel.email;
    const password = "password123"; // Mật khẩu mặc định cho các tài khoản test

    try {
      // Đăng nhập thử
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'invalid-credential') {
        try {
          // Tạo tài khoản mới trên Firebase Auth
          final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
          
          // Đảm bảo thông tin user cũng được lưu trong Firestore 'users'
          await _db.collection('users').doc(userModel.id).set(userModel.thanhJson());
          return cred;
        } catch (signUpError) {
          print('Sign up error for test account: $signUpError');
        }
      } else {
        print('Sign in error: $e');
      }
    } catch (e) {
      print('Unknown auth error: $e');
    }
    return null;
  }

  // Upload hình ảnh lên các máy chủ lưu trữ (ImgBB -> Catbox -> Freeimage) và trả về Link trực tiếp
  Future<String> uploadImage(File file) async {
    // 1. Thử upload lên ImgBB (Có Key)
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('https://api.imgbb.com/1/upload?key=$imgBBApiKey'),
      );
      request.files.add(await http.MultipartFile.fromPath('image', file.path));

      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final decoded = jsonDecode(responseData);
        final url = decoded['data']['url'];
        if (url != null) {
          print('ImgBB upload success: $url');
          return url.toString();
        }
      } else {
        print('ImgBB upload failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('ImgBB upload error: $e');
    }

    // 2. Dự phòng 1: Upload lên Catbox (Hoàn toàn miễn phí & Không cần API Key)
    try {
      print('Attempting Catbox fallback upload...');
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('https://catbox.moe/user/api.php'),
      );
      request.fields['reqtype'] = 'fileupload';
      request.files.add(await http.MultipartFile.fromPath('fileToUpload', file.path));

      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final trimmedUrl = responseData.trim();
        if (trimmedUrl.startsWith('http')) {
          print('Catbox upload success: $trimmedUrl');
          return trimmedUrl;
        }
      } else {
        print('Catbox upload failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Catbox upload error: $e');
    }

    // 3. Dự phòng 2: Upload lên Freeimage.host (Sử dụng Key cộng đồng công khai)
    try {
      print('Attempting Freeimage.host fallback upload...');
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('https://freeimage.host/api/1/upload'),
      );
      request.fields['key'] = '6d207e02198a847ba98d0a2a901485a2'; // Public Community Key
      request.fields['action'] = 'upload';
      request.files.add(await http.MultipartFile.fromPath('source', file.path));

      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final decoded = jsonDecode(responseData);
        final url = decoded['image']['url'];
        if (url != null) {
          print('Freeimage.host upload success: $url');
          return url.toString();
        }
      } else {
        print('Freeimage.host upload failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Freeimage.host upload error: $e');
    }

    // 4. Dự phòng cuối cùng: Chọn ảnh Unsplash ngẫu nhiên nếu mất mạng hoặc tất cả dịch vụ đều lỗi
    final List<String> fallbackUrls = [
      'https://images.unsplash.com/photo-1591047139829-d91aecb6caea',
      'https://images.unsplash.com/photo-1595777457583-95e059d581b8',
      'https://images.unsplash.com/photo-1584917865442-de89df76afd3',
      'https://images.unsplash.com/photo-1542291026-7eec264c27ff',
    ];
    final randomIdx = DateTime.now().millisecondsSinceEpoch % fallbackUrls.length;
    return fallbackUrls[randomIdx];
  }
}
