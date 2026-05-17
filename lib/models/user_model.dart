class NguoiDungModel {
  final String id;
  final String ten;
  final String email;
  final String soDienThoai;
  final String avatar;
  final String vaiTro;
  final DateTime ngayTao;

  NguoiDungModel({
    required this.id,
    required this.ten,
    required this.email,
    required this.soDienThoai,
    required this.avatar,
    required this.vaiTro,
    required this.ngayTao,
  });

  factory NguoiDungModel.tuJson(Map<String, dynamic> json) {
    return NguoiDungModel(
      id: json['id'],
      ten: json['ten'],
      email: json['email'],
      soDienThoai: json['soDienThoai'],
      avatar: json['avatar'],
      vaiTro: json['vaiTro'],
      ngayTao: DateTime.parse(json['ngayTao']),
    );
  }

  Map<String, dynamic> thanhJson() {
    return {
      'id': id,
      'ten': ten,
      'email': email,
      'soDienThoai': soDienThoai,
      'avatar': avatar,
      'vaiTro': vaiTro,
      'ngayTao': ngayTao.toIso8601String(),
    };
  }

  NguoiDungModel saoChep({String? ten, String? soDienThoai}) {
    return NguoiDungModel(
      id: id,
      ten: ten ?? this.ten,
      email: email,
      soDienThoai: soDienThoai ?? this.soDienThoai,
      avatar: avatar,
      vaiTro: vaiTro,
      ngayTao: ngayTao,
    );
  }
}
