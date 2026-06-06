// features/user/profile/profile_header.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../providers/store_provider.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<StoreProvider>(context);
    final user = store.currentUser;
    final tenStr = user?.ten ?? 'Chưa đăng nhập';
    final emailStr = user?.email ?? '';
    final roleStr = user?.vaiTro == 'ADMIN' ? 'Shop Admin' : 'Người ký gửi';
    final avatarUrl = user?.avatar ?? 'https://i.pravatar.cc/300';

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
          CircleAvatar(
            radius: 45,
            backgroundImage: NetworkImage(avatarUrl),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(tenStr, style: AppTypography.tieuDe),
          const SizedBox(height: 4),
          Text(emailStr, style: AppTypography.moTa),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              roleStr,
              style: AppTypography.moTa.copyWith(color: AppColors.primaryDark),
            ),
          ),
        ],
      ),
    );
  }
}

