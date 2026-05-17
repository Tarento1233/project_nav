// features/user/wallet/withdraw_balance_card.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class WithdrawBalanceCard extends StatelessWidget {
  const WithdrawBalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(AppSpacing.xl),

      decoration: BoxDecoration(
        color: AppColors.primary,

        borderRadius: BorderRadius.circular(AppRadius.lg),

        boxShadow: AppShadows.cardShadow,
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            'Số dư khả dụng',

            style: AppTypography.noiDung.copyWith(color: Colors.white70),
          ),

          const SizedBox(height: AppSpacing.md),

          Text(
            '12.500.000đ',

            style: AppTypography.gia.copyWith(
              color: Colors.white,

              fontSize: 30,
            ),
          ),
        ],
      ),
    );
  }
}
