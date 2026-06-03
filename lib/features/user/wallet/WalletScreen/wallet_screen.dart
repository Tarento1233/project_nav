// features/user/wallet/WalletScreen/wallet_screen.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/headers/custom_app_bar.dart';
import '../WithdrawScreen/withdraw_screen.dart';

import 'wallet_balance_card.dart';
import 'revenue_summary_card.dart';
import 'transaction_card.dart';
import 'withdraw_button_section.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/headers/custom_app_bar.dart';
import '../../../../providers/store_provider.dart';
import '../WithdrawScreen/withdraw_screen.dart';

import 'wallet_balance_card.dart';
import 'revenue_summary_card.dart';
import 'transaction_card.dart';
import 'withdraw_button_section.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<StoreProvider>(context);

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
            // Nút rút tiền → WithdrawScreen
            WithdrawButtonSection(
              onRutTien: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const WithdrawScreen()),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Lịch sử giao dịch',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            
            if (store.giaoDichCuaToi.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30.0),
                child: Text('Không có lịch sử giao dịch nào.'),
              )
            else
              ...store.giaoDichCuaToi.map((tx) {
                final dateStr = '${tx.ngayTao.day.toString().padLeft(2, '0')}/${tx.ngayTao.month.toString().padLeft(2, '0')}/${tx.ngayTao.year}';
                final amountPrefix = tx.loai == 'NHAN_TIEN_KY_GUI' ? '+' : '-';
                
                String labelType = 'Giao dịch ví';
                if (tx.loai == 'NHAN_TIEN_KY_GUI') {
                  labelType = 'Nhận tiền ký gửi';
                } else if (tx.loai == 'RUT_TIEN') {
                  labelType = 'Yêu cầu rút tiền';
                }

                String statusLabel = 'Đã xử lý';
                if (tx.trangThai == 'CHO_XAC_NHAN') {
                  statusLabel = 'Chờ duyệt';
                } else if (tx.trangThai == 'THANH_CONG') {
                  statusLabel = 'Thành công';
                } else if (tx.trangThai == 'THAT_BAI') {
                  statusLabel = 'Từ chối';
                }

                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: TransactionCard(
                    tieuDe: tx.moTa.isNotEmpty ? tx.moTa : labelType,
                    thoiGian: dateStr,
                    soTien: '$amountPrefix${tx.soTien.toStringAsFixed(0)}đ',
                    trangThai: statusLabel,
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }
}

