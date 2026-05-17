// features/admin/users/user_activity_section.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class UserActivitySection extends StatelessWidget {
  const UserActivitySection({super.key});

  Widget activityItem({required String title, required String time}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),

      child: Row(
        children: [
          Container(
            width: 45,

            height: 45,

            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),

              shape: BoxShape.circle,
            ),

            child: const Icon(Icons.history, color: AppColors.primary),
          ),

          const SizedBox(width: AppSpacing.md),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(title, style: AppTypography.noiDung),

                const SizedBox(height: 4),

                Text(time, style: AppTypography.moTa),
              ],
            ),
          ),
        ],
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

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text('Hoạt động gần đây', style: AppTypography.tieuDeNho),

          const SizedBox(height: AppSpacing.lg),

          activityItem(title: 'Đặt đơn hàng #DH001', time: '2 giờ trước'),

          activityItem(title: 'Tạo ký gửi mới', time: '1 ngày trước'),

          activityItem(title: 'Rút tiền về ngân hàng', time: '3 ngày trước'),
        ],
      ),
    );
  }
}
