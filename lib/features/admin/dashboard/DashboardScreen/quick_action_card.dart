// features/admin/dashboard/quick_action_card.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class QuickActionCard extends StatelessWidget {
  final String title;

  final IconData icon;

  final VoidCallback onTap;

  const QuickActionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),

        decoration: BoxDecoration(
          color: AppColors.surface,

          borderRadius: BorderRadius.circular(AppRadius.lg),

          boxShadow: AppShadows.cardShadow,
        ),

        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 32),

            const SizedBox(height: AppSpacing.md),

            Text(title, style: AppTypography.noiDung),
          ],
        ),
      ),
    );
  }
}
