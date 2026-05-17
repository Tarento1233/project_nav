// features/user/wallet/wallet_screen.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

import '../../../../core/widgets/headers/custom_app_bar.dart';

import 'wallet_balance_card.dart';
import 'revenue_summary_card.dart';
import 'transaction_card.dart';
import 'withdraw_button_section.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: const CustomAppBar(tieuDe: 'Ví của tôi'),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),

        child: Column(
          children: [
            const WalletBalanceCard(),

            const SizedBox(height: AppSpacing.xl),

            const RevenueSummaryCard(),

            const SizedBox(height: AppSpacing.xl),

            const WithdrawButtonSection(),

            const SizedBox(height: AppSpacing.xl),

            Align(
              alignment: Alignment.centerLeft,

              child: Text(
                'Lịch sử giao dịch',

                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            const TransactionCard(
              tieuDe: 'Thanh toán đơn hàng',

              thoiGian: '12/05/2026',

              soTien: '+2.200.000đ',

              trangThai: 'Thành công',
            ),

            const SizedBox(height: AppSpacing.md),

            const TransactionCard(
              tieuDe: 'Rút tiền về ngân hàng',

              thoiGian: '10/05/2026',

              soTien: '-1.500.000đ',

              trangThai: 'Đã xử lý',
            ),
          ],
        ),
      ),
    );
  }
}
