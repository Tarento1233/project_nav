class DiaChiModel {
  final String id;

  final String nguoiDungId;

  final String tenNguoiNhan;

  final String soDienThoai;

  final String tinhThanh;

  final String quanHuyen;

  final String phuongXa;

  final String diaChiChiTiet;

  final bool macDinh;

  DiaChiModel({
    required this.id,
    required this.nguoiDungId,
    required this.tenNguoiNhan,
    required this.soDienThoai,
    required this.tinhThanh,
    required this.quanHuyen,
    required this.phuongXa,
    required this.diaChiChiTiet,
    required this.macDinh,
  });

  factory DiaChiModel.tuJson(Map<String, dynamic> json) {
    return DiaChiModel(
      id: json['id'],
      nguoiDungId: json['nguoiDungId'],
      tenNguoiNhan: json['tenNguoiNhan'],
      soDienThoai: json['soDienThoai'],
      tinhThanh: json['tinhThanh'],
      quanHuyen: json['quanHuyen'],
      phuongXa: json['phuongXa'],
      diaChiChiTiet: json['diaChiChiTiet'],
      macDinh: json['macDinh'],
    );
  }

  Map<String, dynamic> thanhJson() {
    return {
      'id': id,
      'nguoiDungId': nguoiDungId,
      'tenNguoiNhan': tenNguoiNhan,
      'soDienThoai': soDienThoai,
      'tinhThanh': tinhThanh,
      'quanHuyen': quanHuyen,
      'phuongXa': phuongXa,
      'diaChiChiTiet': diaChiChiTiet,
      'macDinh': macDinh,
    };
  }
}
