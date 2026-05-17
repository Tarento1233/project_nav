// features/user/order/shipping_info_card.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class ShippingInfoCard extends StatelessWidget {
  const ShippingInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),

      decoration: BoxDecoration(
        color: AppColors.surface,

        borderRadius: BorderRadius.circular(AppRadius.lg),

        boxShadow: AppShadows.cardShadow,
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text('Thông tin giao hàng', style: AppTypography.tieuDeNho),

          const SizedBox(height: AppSpacing.lg),

          Text('Nguyễn Văn A', style: AppTypography.noiDung),

          const SizedBox(height: 4),

          Text('0123456789', style: AppTypography.moTa),

          const SizedBox(height: 4),

          Text('123 Nguyễn Trãi, TP.HCM', style: AppTypography.noiDung),
        ],
      ),
    );
  }
}
