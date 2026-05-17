// features/user/consignment/consignment_term_detail.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class ConsignmentTermDetail extends StatelessWidget {
  const ConsignmentTermDetail({super.key});

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

              fontWeight: FontWeight.w600,
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
          Text('Điều khoản ký gửi', style: AppTypography.tieuDeNho),

          const SizedBox(height: AppSpacing.lg),

          thongTin(title: 'Giá bán', value: '2.200.000đ'),

          thongTin(title: 'Hoa hồng', value: '20%'),

          thongTin(title: 'Thời gian ký gửi', value: '30 ngày'),
        ],
      ),
    );
  }
}
