import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../core/services/firebase_service.dart';
import '../core/theme/app_typography.dart';
import '../models/product_model.dart';
import '../models/order_model.dart';
import '../models/order_item_model.dart';
import '../models/consignment_model.dart';
import '../models/wallet_model.dart';
import '../models/transaction_model.dart';
import '../models/user_model.dart';
import '../models/cart_model.dart';
import '../models/address_model.dart';
import '../models/notification_model.dart';

class StoreProvider extends ChangeNotifier {
  NguoiDungModel? _currentUser;
  
  // Dữ liệu từ Firestore
  List<NguoiDungModel> _danhSachNguoiDung = [];
  List<KyGuiModel> _danhSachKyGui = [];
  List<SanPhamModel> _danhSachSanPham = [];
  List<DonHangModel> _danhSachDonHang = [];
  List<ChiTietDonHangModel> _danhSachChiTietDonHang = [];
  List<ViModel> _danhSachVi = [];
  List<GiaoDichModel> _danhSachGiaoDich = [];
  List<DiaChiModel> _danhSachDiaChi = [];
  List<ThongBaoModel> _danhSachThongBao = [];
  double _defaultCommissionRate = 10.0;

  // Giỏ hàng (lưu local trên RAM)
  final List<GioHangModel> _danhSachGioHang = [];

  List<GioHangModel> get danhSachGioHangCaNhan {
    if (_currentUser == null) return [];
    return _danhSachGioHang.where((item) => item.nguoiDungId == _currentUser!.id).toList();
  }

  // Thêm vào giỏ hàng
  void addToCart(SanPhamModel sanPham, String size, {int soLuong = 1}) {
    if (_currentUser == null) return;
    
    final existingIndex = _danhSachGioHang.indexWhere(
      (item) => item.nguoiDungId == _currentUser!.id && 
                item.sanPhamId == sanPham.id && 
                item.kichThuocDaChon == size
    );

    if (existingIndex != -1) {
      final existingItem = _danhSachGioHang[existingIndex];
      _danhSachGioHang[existingIndex] = GioHangModel(
        id: existingItem.id,
        nguoiDungId: existingItem.nguoiDungId,
        sanPhamId: existingItem.sanPhamId,
        soLuong: existingItem.soLuong + soLuong,
        kichThuocDaChon: existingItem.kichThuocDaChon,
        mauSacDaChon: existingItem.mauSacDaChon,
      );
    } else {
      _danhSachGioHang.add(
        GioHangModel(
          id: 'GH_${DateTime.now().millisecondsSinceEpoch}_${sanPham.id}',
          nguoiDungId: _currentUser!.id,
          sanPhamId: sanPham.id,
          soLuong: soLuong,
          kichThuocDaChon: size,
          mauSacDaChon: 'Mặc định',
        ),
      );
    }
    notifyListeners();
  }

  // Xóa khỏi giỏ hàng
  void removeFromCart(String cartItemId) {
    _danhSachGioHang.removeWhere((item) => item.id == cartItemId);
    notifyListeners();
  }

  // Cập nhật số lượng
  void updateCartQuantity(String cartItemId, int delta) {
    final index = _danhSachGioHang.indexWhere((item) => item.id == cartItemId);
    if (index == -1) return;

    final item = _danhSachGioHang[index];
    final newSoLuong = item.soLuong + delta;
    if (newSoLuong <= 0) {
      _danhSachGioHang.removeAt(index);
    } else {
      _danhSachGioHang[index] = GioHangModel(
        id: item.id,
        nguoiDungId: item.nguoiDungId,
        sanPhamId: item.sanPhamId,
        soLuong: newSoLuong,
        kichThuocDaChon: item.kichThuocDaChon,
        mauSacDaChon: item.mauSacDaChon,
      );
    }
    notifyListeners();
  }

  // Tạm tính giỏ hàng
  double get cartSubtotal {
    double total = 0;
    for (var item in danhSachGioHangCaNhan) {
      final sanPham = danhSachSanPham.firstWhere(
        (p) => p.id == item.sanPhamId,
        orElse: () => SanPhamModel(
          id: '',
          ten: 'Sản phẩm đã xóa',
          moTa: '',
          gia: 0,
          giaGoc: 0,
          phanTramGiamGia: 0,
          hinhAnh: [''],
          thuongHieuId: '',
          danhMucId: '',
          kichThuoc: '',
          tinhTrang: '',
          trangThai: '',
          tonKho: 0,
          noiBat: false,
          nguoiBanId: '',
          ngayTao: DateTime.now(),
        ),
      );
      total += sanPham.gia * item.soLuong;
    }
    return total;
  }

  // Phí vận chuyển
  double get shippingFee => danhSachGioHangCaNhan.isEmpty ? 0 : 30000;

  // Giảm giá (mẫu)
  double get discount => 0; 

  // Tổng tiền giỏ hàng
  double get cartTotal => cartSubtotal + shippingFee - discount;

  // Đặt hàng (Thanh toán & đồng bộ lên Firestore)
  String? checkout(String phuongThucThanhToan) {
    if (_currentUser == null || danhSachGioHangCaNhan.isEmpty) return null;

    final items = List<GioHangModel>.from(danhSachGioHangCaNhan);

    // 1. Kiểm tra tồn kho trước khi đặt hàng
    for (var item in items) {
      final sanPhamIndex = _danhSachSanPham.indexWhere((p) => p.id == item.sanPhamId);
      if (sanPhamIndex == -1) return null;
      final sanPham = _danhSachSanPham[sanPhamIndex];
      if (sanPham.tonKho < item.soLuong || sanPham.trangThai == 'DA_BAN') {
        return 'ERR_STOCK';
      }
    }

    final orderId = 'DH_${DateTime.now().millisecondsSinceEpoch}';
    final total = cartTotal;

    final newOrder = DonHangModel(
      id: orderId,
      nguoiDungId: _currentUser!.id,
      diaChiId: 'DC_${_currentUser!.id}',
      tongTien: total,
      phiVanChuyen: shippingFee,
      phuongThucThanhToan: phuongThucThanhToan,
      trangThai: 'DANG_GIAO', // mặc định là đang giao để Admin có thể duyệt hoàn thành
      ngayTao: DateTime.now(),
    );

    // Sử dụng batch để ghi đồng thời đơn hàng và các chi tiết đơn hàng lên Firestore
    final batch = FirebaseFirestore.instance.batch();

    final orderRef = FirebaseFirestore.instance.collection('orders').doc(orderId);
    batch.set(orderRef, newOrder.thanhJson());

    for (var item in items) {
      final sanPham = _danhSachSanPham.firstWhere((p) => p.id == item.sanPhamId);
      
      // Cập nhật tồn kho sản phẩm trong Firestore
      final productRef = FirebaseFirestore.instance.collection('products').doc(item.sanPhamId);
      final newTonKho = (sanPham.tonKho - item.soLuong).clamp(0, 99999);
      if (newTonKho == 0) {
        batch.update(productRef, {
          'tonKho': 0,
          'trangThai': 'DA_BAN',
        });
      } else {
        batch.update(productRef, {
          'tonKho': newTonKho,
        });
      }

      final detailId = 'CT_${DateTime.now().millisecondsSinceEpoch}_${item.sanPhamId}';
      final newDetail = ChiTietDonHangModel(
        id: detailId,
        donHangId: orderId,
        sanPhamId: item.sanPhamId,
        gia: sanPham.gia,
        soLuong: item.soLuong,
        tamTinh: sanPham.gia * item.soLuong,
      );

      final detailRef = FirebaseFirestore.instance.collection('order_items').doc(detailId);
      batch.set(detailRef, newDetail.thanhJson());
    }

    batch.commit().then((_) {
      print('Checkout batch successfully written to Firestore.');
      sendNotification(
        nguoiDungId: adminUserId,
        tieuDe: 'Đơn hàng mới',
        noiDung: 'Khách hàng ${_currentUser?.ten ?? "Ẩn danh"} đã đặt đơn hàng mới $orderId với tổng giá trị ${total.toVND()}.',
        loai: 'DON_HANG',
      );
    }).catchError((e) {
      print('Checkout batch error: $e');
    });

    // Xóa giỏ hàng local của người dùng hiện tại
    _danhSachGioHang.removeWhere((item) => item.nguoiDungId == _currentUser!.id);

    notifyListeners();
    return orderId;
  }

  StoreProvider() {
    final currentFirebaseUser = FirebaseAuth.instance.currentUser;
    if (currentFirebaseUser != null) {
      _currentUser = NguoiDungModel(
        id: currentFirebaseUser.uid,
        ten: currentFirebaseUser.displayName ?? (currentFirebaseUser.email?.split('@').first ?? 'Người dùng'),
        email: currentFirebaseUser.email ?? '',
        soDienThoai: '',
        avatar: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde',
        vaiTro: (currentFirebaseUser.email == 'admin@outlet.com') ? 'ADMIN' : 'USER',
        ngayTao: DateTime.now(),
      );
    } else {
      _currentUser = null;
    }
    _initFirestoreListeners();
  }

  void _initFirestoreListeners() {
    final firestore = FirebaseFirestore.instance;

    // Lắng nghe người dùng
    firestore.collection('users').snapshots().listen((snapshot) {
      _danhSachNguoiDung = snapshot.docs.map((doc) => NguoiDungModel.tuJson(doc.data())).toList();
      
      final currentFirebaseUser = FirebaseAuth.instance.currentUser;
      if (currentFirebaseUser != null) {
        final updatedUserIdx = _danhSachNguoiDung.indexWhere((u) => u.id == currentFirebaseUser.uid);
        if (updatedUserIdx != -1) {
          _currentUser = _danhSachNguoiDung[updatedUserIdx];
        } else {
          final emailIdx = _danhSachNguoiDung.indexWhere((u) => u.email == currentFirebaseUser.email);
          if (emailIdx != -1) {
            _currentUser = _danhSachNguoiDung[emailIdx];
          }
        }
      } else {
        _currentUser = null;
      }
      notifyListeners();
    });


    // Lắng nghe sản phẩm
    firestore.collection('products').snapshots().listen((snapshot) {
      _danhSachSanPham = snapshot.docs.map((doc) => SanPhamModel.tuJson(doc.data())).toList();
      notifyListeners();
    });

    // Lắng nghe ký gửi
    firestore.collection('consignments').snapshots().listen((snapshot) {
      _danhSachKyGui = snapshot.docs.map((doc) => KyGuiModel.tuJson(doc.data())).toList();
      notifyListeners();
    });

    // Lắng nghe đơn hàng
    firestore.collection('orders').snapshots().listen((snapshot) {
      _danhSachDonHang = snapshot.docs.map((doc) => DonHangModel.tuJson(doc.data())).toList();
      notifyListeners();
    });

    // Lắng nghe chi tiết đơn hàng
    firestore.collection('order_items').snapshots().listen((snapshot) {
      _danhSachChiTietDonHang = snapshot.docs.map((doc) => ChiTietDonHangModel.tuJson(doc.data())).toList();
      notifyListeners();
    });

    // Lắng nghe ví
    firestore.collection('wallets').snapshots().listen((snapshot) {
      _danhSachVi = snapshot.docs.map((doc) => ViModel.tuJson(doc.data())).toList();
      notifyListeners();
    });

    // Lắng nghe giao dịch
    firestore.collection('transactions').snapshots().listen((snapshot) {
      _danhSachGiaoDich = snapshot.docs.map((doc) => GiaoDichModel.tuJson(doc.data())).toList();
      notifyListeners();
    });

    // Lắng nghe địa chỉ
    firestore.collection('addresses').snapshots().listen((snapshot) {
      _danhSachDiaChi = snapshot.docs.map((doc) => DiaChiModel.tuJson(doc.data())).toList();
      notifyListeners();
    });

    // Lắng nghe thông báo
    firestore.collection('notifications').snapshots().listen((snapshot) {
      _danhSachThongBao = snapshot.docs.map((doc) => ThongBaoModel.tuJson(doc.data())).toList();
      notifyListeners();
    });

    // Lắng nghe cấu hình hệ thống (hoa hồng mặc định)
    firestore.collection('settings').doc('commission').snapshots().listen((doc) {
      if (doc.exists && doc.data() != null) {
        final data = doc.data()!;
        if (data['defaultRate'] != null) {
          _defaultCommissionRate = (data['defaultRate'] as num).toDouble();
          notifyListeners();
        }
      }
    });
  }

  // Getters cho dữ liệu hiện tại
  NguoiDungModel? get currentUser => _currentUser;
  bool get isAdmin => _currentUser?.vaiTro == 'ADMIN';

  // Trỏ getters sang các list lấy từ Firestore
  List<NguoiDungModel> get danhSachNguoiDung => _danhSachNguoiDung;
  List<KyGuiModel> get danhSachKyGui => _danhSachKyGui;
  List<SanPhamModel> get danhSachSanPham => _danhSachSanPham;
  List<DonHangModel> get danhSachDonHang => _danhSachDonHang;
  List<ChiTietDonHangModel> get danhSachChiTietDonHang => _danhSachChiTietDonHang;
  List<ViModel> get danhSachVi => _danhSachVi;
  List<GiaoDichModel> get danhSachGiaoDich => _danhSachGiaoDich;
  List<DiaChiModel> get danhSachDiaChi => _danhSachDiaChi;
  List<ThongBaoModel> get danhSachThongBao => _danhSachThongBao;

  double get defaultCommissionRate => _defaultCommissionRate;

  Future<void> updateDefaultCommissionRate(double newRate) async {
    if (newRate > 20.0) {
      throw Exception("Tỷ lệ hoa hồng tối đa là 20%!");
    }
    await FirebaseFirestore.instance.collection('settings').doc('commission').set({
      'defaultRate': newRate,
      'updatedAt': DateTime.now().toIso8601String(),
    });
  }

  String get adminUserId {
    final adminIdx = _danhSachNguoiDung.indexWhere((u) => u.vaiTro == 'ADMIN');
    if (adminIdx != -1) {
      return _danhSachNguoiDung[adminIdx].id;
    }
    return 'ADMIN01';
  }

  // Lấy danh sách thông báo của tài khoản hiện hành (sắp xếp mới nhất lên đầu)
  List<ThongBaoModel> get thongBaoCuaToi {
    if (_currentUser == null) return [];
    final isAdminUser = _currentUser!.vaiTro == 'ADMIN';
    return _danhSachThongBao
        .where((t) {
          if (isAdminUser) {
            return t.nguoiDungId == _currentUser!.id || t.nguoiDungId == 'ADMIN01';
          }
          return t.nguoiDungId == _currentUser!.id;
        })
        .toList()
      ..sort((a, b) => b.ngayTao.compareTo(a.ngayTao));
  }

  // Số lượng thông báo chưa đọc
  int get soThongBaoChuaDoc {
    return thongBaoCuaToi.where((t) => !t.daDoc).length;
  }

  // Lấy ví của tài khoản hiện hành
  ViModel? get viCuaToi {
    if (_currentUser == null) return null;
    final walletIdx = danhSachVi.indexWhere((v) => v.nguoiDungId == _currentUser!.id);
    if (walletIdx != -1) {
      return danhSachVi[walletIdx];
    } else {
      // Nếu chưa có ví thì tạo mới ví 0đ trên Firestore
      final newWallet = ViModel(
        id: 'V_${_currentUser!.id}',
        nguoiDungId: _currentUser!.id,
        soDu: 0,
        soDuDangCho: 0,
        soDuCoTheRut: 0,
        ngayCapNhat: DateTime.now(),
      );
      FirebaseFirestore.instance.collection('wallets').doc(newWallet.id).set(newWallet.thanhJson());
      return newWallet;
    }
  }

  // Lấy danh sách giao dịch ví của tài khoản hiện hành
  List<GiaoDichModel> get giaoDichCuaToi {
    final vi = viCuaToi;
    if (vi == null) return [];
    return danhSachGiaoDich.where((g) => g.viId == vi.id).toList()
      ..sort((a, b) => b.ngayTao.compareTo(a.ngayTao)); // Mới xếp trước
  }

  // Lấy danh sách ký gửi của tài khoản hiện hành
  List<KyGuiModel> get kyGuiCuaToi {
    if (_currentUser == null) return [];
    final isVang = _currentUser!.email == 'vanga@gmail.com';
    return danhSachKyGui
        .where((k) => k.nguoiDungId == _currentUser!.id || (isVang && k.nguoiDungId == 'USER01'))
        .toList()
      ..sort((a, b) => b.ngayTao.compareTo(a.ngayTao));
  }

  // Lấy địa chỉ mặc định hoặc địa chỉ đầu tiên của người dùng hiện hành
  DiaChiModel get diaChiMacDinh {
    final defaultAddr = _danhSachDiaChi.firstWhere(
      (d) => d.nguoiDungId == (_currentUser?.id ?? 'USER01') && d.macDinh,
      orElse: () {
        final userAddr = _danhSachDiaChi.where((d) => d.nguoiDungId == (_currentUser?.id ?? 'USER01')).toList();
        if (userAddr.isNotEmpty) return userAddr.first;
        return DiaChiModel(
          id: 'DC_${_currentUser?.id ?? 'USER01'}',
          nguoiDungId: _currentUser?.id ?? 'USER01',
          tenNguoiNhan: _currentUser?.ten ?? 'Nguyễn Văn A',
          soDienThoai: _currentUser?.soDienThoai.isEmpty == true ? '0123456789' : (_currentUser?.soDienThoai ?? '0123456789'),
          tinhThanh: 'TP. Hồ Chí Minh',
          quanHuyen: 'Quận 1',
          phuongXa: 'Phường Bến Nghé',
          diaChiChiTiet: '123 Nguyễn Trãi',
          macDinh: true,
        );
      },
    );
    return defaultAddr;
  }

  // Cập nhật hoặc thêm địa chỉ giao hàng
  Future<void> updateAddress(DiaChiModel diaChi) async {
    await FirebaseFirestore.instance.collection('addresses').doc(diaChi.id).set(diaChi.thanhJson());
  }

  // Cập nhật hồ sơ cá nhân của người dùng
  Future<void> updateUserProfile(String ten, String soDienThoai) async {
    if (_currentUser == null) return;
    final updatedUser = _currentUser!.saoChep(ten: ten, soDienThoai: soDienThoai);
    await FirebaseFirestore.instance.collection('users').doc(_currentUser!.id).set(updatedUser.thanhJson());
  }

  // Chuyển đổi vai trò người dùng (Đăng nhập)
  void switchUser(String userId) async {
    final userIdx = _danhSachNguoiDung.indexWhere((u) => u.id == userId);
    if (userIdx != -1) {
      final user = _danhSachNguoiDung[userIdx];
      _currentUser = user;
      notifyListeners();

      // Đăng nhập Firebase Auth ở background
      try {
        await FirebaseService.instance.authenticateTestAccount(user);
      } catch (e) {
        print("Error logging into Firebase Auth: $e");
      }
    }
  }

  // Đăng nhập bằng Email và Password
  // Trả về null nếu thành công, hoặc chuỗi thông báo lỗi nếu thất bại
  Future<String?> loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential? cred;
      try {
        cred = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      } on FirebaseAuthException catch (authEx) {
        // Nếu tài khoản chưa được tạo trên Auth nhưng có trong Firestore (đã seed mẫu)
        if (authEx.code == 'user-not-found' || authEx.code == 'invalid-credential' || authEx.code == 'wrong-password') {
          final query = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: email).get();
          if (query.docs.isNotEmpty) {
            try {
              // Tự động tạo tài khoản trên Auth với mật khẩu người dùng vừa nhập
              cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
            } catch (createEx) {
              print("Auto-create Auth account failed: $createEx");
            }
          }
        }
        if (cred == null) {
          if (authEx.code == 'wrong-password' || authEx.code == 'invalid-credential' || authEx.code == 'user-not-found') {
            return 'Sai mật khẩu hoặc thông tin đăng nhập!';
          }
          return 'Đăng nhập thất bại: ${authEx.message}';
        }
      }

      if (cred.user != null) {
        // Lấy thông tin user từ Firestore
        final doc = await FirebaseFirestore.instance.collection('users').doc(cred.user!.uid).get();
        if (doc.exists && doc.data() != null) {
          final user = NguoiDungModel.tuJson(doc.data()!);
          
          // Kiểm tra nếu tài khoản bị khóa (BLOCKED)
          if (user.trangThai == 'BLOCKED') {
            await FirebaseAuth.instance.signOut();
            return 'Tài khoản của bạn đã bị khóa! Vui lòng liên hệ Admin.';
          }
          
          _currentUser = user;
          notifyListeners();
          return null; // Thành công
        } else {
          // Khớp theo Email nếu tài khoản mẫu được seed bằng ID tùy chọn (USER01, USER02, ADMIN01)
          final query = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: email).get();
          if (query.docs.isNotEmpty) {
            final oldUserDoc = query.docs.first;
            final oldUser = NguoiDungModel.tuJson(oldUserDoc.data());
            
            // Kiểm tra nếu tài khoản bị khóa (BLOCKED)
            if (oldUser.trangThai == 'BLOCKED') {
              await FirebaseAuth.instance.signOut();
              return 'Tài khoản của bạn đã bị khóa! Vui lòng liên hệ Admin.';
            }

            // Cập nhật ID tài liệu trùng khớp với UID của Firebase Auth
            final updatedUser = NguoiDungModel(
              id: cred.user!.uid,
              ten: oldUser.ten,
              email: oldUser.email,
              soDienThoai: oldUser.soDienThoai,
              avatar: oldUser.avatar,
              vaiTro: oldUser.vaiTro,
              ngayTao: oldUser.ngayTao,
              trangThai: oldUser.trangThai,
            );

            // Tạo tài liệu mới bằng Firebase UID và xóa tài liệu cũ
            await FirebaseFirestore.instance.collection('users').doc(cred.user!.uid).set(updatedUser.thanhJson());
            if (oldUser.id != cred.user!.uid) {
              await FirebaseFirestore.instance.collection('users').doc(oldUser.id).delete();

              // Di chuyển tài liệu ví của người dùng sang ID mới tương ứng
              final oldWalletId = 'V_${oldUser.id}';
              final newWalletId = 'V_${cred.user!.uid}';
              final walletDoc = await FirebaseFirestore.instance.collection('wallets').doc(oldWalletId).get();
              if (walletDoc.exists && walletDoc.data() != null) {
                final walletData = walletDoc.data()!;
                walletData['id'] = newWalletId;
                walletData['nguoiDungId'] = cred.user!.uid;
                await FirebaseFirestore.instance.collection('wallets').doc(newWalletId).set(walletData);
                await FirebaseFirestore.instance.collection('wallets').doc(oldWalletId).delete();
              }
            }

            _currentUser = updatedUser;
            notifyListeners();
            return null; // Thành công
          } else {
            // Tạo tài khoản mặc định trên Firestore nếu không tìm thấy profile
            final newUser = NguoiDungModel(
              id: cred.user!.uid,
              ten: email.split('@').first,
              email: email,
              soDienThoai: '',
              avatar: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde',
              vaiTro: 'USER',
              ngayTao: DateTime.now(),
              trangThai: 'ACTIVE',
            );
            await FirebaseFirestore.instance.collection('users').doc(newUser.id).set(newUser.thanhJson());
            _currentUser = newUser;
            notifyListeners();
            return null; // Thành công
          }
        }
      }
    } catch (e) {
      print("Login error: $e");
      return 'Lỗi đăng nhập hệ thống: $e';
    }
    return 'Đăng nhập thất bại!';
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      _currentUser = null;
      notifyListeners();
    } catch (e) {
      print("Logout error: $e");
    }
  }

  // Đăng ký tài khoản mới bằng Email và Password
  Future<bool> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String ten,
    required String soDienThoai,
  }) async {
    try {
      final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      if (cred.user != null) {
        // Lưu thông tin người dùng lên Firestore
        final newUser = NguoiDungModel(
          id: cred.user!.uid,
          ten: ten,
          email: email,
          soDienThoai: soDienThoai,
          avatar: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde',
          vaiTro: 'USER',
          ngayTao: DateTime.now(),
        );
        final userJson = newUser.thanhJson();
        userJson['matKhau'] = password;
        await FirebaseFirestore.instance.collection('users').doc(newUser.id).set(userJson);
        _currentUser = newUser;
        notifyListeners();
        return true;
      }
    } catch (e) {
      print("Register error: $e");
    }
    return false;
  }

  // Đặt lại mật khẩu mới trong ứng dụng bằng cách xác thực OTP
  Future<String?> resetPasswordInApp({required String email, required String newPassword}) async {
    try {
      final query = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: email).get();
      if (query.docs.isEmpty) {
        return 'Email này chưa được đăng ký tài khoản!';
      }

      final userDoc = query.docs.first;
      final userData = userDoc.data();
      final oldPassword = userData['matKhau'] ?? 'password123';

      // Đăng nhập tạm thời bằng mật khẩu cũ để có quyền đổi mật khẩu
      final tempCred = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: oldPassword);
      if (tempCred.user == null) {
        return 'Không thể xác thực tài khoản để khôi phục mật khẩu!';
      }

      // Đổi mật khẩu trên Firebase Auth
      await tempCred.user!.updatePassword(newPassword);

      // Cập nhật mật khẩu mới vào Firestore
      await FirebaseFirestore.instance.collection('users').doc(tempCred.user!.uid).update({
        'matKhau': newPassword,
      });

      // Đăng xuất
      await FirebaseAuth.instance.signOut();
      _currentUser = null;
      notifyListeners();
      return null;
    } catch (e) {
      print("Reset password in app error: $e");
      return 'Lỗi đặt lại mật khẩu: $e';
    }
  }

  // Tạo yêu cầu ký gửi mới (Tạo đồng thời KyGuiModel và SanPhamModel bản nháp lên Firestore)
  void createConsignmentRequest({
    required String ten,
    required String moTa,
    required double giaMongMuon,
    required String brand,
    required String category,
    required String size,
    required String condition,
    required List<String> images,
    int soLuong = 1,
  }) async {
    final id = 'KG_${DateTime.now().millisecondsSinceEpoch}';
    final user = _currentUser ?? (_danhSachNguoiDung.isNotEmpty ? _danhSachNguoiDung.firstWhere((u) => u.id == 'USER01') : null);
    if (user == null) return;

    final newKyGui = KyGuiModel(
      id: id,
      nguoiDungId: user.id,
      tenSanPham: ten,
      moTa: moTa,
      hinhAnh: images.isEmpty ? ['https://images.unsplash.com/photo-1595777457583-95e059d581b8'] : images,
      giaMongMuon: giaMongMuon,
      giaDuocDuyet: 0,
      phanTramHoaHong: 0,
      trangThai: 'CHO_DUYET',
      ngayBatDau: DateTime.now(),
      ngayKetThuc: DateTime.now().add(const Duration(days: 30)),
      ghiChuAdmin: '',
      ngayTao: DateTime.now(),
    );

    final newSanPham = SanPhamModel(
      id: id,
      ten: ten,
      moTa: moTa,
      gia: giaMongMuon,
      giaGoc: giaMongMuon,
      phanTramGiamGia: 0,
      hinhAnh: images.isEmpty ? ['https://images.unsplash.com/photo-1595777457583-95e059d581b8'] : images,
      thuongHieuId: brand,
      danhMucId: category,
      kichThuoc: size,
      tinhTrang: condition,
      trangThai: 'CHO_DUYET',
      tonKho: soLuong,
      noiBat: false,
      nguoiBanId: user.id,
      ngayTao: DateTime.now(),
    );

    final batch = FirebaseFirestore.instance.batch();
    batch.set(FirebaseFirestore.instance.collection('consignments').doc(id), newKyGui.thanhJson());
    batch.set(FirebaseFirestore.instance.collection('products').doc(id), newSanPham.thanhJson());
    
    try {
      await batch.commit();
      sendNotification(
        nguoiDungId: adminUserId,
        tieuDe: 'Yêu cầu ký gửi mới',
        noiDung: 'Khách hàng ${user.ten} đã gửi yêu cầu ký gửi mới cho sản phẩm "$ten" với giá mong muốn ${giaMongMuon.toVND()}.',
        loai: 'KY_GUI',
      );
    } catch (e) {
      print("Error creating consignment request: $e");
    }
  }

  // Cập nhật yêu cầu ký gửi (Bởi người ký gửi)
  void updateConsignmentRequest({
    required String id,
    required String ten,
    required String moTa,
    required double gia,
    required String brand,
    required String category,
    required String size,
    required String condition,
    required List<String> images,
    required int soLuong,
  }) async {
    final consignmentIdx = _danhSachKyGui.indexWhere((k) => k.id == id);
    final productIdx = _danhSachSanPham.indexWhere((p) => p.id == id);
    if (consignmentIdx == -1 || productIdx == -1) return;

    final existingConsignment = _danhSachKyGui[consignmentIdx];
    final existingProduct = _danhSachSanPham[productIdx];

    // Xác định trạng thái mới dựa trên số lượng và trạng thái cũ
    String newTrangThai = existingProduct.trangThai;
    if (existingProduct.trangThai == 'DA_BAN' && soLuong > 0) {
      newTrangThai = 'DANG_BAN';
    } else if (existingProduct.trangThai == 'BI_TU_CHOI') {
      newTrangThai = 'CHO_DUYET';
    } else if (existingProduct.trangThai == 'DANG_BAN' && soLuong == 0) {
      newTrangThai = 'DA_BAN';
    }

    final updatedKyGui = KyGuiModel(
      id: id,
      nguoiDungId: existingConsignment.nguoiDungId,
      tenSanPham: ten,
      moTa: moTa,
      hinhAnh: images.isEmpty ? existingConsignment.hinhAnh : images,
      giaMongMuon: gia,
      giaDuocDuyet: newTrangThai == 'DANG_BAN' || newTrangThai == 'DA_BAN' ? gia : existingConsignment.giaDuocDuyet,
      phanTramHoaHong: existingConsignment.phanTramHoaHong,
      trangThai: newTrangThai,
      ngayBatDau: existingConsignment.ngayBatDau,
      ngayKetThuc: existingConsignment.ngayKetThuc,
      ghiChuAdmin: existingConsignment.ghiChuAdmin,
      ngayTao: existingConsignment.ngayTao,
    );

    final updatedSanPham = SanPhamModel(
      id: id,
      ten: ten,
      moTa: moTa,
      gia: gia,
      giaGoc: gia,
      phanTramGiamGia: existingProduct.phanTramGiamGia,
      hinhAnh: images.isEmpty ? existingProduct.hinhAnh : images,
      thuongHieuId: brand,
      danhMucId: category,
      kichThuoc: size,
      tinhTrang: condition,
      trangThai: newTrangThai,
      tonKho: soLuong,
      noiBat: existingProduct.noiBat,
      nguoiBanId: existingProduct.nguoiBanId,
      ngayTao: existingProduct.ngayTao,
    );

    final batch = FirebaseFirestore.instance.batch();
    batch.set(FirebaseFirestore.instance.collection('consignments').doc(id), updatedKyGui.thanhJson());
    batch.set(FirebaseFirestore.instance.collection('products').doc(id), updatedSanPham.thanhJson());

    try {
      await batch.commit();
    } catch (e) {
      print("Error updating consignment request: $e");
    }
  }

  // Admin duyệt ký gửi, quy định giá duyệt và % hoa hồng
  void approveConsignment(String id, double giaDuocDuyet, double phanTramHoaHong) async {
    final batch = FirebaseFirestore.instance.batch();

    final consignmentRef = FirebaseFirestore.instance.collection('consignments').doc(id);
    batch.update(consignmentRef, {
      'giaDuocDuyet': giaDuocDuyet,
      'phanTramHoaHong': phanTramHoaHong,
      'trangThai': 'DA_DUYET',
      'ngayBatDau': DateTime.now().toIso8601String(),
      'ngayKetThuc': DateTime.now().add(const Duration(days: 30)).toIso8601String(),
      'ghiChuAdmin': 'Đã duyệt giá $giaDuocDuyet và đăng bán. Hoa hồng: $phanTramHoaHong%',
    });

    final productIdx = _danhSachSanPham.indexWhere((p) => p.id == id);
    int existingTonKho = 1;
    if (productIdx != -1) {
      existingTonKho = _danhSachSanPham[productIdx].tonKho;
    }

    final productRef = FirebaseFirestore.instance.collection('products').doc(id);
    batch.update(productRef, {
      'gia': giaDuocDuyet,
      'trangThai': 'DANG_BAN',
      'tonKho': existingTonKho,
    });

    try {
      await batch.commit();
      
      // Gửi thông báo cho người ký gửi
      final consignmentIdx = _danhSachKyGui.indexWhere((k) => k.id == id);
      if (consignmentIdx != -1) {
        final consignment = _danhSachKyGui[consignmentIdx];
        sendNotification(
          nguoiDungId: consignment.nguoiDungId,
          tieuDe: 'Yêu cầu ký gửi được duyệt',
          noiDung: 'Yêu cầu ký gửi sản phẩm "${consignment.tenSanPham}" của bạn đã được duyệt với giá bán ${giaDuocDuyet.toVND()} và hoa hồng shop là ${phanTramHoaHong}%. Sản phẩm đã được đăng bán!',
          loai: 'KY_GUI',
        );
      }
    } catch (e) {
      print("Error approving consignment: $e");
    }
  }

  // Admin từ chối ký gửi
  void rejectConsignment(String id, String ghiChuAdmin) async {
    final batch = FirebaseFirestore.instance.batch();

    final consignmentRef = FirebaseFirestore.instance.collection('consignments').doc(id);
    batch.update(consignmentRef, {
      'trangThai': 'BI_TU_CHOI',
      'ghiChuAdmin': ghiChuAdmin,
    });

    final productRef = FirebaseFirestore.instance.collection('products').doc(id);
    batch.update(productRef, {
      'trangThai': 'BI_TU_CHOI',
      'tonKho': 0,
    });

    try {
      await batch.commit();
      
      // Gửi thông báo cho người ký gửi
      final consignmentIdx = _danhSachKyGui.indexWhere((k) => k.id == id);
      if (consignmentIdx != -1) {
        final consignment = _danhSachKyGui[consignmentIdx];
        sendNotification(
          nguoiDungId: consignment.nguoiDungId,
          tieuDe: 'Yêu cầu ký gửi bị từ chối',
          noiDung: 'Yêu cầu ký gửi sản phẩm "${consignment.tenSanPham}" của bạn bị từ chối. Lý do: $ghiChuAdmin',
          loai: 'KY_GUI',
        );
      }
    } catch (e) {
      print("Error rejecting consignment: $e");
    }
  }

  // Cập nhật trạng thái đơn hàng (Nếu đổi thành HOAN_THANH thì tính hoa hồng chia tiền)
  void updateOrderStatus(String orderId, String newStatus) async {
    final orderIdx = _danhSachDonHang.indexWhere((o) => o.id == orderId);
    if (orderIdx == -1) return;

    final donHang = _danhSachDonHang[orderIdx];
    final oldStatus = donHang.trangThai;

    final batch = FirebaseFirestore.instance.batch();

    // 1. Cập nhật trạng thái đơn hàng
    final orderRef = FirebaseFirestore.instance.collection('orders').doc(orderId);
    batch.update(orderRef, {'trangThai': newStatus});

    // Chỉ thực hiện chia tiền nếu chuyển sang HOAN_THANH từ trạng thái khác
    if (newStatus == 'HOAN_THANH' && oldStatus != 'HOAN_THANH') {
      final items = _danhSachChiTietDonHang.where((item) => item.donHangId == orderId).toList();
      
      for (var item in items) {
        final productIdx = _danhSachSanPham.indexWhere((p) => p.id == item.sanPhamId);
        if (productIdx != -1) {
          final product = _danhSachSanPham[productIdx];
          
          // Nếu sản phẩm thuộc về người ký gửi (nguoiBanId != SHOP_01)
          if (product.nguoiBanId != 'SHOP_01') {
            final consignmentIdx = _danhSachKyGui.indexWhere((k) => k.id == product.id);
            if (consignmentIdx != -1) {
              final consignment = _danhSachKyGui[consignmentIdx];

              if (consignment.trangThai == 'DA_DUYET' || consignment.trangThai == 'DANG_BAN' || consignment.trangThai == 'DA_BAN') {
                final indexNguoiBan = consignment.nguoiDungId;
                final rate = consignment.phanTramHoaHong; // VD: 30%
                final doanhThuSp = item.gia * item.soLuong;

                final hoaHongShop = doanhThuSp * (rate / 100);
                final tienNguoiKyGui = doanhThuSp - hoaHongShop;

                // Cộng tiền vào ví của người ký gửi
                final walletIdx = _danhSachVi.indexWhere((v) => v.nguoiDungId == indexNguoiBan);
                String walletId = 'V_$indexNguoiBan';
                if (walletIdx != -1) {
                  walletId = _danhSachVi[walletIdx].id;
                }
                
                final walletRef = FirebaseFirestore.instance.collection('wallets').doc(walletId);
                
                if (walletIdx == -1) {
                  final newWallet = ViModel(
                    id: walletId,
                    nguoiDungId: indexNguoiBan,
                    soDu: tienNguoiKyGui,
                    soDuDangCho: 0,
                    soDuCoTheRut: tienNguoiKyGui,
                    ngayCapNhat: DateTime.now(),
                  );
                  batch.set(walletRef, newWallet.thanhJson());
                } else {
                  batch.update(walletRef, {
                    'soDu': FieldValue.increment(tienNguoiKyGui),
                    'soDuCoTheRut': FieldValue.increment(tienNguoiKyGui),
                    'ngayCapNhat': DateTime.now().toIso8601String(),
                  });
                }

                // Lưu lịch sử giao dịch ví của người ký gửi
                final txId = 'GD_${DateTime.now().millisecondsSinceEpoch}_${product.id}';
                final txRef = FirebaseFirestore.instance.collection('transactions').doc(txId);
                final newGiaoDich = GiaoDichModel(
                  id: txId,
                  viId: walletId,
                  loai: 'NHAN_TIEN_KY_GUI',
                  soTien: tienNguoiKyGui,
                  moTa: 'Bán thành công sản phẩm: ${product.ten} (Hoa hồng shop: ${rate.toStringAsFixed(0)}%)',
                  trangThai: 'THANH_CONG',
                  ngayTao: DateTime.now(),
                );
                batch.set(txRef, newGiaoDich.thanhJson());

                final consignmentRef = FirebaseFirestore.instance.collection('consignments').doc(consignment.id);
                final productRef = FirebaseFirestore.instance.collection('products').doc(product.id);

                if (product.tonKho <= 0) {
                  // Cập nhật trạng thái sản phẩm ký gửi thành DA_BAN
                  batch.update(consignmentRef, {'trangThai': 'DA_BAN'});
                  // Cập nhật trạng thái sản phẩm thành DA_BAN và hết hàng
                  batch.update(productRef, {'trangThai': 'DA_BAN', 'tonKho': 0});
                } else {
                  // Vẫn còn hàng, giữ trạng thái đang bán
                  batch.update(consignmentRef, {'trangThai': 'DANG_BAN'});
                  batch.update(productRef, {'trangThai': 'DANG_BAN'});
                }
              }
            }
          }
        }
      }
    }
    // Nếu huỷ đơn hàng thì hoàn lại tồn kho cho sản phẩm
    if (newStatus == 'DA_HUY' && oldStatus != 'DA_HUY') {
      final items = _danhSachChiTietDonHang.where((item) => item.donHangId == orderId).toList();
      for (var item in items) {
        final productIdx = _danhSachSanPham.indexWhere((p) => p.id == item.sanPhamId);
        if (productIdx != -1) {
          final product = _danhSachSanPham[productIdx];
          final productRef = FirebaseFirestore.instance.collection('products').doc(product.id);
          final newTonKho = product.tonKho + item.soLuong;

          // Nếu sản phẩm từng hết hàng (DA_BAN) thì khôi phục lại trạng thái bán
          if (product.trangThai == 'DA_BAN') {
            batch.update(productRef, {
              'tonKho': newTonKho,
              'trangThai': 'DANG_BAN',
            });
          } else {
            batch.update(productRef, {
              'tonKho': newTonKho,
            });
          }
        }
      }
    }

    try {
      await batch.commit();

      // Gửi thông báo sau khi cập nhật đơn hàng thành công trên Firestore
      // 1. Cho người mua về trạng thái đơn hàng
      String tieuDeDonHang = 'Cập nhật đơn hàng';
      String noiDungDonHang = '';
      if (newStatus == 'DANG_GIAO') {
        tieuDeDonHang = 'Đơn hàng đang giao';
        noiDungDonHang = 'Đơn hàng $orderId của bạn đang được giao. Vui lòng chú ý điện thoại nhận hàng!';
      } else if (newStatus == 'HOAN_THANH') {
        tieuDeDonHang = 'Đơn hàng hoàn thành';
        noiDungDonHang = 'Đơn hàng $orderId của bạn đã được giao thành công. Cảm ơn bạn đã mua sắm!';
      } else if (newStatus == 'DA_HUY') {
        tieuDeDonHang = 'Đơn hàng đã hủy';
        noiDungDonHang = 'Đơn hàng $orderId của bạn đã bị hủy thành công.';
      }

      if (noiDungDonHang.isNotEmpty) {
        sendNotification(
          nguoiDungId: donHang.nguoiDungId,
          tieuDe: tieuDeDonHang,
          noiDung: noiDungDonHang,
          loai: 'DON_HANG',
        );
      }

      // 2. Cho người ký gửi nếu sản phẩm của họ được bán thành công (khi đơn hàng chuyển sang HOAN_THANH)
      if (newStatus == 'HOAN_THANH' && oldStatus != 'HOAN_THANH') {
        final items = _danhSachChiTietDonHang.where((item) => item.donHangId == orderId).toList();
        for (var item in items) {
          final productIdx = _danhSachSanPham.indexWhere((p) => p.id == item.sanPhamId);
          if (productIdx != -1) {
            final product = _danhSachSanPham[productIdx];
            if (product.nguoiBanId != 'SHOP_01') {
              final consignmentIdx = _danhSachKyGui.indexWhere((k) => k.id == product.id);
              if (consignmentIdx != -1) {
                final consignment = _danhSachKyGui[consignmentIdx];
                final indexNguoiBan = consignment.nguoiDungId;
                final rate = consignment.phanTramHoaHong;
                final doanhThuSp = item.gia * item.soLuong;
                final hoaHongShop = doanhThuSp * (rate / 100);
                final tienNguoiKyGui = doanhThuSp - hoaHongShop;

                sendNotification(
                  nguoiDungId: indexNguoiBan,
                  tieuDe: 'Sản phẩm ký gửi đã bán thành công',
                  noiDung: 'Sản phẩm "${product.ten}" của bạn đã bán thành công! +${tienNguoiKyGui.toVND()} đã được cộng vào ví.',
                  loai: 'VI_TIEN',
                );
              }
            }
          }
        }
      }
    } catch (e) {
      print("Error updating order status: $e");
    }
  }

  // Người ký gửi gửi yêu cầu rút tiền
  bool requestWithdrawal({
    required double amount,
    required String bankName,
    required String bankAccount,
    required String accountHolder,
  }) {
    final vi = viCuaToi;
    if (vi == null || vi.soDuCoTheRut < amount || amount <= 0) {
      return false;
    }

    final batch = FirebaseFirestore.instance.batch();

    // 1. Khóa số tiền rút (trừ số dư có thể rút, cộng vào số dư đang chờ xử lý)
    final walletRef = FirebaseFirestore.instance.collection('wallets').doc(vi.id);
    batch.update(walletRef, {
      'soDuDangCho': FieldValue.increment(amount),
      'soDuCoTheRut': FieldValue.increment(-amount),
      'ngayCapNhat': DateTime.now().toIso8601String(),
    });

    // 2. Tạo bản ghi giao dịch với trạng thái 'CHO_XAC_NHAN'
    final txId = 'WT_${DateTime.now().millisecondsSinceEpoch}';
    final txRef = FirebaseFirestore.instance.collection('transactions').doc(txId);
    final newGiaoDich = GiaoDichModel(
      id: txId,
      viId: vi.id,
      loai: 'RUT_TIEN',
      soTien: amount,
      moTa: 'Rút về $bankName - STK: $bankAccount - Tên: $accountHolder',
      trangThai: 'CHO_XAC_NHAN',
      ngayTao: DateTime.now(),
    );
    batch.set(txRef, newGiaoDich.thanhJson());

    batch.commit().then((_) {
      sendNotification(
        nguoiDungId: adminUserId,
        tieuDe: 'Yêu cầu rút tiền mới',
        noiDung: 'Khách hàng ${_currentUser?.ten ?? "Ẩn danh"} đã tạo yêu cầu rút số tiền ${amount.toVND()} về tài khoản ngân hàng.',
        loai: 'VI_TIEN',
      );
    }).catchError((e) {
      print("Error creating withdrawal request: $e");
    });
    
    return true;
  }

  // Admin xác nhận thanh toán (sau khi chuyển khoản thực tế)
  void approveWithdrawal(String transactionId) async {
    final txIdx = _danhSachGiaoDich.indexWhere((g) => g.id == transactionId);
    if (txIdx == -1) return;

    final tx = _danhSachGiaoDich[txIdx];
    if (tx.trangThai != 'CHO_XAC_NHAN') return;

    final batch = FirebaseFirestore.instance.batch();

    // 1. Cập nhật trạng thái giao dịch ví thành THANH_CONG
    final txRef = FirebaseFirestore.instance.collection('transactions').doc(tx.id);
    batch.update(txRef, {'trangThai': 'THANH_CONG'});

    // 2. Trừ số dư tổng và số dư đang chờ xử lý của người dùng
    final walletRef = FirebaseFirestore.instance.collection('wallets').doc(tx.viId);
    batch.update(walletRef, {
      'soDu': FieldValue.increment(-tx.soTien),
      'soDuDangCho': FieldValue.increment(-tx.soTien),
      'ngayCapNhat': DateTime.now().toIso8601String(),
    });

    try {
      await batch.commit();

      // Gửi thông báo cho người ký gửi
      final wallet = _danhSachVi.firstWhere((v) => v.id == tx.viId);
      sendNotification(
        nguoiDungId: wallet.nguoiDungId,
        tieuDe: 'Yêu cầu rút tiền thành công',
        noiDung: 'Yêu cầu rút số tiền ${tx.soTien.toVND()} đã được Admin xác nhận thanh toán chuyển khoản thành công.',
        loai: 'VI_TIEN',
      );
    } catch (e) {
      print("Error approving withdrawal: $e");
    }
  }

  // Admin từ chối yêu cầu rút tiền (do sai thông tin, đối soát không khớp,...)
  void rejectWithdrawal(String transactionId) async {
    final txIdx = _danhSachGiaoDich.indexWhere((g) => g.id == transactionId);
    if (txIdx == -1) return;

    final tx = _danhSachGiaoDich[txIdx];
    if (tx.trangThai != 'CHO_XAC_NHAN') return;

    final batch = FirebaseFirestore.instance.batch();

    // 1. Cập nhật trạng thái giao dịch ví thành THAT_BAI
    final txRef = FirebaseFirestore.instance.collection('transactions').doc(tx.id);
    batch.update(txRef, {
      'trangThai': 'THAT_BAI',
      'moTa': '${tx.moTa} (Từ chối bởi Admin)',
    });

    // 2. Hoàn lại tiền cho ví người dùng (trả từ đang chờ về lại có thể rút)
    final walletRef = FirebaseFirestore.instance.collection('wallets').doc(tx.viId);
    batch.update(walletRef, {
      'soDuDangCho': FieldValue.increment(-tx.soTien),
      'soDuCoTheRut': FieldValue.increment(tx.soTien),
      'ngayCapNhat': DateTime.now().toIso8601String(),
    });

    try {
      await batch.commit();

      // Gửi thông báo cho người ký gửi
      final wallet = _danhSachVi.firstWhere((v) => v.id == tx.viId);
      sendNotification(
        nguoiDungId: wallet.nguoiDungId,
        tieuDe: 'Yêu cầu rút tiền bị từ chối',
        noiDung: 'Yêu cầu rút số tiền ${tx.soTien.toVND()} của bạn đã bị từ chối. Số tiền đã được hoàn trả lại ví của bạn.',
        loai: 'VI_TIEN',
      );
    } catch (e) {
      print("Error rejecting withdrawal: $e");
    }
  }

  // Admin report stats
  int get adminTotalOrdersCount => _danhSachDonHang.where((o) => o.trangThai == 'HOAN_THANH').length;
  int get adminTotalUsersCount => _danhSachNguoiDung.where((u) => u.vaiTro == 'USER').length;
  int get adminTotalConsignmentsCount => _danhSachKyGui.length;

  double get adminTotalRevenue {
    double total = 0;
    final completedOrders = _danhSachDonHang.where((o) => o.trangThai == 'HOAN_THANH').toList();
    for (var order in completedOrders) {
      final details = _danhSachChiTietDonHang.where((d) => d.donHangId == order.id).toList();
      for (var detail in details) {
        final productIndex = _danhSachSanPham.indexWhere((p) => p.id == detail.sanPhamId);
        if (productIndex != -1) {
          final product = _danhSachSanPham[productIndex];
          if (product.nguoiBanId == 'SHOP_01') {
            total += detail.gia * detail.soLuong;
          } else {
            final consignmentIndex = _danhSachKyGui.indexWhere((k) => k.id == product.id);
            if (consignmentIndex != -1) {
              final consignment = _danhSachKyGui[consignmentIndex];
              total += (detail.gia * detail.soLuong) * (consignment.phanTramHoaHong / 100);
            }
          }
        }
      }
    }
    return total;
  }

  double get adminTotalCommissionEarned {
    double total = 0;
    final completedOrders = _danhSachDonHang.where((o) => o.trangThai == 'HOAN_THANH').toList();
    for (var order in completedOrders) {
      final details = _danhSachChiTietDonHang.where((d) => d.donHangId == order.id).toList();
      for (var detail in details) {
        final productIndex = _danhSachSanPham.indexWhere((p) => p.id == detail.sanPhamId);
        if (productIndex != -1) {
          final product = _danhSachSanPham[productIndex];
          if (product.nguoiBanId != 'SHOP_01') {
            final consignmentIndex = _danhSachKyGui.indexWhere((k) => k.id == product.id);
            if (consignmentIndex != -1) {
              final consignment = _danhSachKyGui[consignmentIndex];
              total += (detail.gia * detail.soLuong) * (consignment.phanTramHoaHong / 100);
            }
          }
        }
      }
    }
    return total;
  }

  Future<void> createProductByAdmin({
    required String ten,
    required String moTa,
    required double gia,
    required double giaGoc,
    required int phanTramGiamGia,
    required String brand,
    required String category,
    required String size,
    required String condition,
    required List<String> images,
    required int soLuong,
  }) async {
    final id = 'SP_${DateTime.now().millisecondsSinceEpoch}';
    final newSanPham = SanPhamModel(
      id: id,
      ten: ten,
      moTa: moTa,
      gia: gia,
      giaGoc: giaGoc,
      phanTramGiamGia: phanTramGiamGia,
      hinhAnh: images.isEmpty ? ['https://images.unsplash.com/photo-1595777457583-95e059d581b8'] : images,
      thuongHieuId: brand,
      danhMucId: category,
      kichThuoc: size,
      tinhTrang: condition,
      trangThai: 'DANG_BAN',
      tonKho: soLuong,
      noiBat: false,
      nguoiBanId: 'SHOP_01',
      ngayTao: DateTime.now(),
    );

    try {
      await FirebaseFirestore.instance.collection('products').doc(id).set(newSanPham.thanhJson());
    } catch (e) {
      print("Error creating product by admin: $e");
    }
  }

  void deleteProduct(String id) async {
    final batch = FirebaseFirestore.instance.batch();
    
    // 1. Xóa sản phẩm khỏi collection products
    final productRef = FirebaseFirestore.instance.collection('products').doc(id);
    batch.delete(productRef);

    // 2. Xóa consignment tương ứng nếu tồn tại
    final consignmentRef = FirebaseFirestore.instance.collection('consignments').doc(id);
    batch.delete(consignmentRef);

    try {
      await batch.commit();
    } catch (e) {
      print("Error deleting product: $e");
    }
  }

  Future<void> toggleUserBlockStatus(String userId, String currentStatus) async {
    final newStatus = currentStatus == 'BLOCKED' ? 'ACTIVE' : 'BLOCKED';
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'trangThai': newStatus,
      });
    } catch (e) {
      print("Error toggling user block status: $e");
    }
  }

  Future<void> updateUserRole(String userId, String newRole) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'vaiTro': newRole,
      });
    } catch (e) {
      print("Error updating user role: $e");
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).delete();
    } catch (e) {
      print("Error deleting user: $e");
    }
  }

  // Đổi mật khẩu tài khoản hiện tại qua Firebase Auth (có xác thực mật khẩu cũ)
  Future<String?> changePassword(String oldPassword, String newPassword) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || user.email == null) {
      return 'Không tìm thấy thông tin đăng nhập hiện tại!';
    }

    try {
      // 1. Tạo thông tin xác thực lại bằng mật khẩu cũ
      final AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: oldPassword,
      );

      // 2. Xác thực lại với Firebase Auth
      await user.reauthenticateWithCredential(credential);

      // 3. Tiến hành đổi sang mật khẩu mới
      await user.updatePassword(newPassword);
      return null; // Thành công
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        return 'Mật khẩu cũ không đúng!';
      }
      return 'Lỗi đổi mật khẩu: ${e.message}';
    } catch (e) {
      return 'Lỗi đổi mật khẩu: ${e.toString()}';
    }
  }

  // Bật/tắt trạng thái nổi bật (noiBat) của sản phẩm trong Firestore
  Future<void> toggleProductFeaturedStatus(String productId, bool currentFeatured) async {
    try {
      await FirebaseFirestore.instance.collection('products').doc(productId).update({
        'noiBat': !currentFeatured,
      });
    } catch (e) {
      print("Error toggling product featured status: $e");
    }
  }

  // Gửi thông báo mới lên Firestore
  Future<void> sendNotification({
    required String nguoiDungId,
    required String tieuDe,
    required String noiDung,
    required String loai,
  }) async {
    try {
      final id = 'TB_${DateTime.now().millisecondsSinceEpoch}';
      final newThongBao = ThongBaoModel(
        id: id,
        nguoiDungId: nguoiDungId,
        tieuDe: tieuDe,
        noiDung: noiDung,
        loai: loai,
        daDoc: false,
        ngayTao: DateTime.now(),
      );
      await FirebaseFirestore.instance.collection('notifications').doc(id).set(newThongBao.thanhJson());
    } catch (e) {
      print("Error sending notification: $e");
    }
  }

  // Đánh dấu thông báo đã đọc
  Future<void> markNotificationAsRead(String id) async {
    try {
      await FirebaseFirestore.instance.collection('notifications').doc(id).update({'daDoc': true});
    } catch (e) {
      print("Error marking notification as read: $e");
    }
  }

  // Đánh dấu đọc tất cả thông báo của người dùng hiện tại
  Future<void> markAllNotificationsAsRead() async {
    if (_currentUser == null) return;
    try {
      final unreads = thongBaoCuaToi.where((t) => !t.daDoc).toList();
      if (unreads.isEmpty) return;

      final batch = FirebaseFirestore.instance.batch();
      for (var t in unreads) {
        batch.update(FirebaseFirestore.instance.collection('notifications').doc(t.id), {'daDoc': true});
      }
      await batch.commit();
    } catch (e) {
      print("Error marking all notifications as read: $e");
    }
  }
}
