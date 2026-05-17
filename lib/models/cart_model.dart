class GioHangModel {
  final String id;

  final String nguoiDungId;

  final String sanPhamId;

  final int soLuong;

  final String kichThuocDaChon;

  final String mauSacDaChon;

  GioHangModel({
    required this.id,
    required this.nguoiDungId,
    required this.sanPhamId,
    required this.soLuong,
    required this.kichThuocDaChon,
    required this.mauSacDaChon,
  });

  factory GioHangModel.tuJson(Map<String, dynamic> json) {
    return GioHangModel(
      id: json['id'],
      nguoiDungId: json['nguoiDungId'],
      sanPhamId: json['sanPhamId'],
      soLuong: json['soLuong'],
      kichThuocDaChon: json['kichThuocDaChon'],
      mauSacDaChon: json['mauSacDaChon'],
    );
  }

  Map<String, dynamic> thanhJson() {
    return {
      'id': id,
      'nguoiDungId': nguoiDungId,
      'sanPhamId': sanPhamId,
      'soLuong': soLuong,
      'kichThuocDaChon': kichThuocDaChon,
      'mauSacDaChon': mauSacDaChon,
    };
  }
}
