class DonHangModel {
  final String id;

  final String nguoiDungId;

  final String diaChiId;

  final double tongTien;

  final double phiVanChuyen;

  final String phuongThucThanhToan;

  final String trangThai;

  final DateTime ngayTao;

  DonHangModel({
    required this.id,
    required this.nguoiDungId,
    required this.diaChiId,
    required this.tongTien,
    required this.phiVanChuyen,
    required this.phuongThucThanhToan,
    required this.trangThai,
    required this.ngayTao,
  });

  factory DonHangModel.tuJson(Map<String, dynamic> json) {
    return DonHangModel(
      id: json['id'],
      nguoiDungId: json['nguoiDungId'],
      diaChiId: json['diaChiId'],
      tongTien: json['tongTien'],
      phiVanChuyen: json['phiVanChuyen'],
      phuongThucThanhToan: json['phuongThucThanhToan'],
      trangThai: json['trangThai'],
      ngayTao: DateTime.parse(json['ngayTao']),
    );
  }

  Map<String, dynamic> thanhJson() {
    return {
      'id': id,
      'nguoiDungId': nguoiDungId,
      'diaChiId': diaChiId,
      'tongTien': tongTien,
      'phiVanChuyen': phiVanChuyen,
      'phuongThucThanhToan': phuongThucThanhToan,
      'trangThai': trangThai,
      'ngayTao': ngayTao.toIso8601String(),
    };
  }
}
