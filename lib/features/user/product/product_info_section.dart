// features/user/product/widgets/product_info_section.dart

import 'package:flutter/material.dart';

import '../../../../models/product_model.dart';

import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';

class ProductInfoSection extends StatelessWidget {
  final SanPhamModel sanPham;

  const ProductInfoSection({super.key, required this.sanPham});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          sanPham.thuongHieuId,

          style: AppTypography.moTa.copyWith(
            color: AppColors.primaryDark,

            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: AppSpacing.sm),

        Text(sanPham.ten, style: AppTypography.tieuDeLon),

        const SizedBox(height: AppSpacing.md),

        Text(sanPham.moTa, style: AppTypography.noiDung.copyWith(height: 1.6)),
      ],
    );
  }
}
