import '../../models/product_model.dart';
import '../../models/order_model.dart';

class DuLieuMau {
  static List<String> danhMuc = [
    "Giày",

    "Túi xách",

    "Áo khoác",

    "Phụ kiện",

    "Áo thun",

    "Khác",
  ];

  static List<String> thuongHieu = [
    "Nike",

    "Adidas",

    "MLB",

    "Gucci",

    "Louis Vuitton",
  ];

  static List<SanPhamModel> danhSachSanPham = [
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

      ngayTao: DateTime.now(),
    ),

    SanPhamModel(
      id: '2',

      ten: 'Korean Oversize Hoodie',

      moTa: 'Hoodie local brand phong cách Korean',

      gia: 890000,

      giaGoc: 1290000,

      phanTramGiamGia: 25,

      hinhAnh: ['https://images.unsplash.com/photo-1521572163474-6864f9cf17ab'],

      thuongHieuId: 'Local Brand',

      danhMucId: 'Áo khoác',

      kichThuoc: 'L',

      tinhTrang: 'MOI',

      trangThai: 'DANG_BAN',

      tonKho: 5,

      noiBat: true,

      nguoiBanId: 'SHOP_01',

      ngayTao: DateTime.now(),
    ),

    SanPhamModel(
      id: '3',

      ten: 'Nike Air Force 1',

      moTa: 'Sneaker basic premium outlet',

      gia: 3100000,

      giaGoc: 4200000,

      phanTramGiamGia: 20,

      hinhAnh: ['https://images.unsplash.com/photo-1600185365483-26d7a4cc7519'],

      thuongHieuId: 'Nike',

      danhMucId: 'Giày',

      kichThuoc: '41',

      tinhTrang: 'MOI',

      trangThai: 'DANG_BAN',

      tonKho: 8,

      noiBat: true,

      nguoiBanId: 'SHOP_01',

      ngayTao: DateTime.now(),
    ),

    SanPhamModel(
      id: '4',

      ten: 'Leather Mini Bag',

      moTa: 'Túi xách nữ Korean luxury style',

      gia: 1450000,

      giaGoc: 2100000,

      phanTramGiamGia: 15,

      hinhAnh: ['https://images.unsplash.com/photo-1584917865442-de89df76afd3'],

      thuongHieuId: 'Gucci',

      danhMucId: 'Túi xách',

      kichThuoc: 'Free Size',

      tinhTrang: 'MOI',

      trangThai: 'DANG_BAN',

      tonKho: 4,

      noiBat: true,

      nguoiBanId: 'SHOP_01',

      ngayTao: DateTime.now(),
    ),
  ];

  static List<DonHangModel> danhSachDonHang = [
    DonHangModel(
      id: 'DH001',

      nguoiDungId: 'USER01',

      diaChiId: 'DC001',

      tongTien: 6389000,

      phiVanChuyen: 39000,

      phuongThucThanhToan: 'COD',

      trangThai: 'ĐANG_GIAO',

      ngayTao: DateTime.now(),
    ),

    DonHangModel(
      id: 'DH002',

      nguoiDungId: 'USER01',

      diaChiId: 'DC002',

      tongTien: 3200000,

      phiVanChuyen: 39000,

      phuongThucThanhToan: 'BANKING',

      trangThai: 'HOAN_THANH',

      ngayTao: DateTime.now(),
    ),
  ];
}
