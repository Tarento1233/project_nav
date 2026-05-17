class ThuongHieuModel {
  final String id;

  final String ten;

  final String logo;

  final String moTa;

  ThuongHieuModel({
    required this.id,
    required this.ten,
    required this.logo,
    required this.moTa,
  });

  factory ThuongHieuModel.tuJson(Map<String, dynamic> json) {
    return ThuongHieuModel(
      id: json['id'],
      ten: json['ten'],
      logo: json['logo'],
      moTa: json['moTa'],
    );
  }

  Map<String, dynamic> thanhJson() {
    return {'id': id, 'ten': ten, 'logo': logo, 'moTa': moTa};
  }
}
