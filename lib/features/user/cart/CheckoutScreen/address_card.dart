// features/user/checkout/address_card.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({super.key});

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Text('Địa chỉ giao hàng', style: AppTypography.tieuDeNho),

              Text(
                'Thay đổi',

                style: AppTypography.noiDung.copyWith(color: AppColors.primary),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.md),

          Text(
            'Nguyễn Văn A',

            style: AppTypography.noiDung.copyWith(fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 4),

          Text('0123456789', style: AppTypography.moTa),

          const SizedBox(height: 4),

          Text('123 Nguyễn Trãi, Quận 1, TP.HCM', style: AppTypography.noiDung),
        ],
      ),
    );
  }
}
