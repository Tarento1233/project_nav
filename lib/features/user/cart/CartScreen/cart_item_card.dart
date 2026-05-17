// features/user/cart/cart_item_card.dart

import 'package:flutter/material.dart';

import '../../../../models/product_model.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

import '../../../../core/widgets/common/network_image_widget.dart';

import 'quantity_selector.dart';

class CartItemCard extends StatelessWidget {
  final SanPhamModel sanPham;

  const CartItemCard({super.key, required this.sanPham});

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
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          NetworkImageWidget(
            imageUrl: sanPham.hinhAnh.first,

            width: 100,

            height: 100,
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

                const SizedBox(height: AppSpacing.md),

                Text(
                  '${sanPham.gia.toStringAsFixed(0)}đ',

                  style: AppTypography.gia,
                ),

                const SizedBox(height: AppSpacing.md),

                const QuantitySelector(),
              ],
            ),
          ),

          IconButton(
            onPressed: () {},

            icon: const Icon(
              Icons.delete_outline_rounded,
              color: AppColors.error,
            ),
          ),
        ],
      ),
    );
  }
}
