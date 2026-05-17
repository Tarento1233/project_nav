// features/user/wallet/revenue_summary_card.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class RevenueSummaryCard extends StatelessWidget {
  const RevenueSummaryCard({super.key});

  Widget item({required String title, required String value}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),

        decoration: BoxDecoration(
          color: AppColors.surface,

          borderRadius: BorderRadius.circular(AppRadius.lg),

          boxShadow: AppShadows.cardShadow,
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
    return Row(
      children: [
        item(title: 'Doanh thu ký gửi', value: '28M'),

        const SizedBox(width: AppSpacing.md),

        item(title: 'Hoa hồng', value: '3.2M'),

        const SizedBox(width: AppSpacing.md),

        item(title: 'Đã thanh toán', value: '21M'),
      ],
    );
  }
}
