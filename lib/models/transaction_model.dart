class GiaoDichModel {
  final String id;

  final String viId;

  final String loai;

  final double soTien;

  final String moTa;

  final String trangThai;

  final DateTime ngayTao;

  GiaoDichModel({
    required this.id,
    required this.viId,
    required this.loai,
    required this.soTien,
    required this.moTa,
    required this.trangThai,
    required this.ngayTao,
  });

  factory GiaoDichModel.tuJson(Map<String, dynamic> json) {
    return GiaoDichModel(
      id: json['id'],
      viId: json['viId'],
      loai: json['loai'],
      soTien: json['soTien'],
      moTa: json['moTa'],
      trangThai: json['trangThai'],
      ngayTao: DateTime.parse(json['ngayTao']),
    );
  }

  Map<String, dynamic> thanhJson() {
    return {
      'id': id,
      'viId': viId,
      'loai': loai,
      'soTien': soTien,
      'moTa': moTa,
      'trangThai': trangThai,
      'ngayTao': ngayTao.toIso8601String(),
    };
  }
}
