// features/user/wallet/transaction_card.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class TransactionCard extends StatelessWidget {
  final String tieuDe;

  final String thoiGian;

  final String soTien;

  final String trangThai;

  const TransactionCard({
    super.key,
    required this.tieuDe,
    required this.thoiGian,
    required this.soTien,
    required this.trangThai,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),

      decoration: BoxDecoration(
        color: AppColors.surface,

        borderRadius: BorderRadius.circular(AppRadius.lg),

        boxShadow: AppShadows.cardShadow,
      ),

      child: Row(
        children: [
          Container(
            width: 50,

            height: 50,

            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),

              shape: BoxShape.circle,
            ),

            child: const Icon(
              Icons.account_balance_wallet,

              color: AppColors.primary,
            ),
          ),

          const SizedBox(width: AppSpacing.md),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(tieuDe, style: AppTypography.noiDung),

                const SizedBox(height: 4),

                Text(thoiGian, style: AppTypography.moTa),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,

            children: [
              Text(soTien, style: AppTypography.gia),

              const SizedBox(height: 4),

              Text(trangThai, style: AppTypography.moTa),
            ],
          ),
        ],
      ),
    );
  }
}
