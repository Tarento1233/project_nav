import 'package:flutter/material.dart';

import '../core/services/mock_database.dart';
import '../models/product_model.dart';
import '../models/order_model.dart';
import '../models/order_item_model.dart';
import '../models/consignment_model.dart';
import '../models/wallet_model.dart';
import '../models/transaction_model.dart';
import '../models/user_model.dart';
import '../models/cart_model.dart';

class StoreProvider extends ChangeNotifier {
  NguoiDungModel? _currentUser;
  
  // Giỏ hàng
  final List<GioHangModel> _danhSachGioHang = [];

  List<GioHangModel> get danhSachGioHangCaNhan {
    if (_currentUser == null) return [];
    return _danhSachGioHang.where((item) => item.nguoiDungId == _currentUser!.id).toList();
  }

  // Thêm vào giỏ hàng
  void addToCart(SanPhamModel sanPham, String size, {int soLuong = 1}) {
    if (_currentUser == null) return;
    
    // Tìm xem sản phẩm đã có trong giỏ hàng với cùng size chưa
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

  // Đặt hàng (Thanh toán)
  String? checkout(String phuongThucThanhToan) {
    if (_currentUser == null || danhSachGioHangCaNhan.isEmpty) return null;

    final orderId = 'DH_${DateTime.now().millisecondsSinceEpoch}';
    final items = List<GioHangModel>.from(danhSachGioHangCaNhan);
    final total = cartTotal;

    // 1. Tạo đơn hàng mới
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

    // 2. Tạo chi tiết đơn hàng
    for (var item in items) {
      final sanPham = danhSachSanPham.firstWhere((p) => p.id == item.sanPhamId);
      final newDetail = ChiTietDonHangModel(
        id: 'CT_${DateTime.now().millisecondsSinceEpoch}_${item.sanPhamId}',
        donHangId: orderId,
        sanPhamId: item.sanPhamId,
        gia: sanPham.gia,
        soLuong: item.soLuong,
        tamTinh: sanPham.gia * item.soLuong,
      );
      danhSachChiTietDonHang.add(newDetail);
    }

    // 3. Thêm đơn hàng vào danh sách đơn hàng
    danhSachDonHang.add(newOrder);

    // 4. Xóa giỏ hàng của người dùng hiện tại
    _danhSachGioHang.removeWhere((item) => item.nguoiDungId == _currentUser!.id);

    notifyListeners();
    return orderId;
  }

  StoreProvider() {
    // Đăng nhập mặc định bằng User Nguyễn Văn A để dễ kiểm thử ban đầu
    _currentUser = MockDatabase.instance.danhSachNguoiDung.firstWhere((u) => u.id == 'USER01');
  }

  // Getters cho dữ liệu hiện tại
  NguoiDungModel? get currentUser => _currentUser;
  bool get isAdmin => _currentUser?.vaiTro == 'ADMIN';

  // Getters danh sách dữ liệu giả lập từ MockDatabase
  List<NguoiDungModel> get danhSachNguoiDung => MockDatabase.instance.danhSachNguoiDung;
  List<KyGuiModel> get danhSachKyGui => MockDatabase.instance.danhSachKyGui;
  List<SanPhamModel> get danhSachSanPham => MockDatabase.instance.danhSachSanPham;
  List<DonHangModel> get danhSachDonHang => MockDatabase.instance.danhSachDonHang;
  List<ChiTietDonHangModel> get danhSachChiTietDonHang => MockDatabase.instance.danhSachChiTietDonHang;
  List<ViModel> get danhSachVi => MockDatabase.instance.danhSachVi;
  List<GiaoDichModel> get danhSachGiaoDich => MockDatabase.instance.danhSachGiaoDich;

  // Lấy ví của tài khoản hiện hành
  ViModel? get viCuaToi {
    if (_currentUser == null) return null;
    return danhSachVi.firstWhere(
      (v) => v.nguoiDungId == _currentUser!.id,
      orElse: () {
        // Nếu chưa có ví thì tạo mới ví 0đ
        final newWallet = ViModel(
          id: 'V_${_currentUser!.id}',
          nguoiDungId: _currentUser!.id,
          soDu: 0,
          soDuDangCho: 0,
          soDuCoTheRut: 0,
          ngayCapNhat: DateTime.now(),
        );
        danhSachVi.add(newWallet);
        return newWallet;
      },
    );
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
    return danhSachKyGui.where((k) => k.nguoiDungId == _currentUser!.id).toList()
      ..sort((a, b) => b.ngayTao.compareTo(a.ngayTao));
  }

  // Chuyển đổi vai trò người dùng (Đăng nhập)
  void switchUser(String userId) {
    _currentUser = danhSachNguoiDung.firstWhere((u) => u.id == userId);
    notifyListeners();
  }

  // Tạo yêu cầu ký gửi mới (Tạo đồng thời KyGuiModel và SanPhamModel bản nháp)
  void createConsignmentRequest({
    required String ten,
    required String moTa,
    required double giaMongMuon,
    required String brand,
    required String category,
    required String size,
    required String condition,
    required List<String> images,
  }) {
    final id = 'KG_${DateTime.now().millisecondsSinceEpoch}';
    final user = _currentUser ?? danhSachNguoiDung.firstWhere((u) => u.id == 'USER01');

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
      tonKho: 1,
      noiBat: false,
      nguoiBanId: user.id,
      ngayTao: DateTime.now(),
    );

    danhSachKyGui.add(newKyGui);
    danhSachSanPham.add(newSanPham);
    notifyListeners();
  }

  // Admin duyệt ký gửi, quy định giá duyệt và % hoa hồng
  void approveConsignment(String id, double giaDuocDuyet, double phanTramHoaHong) {
    // 1. Cập nhật thỏa thuận ký gửi
    final indexKyGui = danhSachKyGui.indexWhere((k) => k.id == id);
    if (indexKyGui != -1) {
      final k = danhSachKyGui[indexKyGui];
      danhSachKyGui[indexKyGui] = KyGuiModel(
        id: k.id,
        nguoiDungId: k.nguoiDungId,
        tenSanPham: k.tenSanPham,
        moTa: k.moTa,
        hinhAnh: k.hinhAnh,
        giaMongMuon: k.giaMongMuon,
        giaDuocDuyet: giaDuocDuyet,
        phanTramHoaHong: phanTramHoaHong,
        trangThai: 'DA_DUYET',
        ngayBatDau: DateTime.now(),
        ngayKetThuc: DateTime.now().add(const Duration(days: 30)),
        ghiChuAdmin: 'Đã duyệt giá $giaDuocDuyet và đăng bán. Hoa hồng: $phanTramHoaHong%',
        ngayTao: k.ngayTao,
      );
    }

    // 2. Cập nhật sản phẩm để hiển thị bán trên shop
    final indexSanPham = danhSachSanPham.indexWhere((s) => s.id == id);
    if (indexSanPham != -1) {
      final s = danhSachSanPham[indexSanPham];
      danhSachSanPham[indexSanPham] = SanPhamModel(
        id: s.id,
        ten: s.ten,
        moTa: s.moTa,
        gia: giaDuocDuyet,
        giaGoc: s.giaGoc,
        phanTramGiamGia: 0,
        hinhAnh: s.hinhAnh,
        thuongHieuId: s.thuongHieuId,
        danhMucId: s.danhMucId,
        kichThuoc: s.kichThuoc,
        tinhTrang: s.tinhTrang,
        trangThai: 'DANG_BAN',
        tonKho: 1,
        noiBat: s.noiBat,
        nguoiBanId: s.nguoiBanId,
        ngayTao: s.ngayTao,
      );
    }

    notifyListeners();
  }

  // Admin từ chối ký gửi
  void rejectConsignment(String id, String ghiChuAdmin) {
    // 1. Cập nhật thỏa thuận ký gửi
    final indexKyGui = danhSachKyGui.indexWhere((k) => k.id == id);
    if (indexKyGui != -1) {
      final k = danhSachKyGui[indexKyGui];
      danhSachKyGui[indexKyGui] = KyGuiModel(
        id: k.id,
        nguoiDungId: k.nguoiDungId,
        tenSanPham: k.tenSanPham,
        moTa: k.moTa,
        hinhAnh: k.hinhAnh,
        giaMongMuon: k.giaMongMuon,
        giaDuocDuyet: 0,
        phanTramHoaHong: 0,
        trangThai: 'BI_TU_CHOI',
        ngayBatDau: k.ngayBatDau,
        ngayKetThuc: k.ngayKetThuc,
        ghiChuAdmin: ghiChuAdmin,
        ngayTao: k.ngayTao,
      );
    }

    // 2. Cập nhật sản phẩm
    final indexSanPham = danhSachSanPham.indexWhere((s) => s.id == id);
    if (indexSanPham != -1) {
      final s = danhSachSanPham[indexSanPham];
      danhSachSanPham[indexSanPham] = SanPhamModel(
        id: s.id,
        ten: s.ten,
        moTa: s.moTa,
        gia: s.gia,
        giaGoc: s.giaGoc,
        phanTramGiamGia: s.phanTramGiamGia,
        hinhAnh: s.hinhAnh,
        thuongHieuId: s.thuongHieuId,
        danhMucId: s.danhMucId,
        kichThuoc: s.kichThuoc,
        tinhTrang: s.tinhTrang,
        trangThai: 'BI_TU_CHOI',
        tonKho: 0,
        noiBat: s.noiBat,
        nguoiBanId: s.nguoiBanId,
        ngayTao: s.ngayTao,
      );
    }

    notifyListeners();
  }

  // Cập nhật trạng thái đơn hàng (Nếu đổi thành HOAN_THANH thì tính hoa hồng chia tiền)
  void updateOrderStatus(String orderId, String newStatus) {
    final indexOrder = danhSachDonHang.indexWhere((o) => o.id == orderId);
    if (indexOrder == -1) return;

    final donHang = danhSachDonHang[indexOrder];
    final oldStatus = donHang.trangThai;

    // Chỉ thực hiện chia tiền nếu chuyển sang HOAN_THANH từ trạng thái khác
    if (newStatus == 'HOAN_THANH' && oldStatus != 'HOAN_THANH') {
      // 1. Quét tìm các sản phẩm ký gửi trong đơn hàng
      final items = danhSachChiTietDonHang.where((item) => item.donHangId == orderId).toList();
      for (var item in items) {
        final product = danhSachSanPham.firstWhere((p) => p.id == item.sanPhamId);
        
        // Nếu sản phẩm thuộc về người ký gửi (nguoiBanId != SHOP_01)
        if (product.nguoiBanId != 'SHOP_01') {
          // Tìm thỏa thuận ký gửi tương ứng
          final consignmentIndex = danhSachKyGui.indexWhere((k) => k.id == product.id);
          if (consignmentIndex != -1) {
            final consignment = danhSachKyGui[consignmentIndex];

            if (consignment.trangThai == 'DA_DUYET') {
              // 2. Tính hoa hồng và chia tiền
              final indexNguoiBan = consignment.nguoiDungId;
              final rate = consignment.phanTramHoaHong; // VD: 30%
              final donGia = item.gia;
              final soLuong = item.soLuong;
              final doanhThuSp = donGia * soLuong;

              final hoaHongShop = doanhThuSp * (rate / 100);
              final tienNguoiKyGui = doanhThuSp - hoaHongShop;

              // 3. Cộng tiền vào ví của người ký gửi
              final walletIndex = danhSachVi.indexWhere((v) => v.nguoiDungId == indexNguoiBan);
              late ViModel wallet;
              if (walletIndex == -1) {
                wallet = ViModel(
                  id: 'V_$indexNguoiBan',
                  nguoiDungId: indexNguoiBan,
                  soDu: tienNguoiKyGui,
                  soDuDangCho: 0,
                  soDuCoTheRut: tienNguoiKyGui,
                  ngayCapNhat: DateTime.now(),
                );
                danhSachVi.add(wallet);
              } else {
                final w = danhSachVi[walletIndex];
                wallet = ViModel(
                  id: w.id,
                  nguoiDungId: w.nguoiDungId,
                  soDu: w.soDu + tienNguoiKyGui,
                  soDuDangCho: w.soDuDangCho,
                  soDuCoTheRut: w.soDuCoTheRut + tienNguoiKyGui,
                  ngayCapNhat: DateTime.now(),
                );
                danhSachVi[walletIndex] = wallet;
              }

              // 4. Lưu lịch sử giao dịch ví của người ký gửi
              final newGiaoDich = GiaoDichModel(
                id: 'GD_${DateTime.now().millisecondsSinceEpoch}_${product.id}',
                viId: wallet.id,
                loai: 'NHAN_TIEN_KY_GUI',
                soTien: tienNguoiKyGui,
                moTa: 'Bán thành công sản phẩm: ${product.ten} (Hoa hồng shop: ${rate.toStringAsFixed(0)}%)',
                trangThai: 'THANH_CONG',
                ngayTao: DateTime.now(),
              );
              danhSachGiaoDich.add(newGiaoDich);

              // 5. Cập nhật trạng thái sản phẩm ký gửi thành DA_BAN
              danhSachKyGui[consignmentIndex] = KyGuiModel(
                id: consignment.id,
                nguoiDungId: consignment.nguoiDungId,
                tenSanPham: consignment.tenSanPham,
                moTa: consignment.moTa,
                hinhAnh: consignment.hinhAnh,
                giaMongMuon: consignment.giaMongMuon,
                giaDuocDuyet: consignment.giaDuocDuyet,
                phanTramHoaHong: consignment.phanTramHoaHong,
                trangThai: 'DA_BAN',
                ngayBatDau: consignment.ngayBatDau,
                ngayKetThuc: consignment.ngayKetThuc,
                ghiChuAdmin: consignment.ghiChuAdmin,
                ngayTao: consignment.ngayTao,
              );

              final pIndex = danhSachSanPham.indexWhere((p) => p.id == product.id);
              if (pIndex != -1) {
                final p = danhSachSanPham[pIndex];
                danhSachSanPham[pIndex] = SanPhamModel(
                  id: p.id,
                  ten: p.ten,
                  moTa: p.moTa,
                  gia: p.gia,
                  giaGoc: p.giaGoc,
                  phanTramGiamGia: p.phanTramGiamGia,
                  hinhAnh: p.hinhAnh,
                  thuongHieuId: p.thuongHieuId,
                  danhMucId: p.danhMucId,
                  kichThuoc: p.kichThuoc,
                  tinhTrang: p.tinhTrang,
                  trangThai: 'DA_BAN',
                  tonKho: 0,
                  noiBat: p.noiBat,
                  nguoiBanId: p.nguoiBanId,
                  ngayTao: p.ngayTao,
                );
              }
            }
          }
        }
      }
    }

    // Cập nhật trạng thái đơn hàng
    danhSachDonHang[indexOrder] = DonHangModel(
      id: donHang.id,
      nguoiDungId: donHang.nguoiDungId,
      diaChiId: donHang.diaChiId,
      tongTien: donHang.tongTien,
      phiVanChuyen: donHang.phiVanChuyen,
      phuongThucThanhToan: donHang.phuongThucThanhToan,
      trangThai: newStatus,
      ngayTao: donHang.ngayTao,
    );

    notifyListeners();
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

    // 1. Khóa số tiền rút (trừ số dư có thể rút, cộng vào số dư đang chờ xử lý)
    final indexVi = danhSachVi.indexWhere((v) => v.id == vi.id);
    if (indexVi != -1) {
      danhSachVi[indexVi] = ViModel(
        id: vi.id,
        nguoiDungId: vi.nguoiDungId,
        soDu: vi.soDu, // Số dư tổng vẫn giữ nguyên cho đến khi Admin xác nhận rút thành công
        soDuDangCho: vi.soDuDangCho + amount,
        soDuCoTheRut: vi.soDuCoTheRut - amount,
        ngayCapNhat: DateTime.now(),
      );
    }

    // 2. Tạo bản ghi giao dịch với trạng thái 'CHO_XAC_NHAN'
    final newGiaoDich = GiaoDichModel(
      id: 'WT_${DateTime.now().millisecondsSinceEpoch}',
      viId: vi.id,
      loai: 'RUT_TIEN',
      soTien: amount,
      moTa: 'Rút về $bankName - STK: $bankAccount - Tên: $accountHolder',
      trangThai: 'CHO_XAC_NHAN',
      ngayTao: DateTime.now(),
    );

    danhSachGiaoDich.add(newGiaoDich);
    notifyListeners();
    return true;
  }

  // Admin xác nhận thanh toán (sau khi chuyển khoản thực tế)
  void approveWithdrawal(String transactionId) {
    final indexTx = danhSachGiaoDich.indexWhere((g) => g.id == transactionId);
    if (indexTx == -1) return;

    final tx = danhSachGiaoDich[indexTx];
    if (tx.trangThai != 'CHO_XAC_NHAN') return;

    // 1. Cập nhật trạng thái giao dịch ví thành THANH_CONG
    danhSachGiaoDich[indexTx] = GiaoDichModel(
      id: tx.id,
      viId: tx.viId,
      loai: tx.loai,
      soTien: tx.soTien,
      moTa: tx.moTa,
      trangThai: 'THANH_CONG',
      ngayTao: tx.ngayTao,
    );

    // 2. Trừ số dư tổng và số dư đang chờ xử lý của người dùng
    final indexVi = danhSachVi.indexWhere((v) => v.id == tx.viId);
    if (indexVi != -1) {
      final vi = danhSachVi[indexVi];
      danhSachVi[indexVi] = ViModel(
        id: vi.id,
        nguoiDungId: vi.nguoiDungId,
        soDu: vi.soDu - tx.soTien,
        soDuDangCho: vi.soDuDangCho - tx.soTien,
        soDuCoTheRut: vi.soDuCoTheRut,
        ngayCapNhat: DateTime.now(),
      );
    }

    notifyListeners();
  }

  // Admin từ chối yêu cầu rút tiền (do sai thông tin, đối soát không khớp,...)
  void rejectWithdrawal(String transactionId) {
    final indexTx = danhSachGiaoDich.indexWhere((g) => g.id == transactionId);
    if (indexTx == -1) return;

    final tx = danhSachGiaoDich[indexTx];
    if (tx.trangThai != 'CHO_XAC_NHAN') return;

    // 1. Cập nhật trạng thái giao dịch ví thành THAT_BAI
    danhSachGiaoDich[indexTx] = GiaoDichModel(
      id: tx.id,
      viId: tx.viId,
      loai: tx.loai,
      soTien: tx.soTien,
      moTa: '${tx.moTa} (Từ chối bởi Admin)',
      trangThai: 'THAT_BAI',
      ngayTao: tx.ngayTao,
    );

    // 2. Hoàn lại tiền cho ví người dùng (trả từ đang chờ về lại có thể rút)
    final indexVi = danhSachVi.indexWhere((v) => v.id == tx.viId);
    if (indexVi != -1) {
      final vi = danhSachVi[indexVi];
      danhSachVi[indexVi] = ViModel(
        id: vi.id,
        nguoiDungId: vi.nguoiDungId,
        soDu: vi.soDu,
        soDuDangCho: vi.soDuDangCho - tx.soTien,
        soDuCoTheRut: vi.soDuCoTheRut + tx.soTien,
        ngayCapNhat: DateTime.now(),
      );
    }

    notifyListeners();
  }

  // Admin report stats
  int get adminTotalOrdersCount => danhSachDonHang.where((o) => o.trangThai == 'HOAN_THANH').length;
  int get adminTotalUsersCount => danhSachNguoiDung.where((u) => u.vaiTro == 'USER').length;
  int get adminTotalConsignmentsCount => danhSachKyGui.length;

  double get adminTotalRevenue {
    double total = 0;
    final completedOrders = danhSachDonHang.where((o) => o.trangThai == 'HOAN_THANH').toList();
    for (var order in completedOrders) {
      final details = danhSachChiTietDonHang.where((d) => d.donHangId == order.id).toList();
      for (var detail in details) {
        final productIndex = danhSachSanPham.indexWhere((p) => p.id == detail.sanPhamId);
        if (productIndex != -1) {
          final product = danhSachSanPham[productIndex];
          if (product.nguoiBanId == 'SHOP_01') {
            total += detail.gia * detail.soLuong;
          } else {
            final consignmentIndex = danhSachKyGui.indexWhere((k) => k.id == product.id);
            if (consignmentIndex != -1) {
              final consignment = danhSachKyGui[consignmentIndex];
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
    final completedOrders = danhSachDonHang.where((o) => o.trangThai == 'HOAN_THANH').toList();
    for (var order in completedOrders) {
      final details = danhSachChiTietDonHang.where((d) => d.donHangId == order.id).toList();
      for (var detail in details) {
        final productIndex = danhSachSanPham.indexWhere((p) => p.id == detail.sanPhamId);
        if (productIndex != -1) {
          final product = danhSachSanPham[productIndex];
          if (product.nguoiBanId != 'SHOP_01') {
            final consignmentIndex = danhSachKyGui.indexWhere((k) => k.id == product.id);
            if (consignmentIndex != -1) {
              final consignment = danhSachKyGui[consignmentIndex];
              total += (detail.gia * detail.soLuong) * (consignment.phanTramHoaHong / 100);
            }
          }
        }
      }
    }
    return total;
  }
}
