// features/user/checkout/checkout_product_item.dart

import 'package:flutter/material.dart';

import '../../../../models/product_model.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

import '../../../../core/widgets/common/network_image_widget.dart';

class CheckoutProductItem extends StatelessWidget {
  final SanPhamModel sanPham;

  const CheckoutProductItem({super.key, required this.sanPham});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),

      decoration: BoxDecoration(
        color: AppColors.surface,

        borderRadius: BorderRadius.circular(AppRadius.lg),

        boxShadow: AppShadows.cardShadow,
      ),

      child: Row(
        children: [
          NetworkImageWidget(
            imageUrl: sanPham.hinhAnh.first,

            width: 90,

            height: 90,
          ),

          const SizedBox(width: AppSpacing.md),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  sanPham.ten,

                  maxLines: 2,

                  overflow: TextOverflow.ellipsis,

                  style: AppTypography.tieuDeNho,
                ),

                const SizedBox(height: AppSpacing.sm),

                Text('Size: ${sanPham.kichThuoc}', style: AppTypography.moTa),

                const SizedBox(height: AppSpacing.sm),

                Text(
                  '${sanPham.gia.toStringAsFixed(0)}đ',

                  style: AppTypography.gia,
                ),
              ],
            ),
          ),

          Text('x1', style: AppTypography.noiDung),
        ],
      ),
    );
  }
}
