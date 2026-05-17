class ThanhToanModel {
  final String id;

  final String donHangId;

  final String nguoiDungId;

  final double soTien;

  final String phuongThucThanhToan;

  final String trangThai;

  final DateTime ngayThanhToan;

  ThanhToanModel({
    required this.id,
    required this.donHangId,
    required this.nguoiDungId,
    required this.soTien,
    required this.phuongThucThanhToan,
    required this.trangThai,
    required this.ngayThanhToan,
  });

  factory ThanhToanModel.tuJson(Map<String, dynamic> json) {
    return ThanhToanModel(
      id: json['id'],
      donHangId: json['donHangId'],
      nguoiDungId: json['nguoiDungId'],
      soTien: json['soTien'],
      phuongThucThanhToan: json['phuongThucThanhToan'],
      trangThai: json['trangThai'],
      ngayThanhToan: DateTime.parse(json['ngayThanhToan']),
    );
  }

  Map<String, dynamic> thanhJson() {
    return {
      'id': id,
      'donHangId': donHangId,
      'nguoiDungId': nguoiDungId,
      'soTien': soTien,
      'phuongThucThanhToan': phuongThucThanhToan,
      'trangThai': trangThai,
      'ngayThanhToan': ngayThanhToan.toIso8601String(),
    };
  }
}
