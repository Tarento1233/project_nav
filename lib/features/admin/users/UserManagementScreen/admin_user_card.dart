// features/admin/users/admin_user_card.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

import 'user_action_button.dart';

class AdminUserCard extends StatelessWidget {
  final String tenNguoiDung;

  final String email;

  final String role;

  final String trangThai;

  final VoidCallback onDetail;

  final VoidCallback onAction;

  const AdminUserCard({
    super.key,
    required this.tenNguoiDung,
    required this.email,
    required this.role,
    required this.trangThai,
    required this.onDetail,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final biKhoa = trangThai == 'BLOCKED';

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),

      decoration: BoxDecoration(
        color: AppColors.surface,

        borderRadius: BorderRadius.circular(AppRadius.lg),

        boxShadow: AppShadows.cardShadow,
      ),

      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 28,

                backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
              ),

              const SizedBox(width: AppSpacing.md),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(tenNguoiDung, style: AppTypography.tieuDeNho),

                    const SizedBox(height: 4),

                    Text(email, style: AppTypography.moTa),

                    const SizedBox(height: AppSpacing.sm),

                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),

                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),

                            borderRadius: BorderRadius.circular(12),
                          ),

                          child: Text(
                            role,

                            style: AppTypography.moTa.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),

                        const SizedBox(width: AppSpacing.sm),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),

                          decoration: BoxDecoration(
                            color: biKhoa
                                ? Colors.red.withOpacity(0.1)
                                : Colors.green.withOpacity(0.1),

                            borderRadius: BorderRadius.circular(12),
                          ),

                          child: Text(
                            trangThai,

                            style: AppTypography.moTa.copyWith(
                              color: biKhoa ? Colors.red : Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onDetail,

                  child: const Text('Chi tiết'),
                ),
              ),

              const SizedBox(width: AppSpacing.md),

              Expanded(
                child: UserActionButton(
                  title: biKhoa ? 'Mở khóa' : 'Khóa',

                  onPressed: onAction,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
