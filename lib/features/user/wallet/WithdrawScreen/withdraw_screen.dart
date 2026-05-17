// features/user/wallet/withdraw_screen.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

import '../../../../core/widgets/headers/custom_app_bar.dart';

import 'withdraw_balance_card.dart';
import 'withdraw_amount_input.dart';
import 'bank_account_card.dart';
import 'withdraw_summary_card.dart';

class WithdrawScreen extends StatelessWidget {
  const WithdrawScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: const CustomAppBar(tieuDe: 'Rút tiền'),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),

        child: Column(
          children: [
            const WithdrawBalanceCard(),

            const SizedBox(height: AppSpacing.xl),

            const WithdrawAmountInput(),

            const SizedBox(height: AppSpacing.xl),

            const BankAccountCard(),

            const SizedBox(height: AppSpacing.xl),

            const WithdrawSummaryCard(),

            const SizedBox(height: AppSpacing.xl),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: () {},

                child: const Text('Xác nhận rút tiền'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
