import '../../models/product_model.dart';
import '../../models/order_model.dart';
import '../../models/order_item_model.dart';
import '../../models/consignment_model.dart';
import '../../models/wallet_model.dart';
import '../../models/transaction_model.dart';
import '../../models/user_model.dart';

class MockDatabase {
  static final MockDatabase instance = MockDatabase._internal();

  MockDatabase._internal() {
    _khoiTaoDuLieu();
  }

  late List<NguoiDungModel> danhSachNguoiDung;
  late List<KyGuiModel> danhSachKyGui;
  late List<SanPhamModel> danhSachSanPham;
  late List<DonHangModel> danhSachDonHang;
  late List<ChiTietDonHangModel> danhSachChiTietDonHang;
  late List<ViModel> danhSachVi;
  late List<GiaoDichModel> danhSachGiaoDich;

  void _khoiTaoDuLieu() {
    // 1. Khởi tạo người dùng
    danhSachNguoiDung = [
      NguoiDungModel(
        id: 'USER01',
        ten: 'Nguyễn Văn A',
        email: 'vanga@gmail.com',
        soDienThoai: '0987654321',
        avatar: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde',
        vaiTro: 'USER',
        ngayTao: DateTime.now().subtract(const Duration(days: 30)),
      ),
      NguoiDungModel(
        id: 'USER02',
        ten: 'Nguyễn Văn B',
        email: 'vanb@gmail.com',
        soDienThoai: '0987654322',
        avatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d',
        vaiTro: 'USER',
        ngayTao: DateTime.now().subtract(const Duration(days: 20)),
      ),
      NguoiDungModel(
        id: 'ADMIN01',
        ten: 'Chủ cửa hàng (Admin)',
        email: 'admin@outlet.com',
        soDienThoai: '0123456789',
        avatar: 'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61',
        vaiTro: 'ADMIN',
        ngayTao: DateTime.now().subtract(const Duration(days: 30)),
      ),
    ];

    // 2. Khởi tạo ví cho người ký gửi
    danhSachVi = [
      ViModel(
        id: 'V01',
        nguoiDungId: 'USER01',
        soDu: 12500000,
        soDuDangCho: 0,
        soDuCoTheRut: 12500000,
        ngayCapNhat: DateTime.now(),
      ),
    ];

    // 3. Khởi tạo giao dịch ví mẫu
    danhSachGiaoDich = [
      GiaoDichModel(
        id: 'GD01',
        viId: 'V01',
        loai: 'NHAN_TIEN_KY_GUI',
        soTien: 2200000,
        moTa: 'Bán thành công sản phẩm: Túi xách Gucci Luxury',
        trangThai: 'THANH_CONG',
        ngayTao: DateTime.now().subtract(const Duration(days: 2)),
      ),
      GiaoDichModel(
        id: 'GD02',
        viId: 'V01',
        loai: 'RUT_TIEN',
        soTien: 1500000,
        moTa: 'Rút tiền về Vietcombank - 1023456789 - NGUYEN VAN A',
        trangThai: 'THANH_CONG',
        ngayTao: DateTime.now().subtract(const Duration(days: 5)),
      ),
    ];

    // 4. Khởi tạo danh sách sản phẩm (Bao gồm sản phẩm của Shop & sản phẩm Ký gửi)
    danhSachSanPham = [
      SanPhamModel(
        id: '1',
        ten: 'MLB Chunky Sneakers',
        moTa: 'Giày thời trang phong cách Hàn Quốc',
        gia: 2200000,
        giaGoc: 3200000,
        phanTramGiamGia: 30,
        hinhAnh: ['https://images.unsplash.com/photo-1542291026-7eec264c27ff'],
        thuongHieuId: 'MLB',
        danhMucId: 'Giày',
        kichThuoc: '42',
        tinhTrang: 'MOI',
        trangThai: 'DANG_BAN',
        tonKho: 10,
        noiBat: true,
        nguoiBanId: 'SHOP_01',
        ngayTao: DateTime.now().subtract(const Duration(days: 15)),
      ),
      SanPhamModel(
        id: '2',
        ten: 'Korean Oversize Hoodie',
        moTa: 'Hoodie local brand phong cách Korean',
        gia: 890000,
        giaGoc: 1290000,
        phanTramGiamGia: 25,
        hinhAnh: [
          'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab',
        ],
        thuongHieuId: 'Local Brand',
        danhMucId: 'Áo khoác',
        kichThuoc: 'L',
        tinhTrang: 'MOI',
        trangThai: 'DANG_BAN',
        tonKho: 5,
        noiBat: true,
        nguoiBanId: 'SHOP_01',
        ngayTao: DateTime.now().subtract(const Duration(days: 15)),
      ),
      SanPhamModel(
        id: '3',
        ten: 'Nike Air Force 1',
        moTa: 'Sneaker basic premium outlet',
        gia: 3100000,
        giaGoc: 4200000,
        phanTramGiamGia: 20,
        hinhAnh: [
          'https://images.unsplash.com/photo-1600185365483-26d7a4cc7519',
        ],
        thuongHieuId: 'Nike',
        danhMucId: 'Giày',
        kichThuoc: '41',
        tinhTrang: 'MOI',
        trangThai: 'DANG_BAN',
        tonKho: 8,
        noiBat: true,
        nguoiBanId: 'SHOP_01',
        ngayTao: DateTime.now().subtract(const Duration(days: 15)),
      ),
      SanPhamModel(
        id: '4',
        ten: 'Leather Mini Bag',
        moTa: 'Túi xách nữ Korean luxury style',
        gia: 1450000,
        giaGoc: 2100000,
        phanTramGiamGia: 15,
        hinhAnh: [
          'https://images.unsplash.com/photo-1584917865442-de89df76afd3',
        ],
        thuongHieuId: 'Gucci',
        danhMucId: 'Túi xách',
        kichThuoc: 'Free Size',
        tinhTrang: 'MOI',
        trangThai: 'DANG_BAN',
        tonKho: 4,
        noiBat: true,
        nguoiBanId: 'SHOP_01',
        ngayTao: DateTime.now().subtract(const Duration(days: 15)),
      ),
      // Sản phẩm ký gửi đã duyệt và đang bán
      SanPhamModel(
        id: 'KG01',
        ten: 'Áo Vest Blazer Premium',
        moTa: 'Áo blazer công sở cao cấp còn mới 98%',
        gia: 1500000,
        giaGoc: 2500000,
        phanTramGiamGia: 0,
        hinhAnh: [
          'https://images.unsplash.com/photo-1591047139829-d91aecb6caea',
        ],
        thuongHieuId: 'Zara',
        danhMucId: 'Áo khoác',
        kichThuoc: 'M',
        tinhTrang: '98%',
        trangThai: 'DANG_BAN',
        tonKho: 1,
        noiBat: false,
        nguoiBanId: 'USER01',
        ngayTao: DateTime.now().subtract(const Duration(days: 10)),
      ),
      // Sản phẩm ký gửi đang chờ duyệt
      SanPhamModel(
        id: 'KG02',
        ten: 'Váy Dạ Hội Zara Silk',
        moTa: 'Váy dạ hội Zara lụa cao cấp, thích hợp đi tiệc',
        gia: 800000,
        giaGoc: 1800000,
        phanTramGiamGia: 0,
        hinhAnh: [
          'https://images.unsplash.com/photo-1595777457583-95e059d581b8',
        ],
        thuongHieuId: 'Zara',
        danhMucId: 'Áo thun',
        kichThuoc: 'S',
        tinhTrang: '99%',
        trangThai: 'CHO_DUYET',
        tonKho: 1,
        noiBat: false,
        nguoiBanId: 'USER01',
        ngayTao: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];

    // 5. Khởi tạo danh sách thỏa thuận ký gửi
    danhSachKyGui = [
      KyGuiModel(
        id: 'KG01',
        nguoiDungId: 'USER01',
        tenSanPham: 'Áo Vest Blazer Premium',
        moTa: 'Áo blazer công sở cao cấp còn mới 98%',
        hinhAnh: [
          'https://images.unsplash.com/photo-1591047139829-d91aecb6caea',
        ],
        giaMongMuon: 1500000,
        giaDuocDuyet: 1500000,
        phanTramHoaHong: 30, // Shop ăn 30%, User hưởng 70%
        trangThai: 'DA_DUYET',
        ngayBatDau: DateTime.now().subtract(const Duration(days: 10)),
        ngayKetThuc: DateTime.now().add(const Duration(days: 20)),
        ghiChuAdmin: 'Hàng chất lượng tốt, đã duyệt giá và đăng bán',
        ngayTao: DateTime.now().subtract(const Duration(days: 10)),
      ),
      KyGuiModel(
        id: 'KG02',
        nguoiDungId: 'USER01',
        tenSanPham: 'Váy Dạ Hội Zara Silk',
        moTa: 'Váy dạ hội Zara lụa cao cấp, thích hợp đi tiệc',
        hinhAnh: [
          'https://images.unsplash.com/photo-1595777457583-95e059d581b8',
        ],
        giaMongMuon: 800000,
        giaDuocDuyet: 0,
        phanTramHoaHong: 0,
        trangThai: 'CHO_DUYET',
        ngayBatDau: DateTime.now(),
        ngayKetThuc: DateTime.now(),
        ghiChuAdmin: '',
        ngayTao: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];

    // 6. Khởi tạo danh sách đơn hàng
    danhSachDonHang = [
      DonHangModel(
        id: 'DH001',
        nguoiDungId: 'USER01',
        diaChiId: 'DC001',
        tongTien: 3090000,
        phiVanChuyen: 30000,
        phuongThucThanhToan: 'COD',
        trangThai: 'DANG_GIAO',
        ngayTao: DateTime.now().subtract(const Duration(days: 1)),
      ),
      DonHangModel(
        id: 'DH002',
        nguoiDungId: 'USER01',
        diaChiId: 'DC002',
        tongTien: 2200000,
        phiVanChuyen: 30000,
        phuongThucThanhToan: 'BANKING',
        trangThai: 'HOAN_THANH',
        ngayTao: DateTime.now().subtract(const Duration(days: 3)),
      ),
    ];

    // 7. Khởi tạo chi tiết đơn hàng
    danhSachChiTietDonHang = [
      // Chi tiết đơn hàng DH001: Mua Sneakers (2.2M) và Hoodie (890k)
      ChiTietDonHangModel(
        id: 'CT01',
        donHangId: 'DH001',
        sanPhamId: '1',
        gia: 2200000,
        soLuong: 1,
        tamTinh: 2200000,
      ),
      ChiTietDonHangModel(
        id: 'CT02',
        donHangId: 'DH001',
        sanPhamId: '2',
        gia: 890000,
        soLuong: 1,
        tamTinh: 890000,
      ),
      // Chi tiết đơn hàng DH002: Mua Áo blazer ký gửi (1.5M) -> Đơn hàng này đã hoàn thành trước đó
      ChiTietDonHangModel(
        id: 'CT03',
        donHangId: 'DH002',
        sanPhamId: 'KG01',
        gia: 1500000,
        soLuong: 1,
        tamTinh: 1500000,
      ),
    ];
  }
}
