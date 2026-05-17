// features/admin/products/edit_product_form.dart

import 'package:flutter/material.dart';

import '../../../../models/product_model.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';

class EditProductForm extends StatelessWidget {
  final SanPhamModel sanPham;

  const EditProductForm({super.key, required this.sanPham});

  InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,

      filled: true,

      fillColor: AppColors.surface,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),

        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: TextEditingController(text: sanPham.ten),

          decoration: inputDecoration('Tên sản phẩm'),
        ),

        const SizedBox(height: AppSpacing.lg),

        TextField(
          controller: TextEditingController(text: sanPham.moTa),

          maxLines: 4,

          decoration: inputDecoration('Mô tả sản phẩm'),
        ),

        const SizedBox(height: AppSpacing.lg),

        TextField(
          controller: TextEditingController(text: sanPham.danhMucId),

          decoration: inputDecoration('Danh mục'),
        ),

        const SizedBox(height: AppSpacing.lg),

        TextField(
          controller: TextEditingController(text: sanPham.thuongHieuId),

          decoration: inputDecoration('Thương hiệu'),
        ),

        const SizedBox(height: AppSpacing.lg),

        TextField(
          controller: TextEditingController(text: sanPham.kichThuoc),

          decoration: inputDecoration('Kích thước'),
        ),
      ],
    );
  }
}
