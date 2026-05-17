// features/user/consignment/consignment_status_card.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

import '../../../../core/widgets/badges/status_badge.dart';

class ConsignmentStatusCard extends StatelessWidget {
  final String trangThai;

  const ConsignmentStatusCard({super.key, required this.trangThai});

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

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text('Trạng thái ký gửi', style: AppTypography.tieuDeNho),

          StatusBadge(trangThai: trangThai),
        ],
      ),
    );
  }
}
