// features/admin/products/CreateProductScreen/create_product_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/headers/custom_app_bar.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../providers/store_provider.dart';

import '../../../user/consignment/CreateConsignmentScreen/upload_image_box.dart';
import '../../../user/consignment/CreateConsignmentScreen/consignment_form.dart';
import '../../../user/consignment/CreateConsignmentScreen/condition_selector.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final _tenController = TextEditingController();
  final _moTaController = TextEditingController();
  final _thuongHieuController = TextEditingController();
  final _giaController = TextEditingController();
  final _soLuongController = TextEditingController(text: '1');
  final _customCategoryController = TextEditingController();

  String _selectedCategory = 'Giày';
  List<String> _selectedSizes = [];
  String _selectedCondition = '99%';
  String? _selectedImageUrl;

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

  void _taoSanPham() {
    final ten = _tenController.text.trim();
    final moTa = _moTaController.text.trim();
    final thuongHieu = _thuongHieuController.text.trim();
    final giaText = _giaController.text.trim();
    final soLuongText = _soLuongController.text.trim();

    if (_selectedImageUrl == null || _selectedImageUrl!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng tải lên/chọn ảnh minh họa sản phẩm!'),
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
          content: Text('Vui lòng nhập đầy đủ thông tin sản phẩm và chọn kích thước!'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final gia = double.tryParse(giaText);
    if (gia == null || gia <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Giá bán không hợp lệ!'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final soLuong = int.tryParse(soLuongText);
    if (soLuong == null || soLuong <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Số lượng sản phẩm không hợp lệ!'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    // Ghép kích thước thành chuỗi
    final kichThuoc = _selectedSizes.join(', ');

    // Thực hiện lưu sản phẩm thông qua Provider
    final store = Provider.of<StoreProvider>(context, listen: false);
    store.createProductByAdmin(
      ten: ten,
      moTa: moTa,
      gia: gia,
      giaGoc: gia,
      phanTramGiamGia: 0,
      brand: thuongHieu,
      category: finalCategory,
      size: kichThuoc,
      condition: _selectedCondition,
      images: [_selectedImageUrl!],
      soLuong: soLuong,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đã tạo sản phẩm thành công! Sản phẩm đã hiển thị trực tiếp trên cửa hàng.'),
        backgroundColor: AppColors.success,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(tieuDe: 'Tạo sản phẩm'),
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
            PrimaryButton(
              tieuDe: 'Tạo sản phẩm',
              onPressed: _taoSanPham,
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
