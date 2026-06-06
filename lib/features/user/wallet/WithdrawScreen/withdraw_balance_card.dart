// features/user/wallet/withdraw_balance_card.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../providers/store_provider.dart';

class WithdrawBalanceCard extends StatelessWidget {
  const WithdrawBalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<StoreProvider>(context);
    final wallet = store.viCuaToi;
    final soDu = wallet?.soDuCoTheRut ?? 0;

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
            soDu.toVND(),
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

