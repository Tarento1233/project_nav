// features/user/profile/profile_quick_action.dart

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

class ProfileQuickAction extends StatelessWidget {
  const ProfileQuickAction({super.key});

  Widget actionItem({required IconData icon, required String title}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),

        decoration: BoxDecoration(
          color: AppColors.surface,

          borderRadius: BorderRadius.circular(AppRadius.lg),

          boxShadow: AppShadows.cardShadow,
        ),

        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 28),

            const SizedBox(height: AppSpacing.sm),

            Text(title, style: AppTypography.moTa),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        actionItem(icon: Icons.shopping_bag_outlined, title: 'Đơn hàng'),

        const SizedBox(width: AppSpacing.md),

        actionItem(icon: Icons.account_balance_wallet_outlined, title: 'Ví'),

        const SizedBox(width: AppSpacing.md),

        actionItem(icon: Icons.inventory_2_outlined, title: 'Ký gửi'),
      ],
    );
  }
}
