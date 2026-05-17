// features/user/profile/profile_menu_item.dart

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;

  final String tieuDe;

  final VoidCallback onTap;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.tieuDe,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.md),

        padding: const EdgeInsets.all(AppSpacing.lg),

        decoration: BoxDecoration(
          color: AppColors.surface,

          borderRadius: BorderRadius.circular(AppRadius.lg),

          boxShadow: AppShadows.cardShadow,
        ),

        child: Row(
          children: [
            Icon(icon, color: AppColors.primary),

            const SizedBox(width: AppSpacing.md),

            Expanded(child: Text(tieuDe, style: AppTypography.noiDung)),

            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
