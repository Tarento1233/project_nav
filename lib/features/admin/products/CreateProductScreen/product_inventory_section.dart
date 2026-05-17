// features/admin/products/product_inventory_section.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';

class ProductInventorySection extends StatelessWidget {
  const ProductInventorySection({super.key});

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
          keyboardType: TextInputType.number,

          decoration: inputDecoration('Số lượng tồn kho'),
        ),

        const SizedBox(height: AppSpacing.lg),

        TextField(decoration: inputDecoration('Trạng thái sản phẩm')),
      ],
    );
  }
}
