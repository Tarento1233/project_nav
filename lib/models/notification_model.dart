class ThongBaoModel {
  final String id;

  final String nguoiDungId;

  final String tieuDe;

  final String noiDung;

  final String loai;

  final bool daDoc;

  final DateTime ngayTao;

  ThongBaoModel({
    required this.id,
    required this.nguoiDungId,
    required this.tieuDe,
    required this.noiDung,
    required this.loai,
    required this.daDoc,
    required this.ngayTao,
  });

  factory ThongBaoModel.tuJson(Map<String, dynamic> json) {
    return ThongBaoModel(
      id: json['id'],
      nguoiDungId: json['nguoiDungId'],
      tieuDe: json['tieuDe'],
      noiDung: json['noiDung'],
      loai: json['loai'],
      daDoc: json['daDoc'],
      ngayTao: DateTime.parse(json['ngayTao']),
    );
  }

  Map<String, dynamic> thanhJson() {
    return {
      'id': id,
      'nguoiDungId': nguoiDungId,
      'tieuDe': tieuDe,
      'noiDung': noiDung,
      'loai': loai,
      'daDoc': daDoc,
      'ngayTao': ngayTao.toIso8601String(),
    };
  }
}
