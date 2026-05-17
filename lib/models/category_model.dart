class DanhMucModel {
  final String id;

  final String ten;

  final String hinhAnh;

  DanhMucModel({required this.id, required this.ten, required this.hinhAnh});

  factory DanhMucModel.tuJson(Map<String, dynamic> json) {
    return DanhMucModel(
      id: json['id'],
      ten: json['ten'],
      hinhAnh: json['hinhAnh'],
    );
  }

  Map<String, dynamic> thanhJson() {
    return {'id': id, 'ten': ten, 'hinhAnh': hinhAnh};
  }
}
