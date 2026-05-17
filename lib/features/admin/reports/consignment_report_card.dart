// features/admin/reports/consignment_report_card.dart

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

class ConsignmentReportCard extends StatelessWidget {
  const ConsignmentReportCard({super.key});

  Widget thongTin({required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text(title, style: AppTypography.noiDung),

          Text(
            value,

            style: AppTypography.noiDung.copyWith(
              color: AppColors.primary,

              fontWeight: FontWeight.bold,
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
          Text('Báo cáo ký gửi', style: AppTypography.tieuDeNho),

          const SizedBox(height: AppSpacing.lg),

          thongTin(title: 'Ký gửi chờ duyệt', value: '12'),

          thongTin(title: 'Ký gửi đã bán', value: '36'),

          thongTin(title: 'Ký gửi bị từ chối', value: '5'),
        ],
      ),
    );
  }
}
