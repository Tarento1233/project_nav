// features/admin/users/user_statistics_card.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class UserStatisticsCard extends StatelessWidget {
  const UserStatisticsCard({super.key});

  Widget item({required String title, required String value}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),

        decoration: BoxDecoration(
          color: AppColors.background,

          borderRadius: BorderRadius.circular(AppRadius.md),
        ),

        child: Column(
          children: [
            Text(value, style: AppTypography.gia),

            const SizedBox(height: AppSpacing.sm),

            Text(title, textAlign: TextAlign.center, style: AppTypography.moTa),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(AppSpacing.lg),

      decoration: BoxDecoration(
        color: AppColors.surface,

        borderRadius: BorderRadius.circular(AppRadius.lg),

        boxShadow: AppShadows.cardShadow,
      ),

      child: Row(
        children: [
          item(title: 'Đơn hàng', value: '25'),

          const SizedBox(width: AppSpacing.md),

          item(title: 'Chi tiêu', value: '32M'),

          const SizedBox(width: AppSpacing.md),

          item(title: 'Ký gửi', value: '8'),
        ],
      ),
    );
  }
}
