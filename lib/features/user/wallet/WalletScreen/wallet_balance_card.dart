// features/user/wallet/wallet_balance_card.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class WalletBalanceCard extends StatelessWidget {
  const WalletBalanceCard({super.key});

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
            'Số dư hiện tại',

            style: AppTypography.noiDung.copyWith(color: Colors.white70),
          ),

          const SizedBox(height: AppSpacing.md),

          Text(
            '12.500.000đ',

            style: AppTypography.gia.copyWith(
              color: Colors.white,

              fontSize: 32,
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              thongTin(tieuDe: 'Đã nhận', giaTri: '18M'),

              thongTin(tieuDe: 'Đã rút', giaTri: '5.5M'),
            ],
          ),
        ],
      ),
    );
  }

  Widget thongTin({required String tieuDe, required String giaTri}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(tieuDe, style: AppTypography.moTa.copyWith(color: Colors.white70)),

        const SizedBox(height: 4),

        Text(
          giaTri,

          style: AppTypography.noiDung.copyWith(
            color: Colors.white,

            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
