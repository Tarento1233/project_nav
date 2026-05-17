class ViModel {
  final String id;

  final String nguoiDungId;

  final double soDu;

  final double soDuDangCho;

  final double soDuCoTheRut;

  final DateTime ngayCapNhat;

  ViModel({
    required this.id,
    required this.nguoiDungId,
    required this.soDu,
    required this.soDuDangCho,
    required this.soDuCoTheRut,
    required this.ngayCapNhat,
  });

  factory ViModel.tuJson(Map<String, dynamic> json) {
    return ViModel(
      id: json['id'],
      nguoiDungId: json['nguoiDungId'],
      soDu: json['soDu'],
      soDuDangCho: json['soDuDangCho'],
      soDuCoTheRut: json['soDuCoTheRut'],
      ngayCapNhat: DateTime.parse(json['ngayCapNhat']),
    );
  }

  Map<String, dynamic> thanhJson() {
    return {
      'id': id,
      'nguoiDungId': nguoiDungId,
      'soDu': soDu,
      'soDuDangCho': soDuDangCho,
      'soDuCoTheRut': soDuCoTheRut,
      'ngayCapNhat': ngayCapNhat.toIso8601String(),
    };
  }
}
