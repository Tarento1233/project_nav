// features/user/profile/profile_header.dart

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(AppSpacing.xl),

      decoration: BoxDecoration(
        color: AppColors.surface,

        borderRadius: BorderRadius.circular(AppRadius.lg),

        boxShadow: AppShadows.cardShadow,
      ),

      child: Column(
        children: [
          const CircleAvatar(
            radius: 45,

            backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
          ),

          const SizedBox(height: AppSpacing.lg),

          Text('Nguyễn Văn A', style: AppTypography.tieuDe),

          const SizedBox(height: 4),

          Text('nguyenvana@gmail.com', style: AppTypography.moTa),

          const SizedBox(height: AppSpacing.md),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),

            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),

              borderRadius: BorderRadius.circular(20),
            ),

            child: Text(
              'Premium Member',

              style: AppTypography.moTa.copyWith(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}
