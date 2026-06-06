// features/user/consignment/edit_consignment_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/headers/custom_app_bar.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../models/product_model.dart';
import '../../../../providers/store_provider.dart';

import '../../../../core/constants/mock_data.dart';
import '../CreateConsignmentScreen/upload_image_box.dart';
import '../CreateConsignmentScreen/consignment_form.dart';
import '../CreateConsignmentScreen/condition_selector.dart';
import '../CreateConsignmentScreen/consignment_term_card.dart';

class EditConsignmentScreen extends StatefulWidget {
  final SanPhamModel sanPham;

  const EditConsignmentScreen({super.key, required this.sanPham});

  @override
  State<EditConsignmentScreen> createState() => _EditConsignmentScreenState();
}

class _EditConsignmentScreenState extends State<EditConsignmentScreen> {
  late final TextEditingController _tenController;
  late final TextEditingController _moTaController;
  late final TextEditingController _thuongHieuController;
  late final TextEditingController _giaController;
  late final TextEditingController _soLuongController;
  late final TextEditingController _customCategoryController;

  late String _selectedCategory;
  late List<String> _selectedSizes;
  late String _selectedCondition;
  String? _selectedImageUrl;

  @override
  void initState() {
    super.initState();
    _tenController = TextEditingController(text: widget.sanPham.ten);
    _moTaController = TextEditingController(text: widget.sanPham.moTa);
    _thuongHieuController = TextEditingController(text: widget.sanPham.thuongHieuId);
    _giaController = TextEditingController(text: widget.sanPham.gia.toStringAsFixed(0));
    _soLuongController = TextEditingController(text: widget.sanPham.tonKho.toString());
    _customCategoryController = TextEditingController();

    if (DuLieuMau.danhMuc.contains(widget.sanPham.danhMucId)) {
      _selectedCategory = widget.sanPham.danhMucId;
    } else {
      _selectedCategory = 'Khác';
      _customCategoryController.text = widget.sanPham.danhMucId;
    }

    _selectedSizes = widget.sanPham.kichThuoc
        .split(', ')
        .where((s) => s.isNotEmpty)
        .toList();
    _selectedCondition = widget.sanPham.tinhTrang;
    _selectedImageUrl = widget.sanPham.hinhAnh.isNotEmpty ? widget.sanPham.hinhAnh.first : null;
  }

  @override
  void dispose() {
    _tenController.dispose();
    _moTaController.dispose();
    _thuongHieuController.dispose();
    _giaController.dispose();
    _soLuongController.dispose();
    _customCategoryController.dispose();
    super.dispose();
  }

  void _luuCapNhat() {
    final ten = _tenController.text.trim();
    final moTa = _moTaController.text.trim();
    final thuongHieu = _thuongHieuController.text.trim();
    final giaText = _giaController.text.trim();
    final soLuongText = _soLuongController.text.trim();

    if (_selectedImageUrl == null || _selectedImageUrl!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng tải lên/chọn ảnh minh họa sản phẩm ký gửi!'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final finalCategory = _selectedCategory == 'Khác' ? _customCategoryController.text.trim() : _selectedCategory;
    if (finalCategory.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng nhập tên danh mục khác!'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    if (ten.isEmpty || moTa.isEmpty || finalCategory.isEmpty || thuongHieu.isEmpty || _selectedSizes.isEmpty || giaText.isEmpty || soLuongText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng nhập đầy đủ thông tin sản phẩm ký gửi và chọn kích thước!'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final gia = double.tryParse(giaText);
    if (gia == null || gia <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Giá mong muốn không hợp lệ!'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final soLuong = int.tryParse(soLuongText);
    if (soLuong == null || soLuong < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Số lượng ký gửi không hợp lệ!'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final kichThuoc = _selectedSizes.join(', ');

    final store = Provider.of<StoreProvider>(context, listen: false);
    store.updateConsignmentRequest(
      id: widget.sanPham.id,
      ten: ten,
      moTa: moTa,
      gia: gia,
      brand: thuongHieu,
      category: finalCategory,
      size: kichThuoc,
      condition: _selectedCondition,
      images: [_selectedImageUrl!],
      soLuong: soLuong,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đã cập nhật sản phẩm ký gửi thành công!'),
        backgroundColor: AppColors.success,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(tieuDe: 'Chỉnh sửa ký gửi'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            UploadImageBox(
              selectedImageUrl: _selectedImageUrl,
              onImageSelected: (url) {
                setState(() {
                  _selectedImageUrl = url;
                });
              },
            ),
            const SizedBox(height: AppSpacing.xl),
            ConsignmentForm(
              tenController: _tenController,
              moTaController: _moTaController,
              selectedCategory: _selectedCategory,
              customCategoryController: _customCategoryController,
              onCategoryChanged: (cat) {
                if (cat != null) {
                  setState(() {
                    _selectedCategory = cat;
                  });
                }
              },
              thuongHieuController: _thuongHieuController,
              selectedSizes: _selectedSizes,
              onSizesChanged: (sizes) {
                setState(() {
                  _selectedSizes = sizes;
                });
              },
              giaController: _giaController,
              soLuongController: _soLuongController,
            ),
            const SizedBox(height: AppSpacing.xl),
            ConditionSelector(
              selectedCondition: _selectedCondition,
              onConditionChanged: (condition) {
                setState(() {
                  _selectedCondition = condition;
                });
              },
            ),
            const SizedBox(height: AppSpacing.xl),
            const ConsignmentTermCard(),
            const SizedBox(height: AppSpacing.xl),
            PrimaryButton(
              tieuDe: 'Lưu thay đổi',
              onPressed: _luuCapNhat,
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
