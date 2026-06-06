class NguoiDungModel {
  final String id;
  final String ten;
  final String email;
  final String soDienThoai;
  final String avatar;
  final String vaiTro;
  final DateTime ngayTao;
  final String trangThai;

  NguoiDungModel({
    required this.id,
    required this.ten,
    required this.email,
    required this.soDienThoai,
    required this.avatar,
    required this.vaiTro,
    required this.ngayTao,
    this.trangThai = 'ACTIVE',
  });

  factory NguoiDungModel.tuJson(Map<String, dynamic> json) {
    return NguoiDungModel(
      id: json['id'],
      ten: json['ten'] ?? '',
      email: json['email'] ?? '',
      soDienThoai: json['soDienThoai'] ?? '',
      avatar: json['avatar'] ?? '',
      vaiTro: json['vaiTro'] ?? 'USER',
      ngayTao: DateTime.parse(json['ngayTao']),
      trangThai: json['trangThai'] ?? 'ACTIVE',
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
      'trangThai': trangThai,
    };
  }

  NguoiDungModel saoChep({
    String? ten,
    String? soDienThoai,
    String? vaiTro,
    String? trangThai,
  }) {
    return NguoiDungModel(
      id: id,
      ten: ten ?? this.ten,
      email: email,
      soDienThoai: soDienThoai ?? this.soDienThoai,
      avatar: avatar,
      vaiTro: vaiTro ?? this.vaiTro,
      ngayTao: ngayTao,
      trangThai: trangThai ?? this.trangThai,
    );
  }
}
