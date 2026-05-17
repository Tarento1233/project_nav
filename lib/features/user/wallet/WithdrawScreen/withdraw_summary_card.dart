// features/user/wallet/withdraw_summary_card.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class WithdrawSummaryCard extends StatelessWidget {
  const WithdrawSummaryCard({super.key});

  Widget dongThongTin({required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text(title, style: AppTypography.noiDung),

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
        children: [
          dongThongTin(title: 'Số tiền rút', value: '2.000.000đ'),

          dongThongTin(title: 'Phí giao dịch', value: '10.000đ'),

          const Divider(),

          dongThongTin(title: 'Thực nhận', value: '1.990.000đ'),
        ],
      ),
    );
  }
}
