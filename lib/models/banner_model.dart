class BannerModel {
  final String id;

  final String tieuDe;

  final String hinhAnh;

  final String duongDan;

  final bool kichHoat;

  BannerModel({
    required this.id,
    required this.tieuDe,
    required this.hinhAnh,
    required this.duongDan,
    required this.kichHoat,
  });

  factory BannerModel.tuJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'],
      tieuDe: json['tieuDe'],
      hinhAnh: json['hinhAnh'],
      duongDan: json['duongDan'],
      kichHoat: json['kichHoat'],
    );
  }

  Map<String, dynamic> thanhJson() {
    return {
      'id': id,
      'tieuDe': tieuDe,
      'hinhAnh': hinhAnh,
      'duongDan': duongDan,
      'kichHoat': kichHoat,
    };
  }
}
