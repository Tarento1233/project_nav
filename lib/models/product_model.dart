class SanPhamModel {
  final String id;
  final String ten;
  final String moTa;

  final double gia;
  final double giaGoc;

  final int phanTramGiamGia;

  final List<String> hinhAnh;

  final String thuongHieuId;
  final String danhMucId;

  final String kichThuoc;

  final String tinhTrang;

  final String trangThai;

  final int tonKho;

  final bool noiBat;

  final String nguoiBanId;

  final DateTime ngayTao;

  SanPhamModel({
    required this.id,
    required this.ten,
    required this.moTa,
    required this.gia,
    required this.giaGoc,
    required this.phanTramGiamGia,
    required this.hinhAnh,
    required this.thuongHieuId,
    required this.danhMucId,
    required this.kichThuoc,
    required this.tinhTrang,
    required this.trangThai,
    required this.tonKho,
    required this.noiBat,
    required this.nguoiBanId,
    required this.ngayTao,
  });

  factory SanPhamModel.tuJson(Map<String, dynamic> json) {
    return SanPhamModel(
      id: json['id'],
      ten: json['ten'],
      moTa: json['moTa'],
      gia: json['gia'],
      giaGoc: json['giaGoc'],
      phanTramGiamGia: json['phanTramGiamGia'],
      hinhAnh: List<String>.from(json['hinhAnh']),
      thuongHieuId: json['thuongHieuId'],
      danhMucId: json['danhMucId'],
      kichThuoc: json['kichThuoc'],
      tinhTrang: json['tinhTrang'],
      trangThai: json['trangThai'],
      tonKho: json['tonKho'],
      noiBat: json['noiBat'],
      nguoiBanId: json['nguoiBanId'],
      ngayTao: DateTime.parse(json['ngayTao']),
    );
  }

  Map<String, dynamic> thanhJson() {
    return {
      'id': id,
      'ten': ten,
      'moTa': moTa,
      'gia': gia,
      'giaGoc': giaGoc,
      'phanTramGiamGia': phanTramGiamGia,
      'hinhAnh': hinhAnh,
      'thuongHieuId': thuongHieuId,
      'danhMucId': danhMucId,
      'kichThuoc': kichThuoc,
      'tinhTrang': tinhTrang,
      'trangThai': trangThai,
      'tonKho': tonKho,
      'noiBat': noiBat,
      'nguoiBanId': nguoiBanId,
      'ngayTao': ngayTao.toIso8601String(),
    };
  }
}
