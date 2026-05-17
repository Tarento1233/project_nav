// features/admin/consignments/consignor_info_card.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class ConsignorInfoCard extends StatelessWidget {
  const ConsignorInfoCard({super.key});

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

      padding: const EdgeInsets.all(AppSpacing.lg),

      decoration: BoxDecoration(
        color: AppColors.surface,

        borderRadius: BorderRadius.circular(AppRadius.lg),

        boxShadow: AppShadows.cardShadow,
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text('Thông tin người gửi', style: AppTypography.tieuDeNho),

          const SizedBox(height: AppSpacing.lg),

          thongTin(title: 'Người gửi', value: 'USER_01'),

          thongTin(title: 'Ngày gửi', value: '12/05/2026'),

          thongTin(title: 'Số điện thoại', value: '0901234567'),
        ],
      ),
    );
  }
}
