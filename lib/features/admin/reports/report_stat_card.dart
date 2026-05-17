// features/admin/reports/report_stat_card.dart

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

class ReportStatCard extends StatelessWidget {
  final String title;

  final String value;

  final IconData icon;

  const ReportStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

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

        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Container(
            width: 45,

            height: 45,

            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),

              shape: BoxShape.circle,
            ),

            child: Icon(icon, color: AppColors.primary),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(value, style: AppTypography.gia),

              const SizedBox(height: 4),

              Text(title, style: AppTypography.moTa),
            ],
          ),
        ],
      ),
    );
  }
}
