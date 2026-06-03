// features/user/consignment/consignment_form.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';

class ConsignmentForm extends StatelessWidget {
  final TextEditingController tenController;
  final TextEditingController moTaController;
  final TextEditingController danhMucController;
  final TextEditingController thuongHieuController;
  final TextEditingController kichThuocController;
  final TextEditingController giaController;

  const ConsignmentForm({
    super.key,
    required this.tenController,
    required this.moTaController,
    required this.danhMucController,
    required this.thuongHieuController,
    required this.kichThuocController,
    required this.giaController,
  });

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
          controller: tenController,
          decoration: inputDecoration('Tên sản phẩm'),
        ),
        const SizedBox(height: AppSpacing.lg),
        TextField(
          controller: moTaController,
          maxLines: 4,
          decoration: inputDecoration('Mô tả sản phẩm'),
        ),
        const SizedBox(height: AppSpacing.lg),
        TextField(
          controller: danhMucController,
          decoration: inputDecoration('Danh mục (ví dụ: Giày, Áo thun...)'),
        ),
        const SizedBox(height: AppSpacing.lg),
        TextField(
          controller: thuongHieuController,
          decoration: inputDecoration('Thương hiệu (ví dụ: Nike, Gucci...)'),
        ),
        const SizedBox(height: AppSpacing.lg),
        TextField(
          controller: kichThuocController,
          decoration: inputDecoration('Kích thước (ví dụ: 42, L, Free Size...)'),
        ),
        const SizedBox(height: AppSpacing.lg),
        TextField(
          controller: giaController,
          keyboardType: TextInputType.number,
          decoration: inputDecoration('Giá mong muốn'),
        ),
      ],
    );
  }
}

