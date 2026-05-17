// features/user/consignment/consignment_form.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';

class ConsignmentForm extends StatelessWidget {
  const ConsignmentForm({super.key});

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
        TextField(decoration: inputDecoration('Tên sản phẩm')),

        const SizedBox(height: AppSpacing.lg),

        TextField(maxLines: 4, decoration: inputDecoration('Mô tả sản phẩm')),

        const SizedBox(height: AppSpacing.lg),

        TextField(decoration: inputDecoration('Danh mục')),

        const SizedBox(height: AppSpacing.lg),

        TextField(decoration: inputDecoration('Thương hiệu')),

        const SizedBox(height: AppSpacing.lg),

        TextField(decoration: inputDecoration('Kích thước')),

        const SizedBox(height: AppSpacing.lg),

        TextField(
          keyboardType: TextInputType.number,

          decoration: inputDecoration('Giá mong muốn'),
        ),
      ],
    );
  }
}
