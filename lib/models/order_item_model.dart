class ChiTietDonHangModel {
  final String id;

  final String donHangId;

  final String sanPhamId;

  final double gia;

  final int soLuong;

  final double tamTinh;

  ChiTietDonHangModel({
    required this.id,
    required this.donHangId,
    required this.sanPhamId,
    required this.gia,
    required this.soLuong,
    required this.tamTinh,
  });

  factory ChiTietDonHangModel.tuJson(Map<String, dynamic> json) {
    return ChiTietDonHangModel(
      id: json['id'],
      donHangId: json['donHangId'],
      sanPhamId: json['sanPhamId'],
      gia: json['gia'],
      soLuong: json['soLuong'],
      tamTinh: json['tamTinh'],
    );
  }

  Map<String, dynamic> thanhJson() {
    return {
      'id': id,
      'donHangId': donHangId,
      'sanPhamId': sanPhamId,
      'gia': gia,
      'soLuong': soLuong,
      'tamTinh': tamTinh,
    };
  }
}
