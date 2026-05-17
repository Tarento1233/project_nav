// features/admin/users/user_profile_card.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class UserProfileCard extends StatelessWidget {
  const UserProfileCard({super.key});

  Widget thongTin({required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text(title, style: AppTypography.moTa),

          Text(value, style: AppTypography.noiDung),
        ],
      ),
    );
  }

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

          const SizedBox(height: AppSpacing.lg),

          thongTin(title: 'Role', value: 'USER'),

          thongTin(title: 'Trạng thái', value: 'ACTIVE'),

          thongTin(title: 'Số điện thoại', value: '0901234567'),

          thongTin(title: 'Ngày tham gia', value: '12/05/2026'),
        ],
      ),
    );
  }
}
