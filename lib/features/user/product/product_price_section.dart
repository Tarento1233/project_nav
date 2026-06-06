// features/user/product/widgets/product_price_section.dart

import 'package:flutter/material.dart';

import '../../../../models/product_model.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class ProductPriceSection extends StatelessWidget {
  final SanPhamModel sanPham;

  const ProductPriceSection({super.key, required this.sanPham});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,

      children: [
        Text(sanPham.gia.toVND(), style: AppTypography.gia),

        const SizedBox(width: AppSpacing.md),

        Text(
          sanPham.giaGoc.toVND(),

          style: AppTypography.giaGiam,
        ),

        const Spacer(),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),

          decoration: BoxDecoration(
            color: AppColors.discount,

            borderRadius: BorderRadius.circular(20),
          ),

          child: Text(
            '-${sanPham.phanTramGiamGia}%',

            style: AppTypography.moTa.copyWith(
              color: Colors.white,

              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
