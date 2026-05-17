// features/admin/products/product_filter_section.dart

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

class ProductFilterSection extends StatelessWidget {
  const ProductFilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: filterButton(title: 'Danh mục')),

        const SizedBox(width: AppSpacing.md),

        Expanded(child: filterButton(title: 'Brand')),

        const SizedBox(width: AppSpacing.md),

        Expanded(child: filterButton(title: 'Trạng thái')),
      ],
    );
  }

  Widget filterButton({required String title}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),

      decoration: BoxDecoration(
        color: AppColors.surface,

        borderRadius: BorderRadius.circular(12),

        border: Border.all(color: AppColors.border),
      ),

      child: Center(child: Text(title)),
    );
  }
}
