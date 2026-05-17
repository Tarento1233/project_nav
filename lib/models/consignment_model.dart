class KyGuiModel {
  final String id;

  final String nguoiDungId;

  final String tenSanPham;

  final String moTa;

  final List<String> hinhAnh;

  final double giaMongMuon;

  final double giaDuocDuyet;

  final double phanTramHoaHong;

  final String trangThai;

  final DateTime ngayBatDau;

  final DateTime ngayKetThuc;

  final String ghiChuAdmin;

  final DateTime ngayTao;

  KyGuiModel({
    required this.id,
    required this.nguoiDungId,
    required this.tenSanPham,
    required this.moTa,
    required this.hinhAnh,
    required this.giaMongMuon,
    required this.giaDuocDuyet,
    required this.phanTramHoaHong,
    required this.trangThai,
    required this.ngayBatDau,
    required this.ngayKetThuc,
    required this.ghiChuAdmin,
    required this.ngayTao,
  });

  factory KyGuiModel.tuJson(Map<String, dynamic> json) {
    return KyGuiModel(
      id: json['id'],
      nguoiDungId: json['nguoiDungId'],
      tenSanPham: json['tenSanPham'],
      moTa: json['moTa'],
      hinhAnh: List<String>.from(json['hinhAnh']),
      giaMongMuon: json['giaMongMuon'],
      giaDuocDuyet: json['giaDuocDuyet'],
      phanTramHoaHong: json['phanTramHoaHong'],
      trangThai: json['trangThai'],
      ngayBatDau: DateTime.parse(json['ngayBatDau']),
      ngayKetThuc: DateTime.parse(json['ngayKetThuc']),
      ghiChuAdmin: json['ghiChuAdmin'],
      ngayTao: DateTime.parse(json['ngayTao']),
    );
  }

  Map<String, dynamic> thanhJson() {
    return {
      'id': id,
      'nguoiDungId': nguoiDungId,
      'tenSanPham': tenSanPham,
      'moTa': moTa,
      'hinhAnh': hinhAnh,
      'giaMongMuon': giaMongMuon,
      'giaDuocDuyet': giaDuocDuyet,
      'phanTramHoaHong': phanTramHoaHong,
      'trangThai': trangThai,
      'ngayBatDau': ngayBatDau.toIso8601String(),
      'ngayKetThuc': ngayKetThuc.toIso8601String(),
      'ghiChuAdmin': ghiChuAdmin,
      'ngayTao': ngayTao.toIso8601String(),
    };
  }
}
