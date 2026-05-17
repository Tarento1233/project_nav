// features/admin/products/product_price_section.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';

class ProductPriceSection extends StatelessWidget {
  const ProductPriceSection({super.key});

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

          decoration: inputDecoration('Giá bán'),
        ),

        const SizedBox(height: AppSpacing.lg),

        TextField(
          keyboardType: TextInputType.number,

          decoration: inputDecoration('Giá gốc'),
        ),

        const SizedBox(height: AppSpacing.lg),

        TextField(
          keyboardType: TextInputType.number,

          decoration: inputDecoration('Phần trăm giảm giá'),
        ),
      ],
    );
  }
}
