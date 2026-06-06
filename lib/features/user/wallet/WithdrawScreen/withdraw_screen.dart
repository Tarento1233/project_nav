// features/user/wallet/withdraw_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/headers/custom_app_bar.dart';
import '../../../../providers/store_provider.dart';

import 'withdraw_balance_card.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final _amountController = TextEditingController();
  final _bankNameController = TextEditingController();
  final _bankAccountController = TextEditingController();
  final _accountHolderController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _bankNameController.dispose();
    _bankAccountController.dispose();
    _accountHolderController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: AppColors.primaryDark),
      filled: true,
      fillColor: AppColors.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        borderSide: BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
    );
  }

  void _xacNhanRutTien() {
    final amountText = _amountController.text.trim();
    final bankName = _bankNameController.text.trim();
    final bankAccount = _bankAccountController.text.trim();
    final accountHolder = _accountHolderController.text.trim();

    if (amountText.isEmpty || bankName.isEmpty || bankAccount.isEmpty || accountHolder.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng nhập đầy đủ thông tin yêu cầu rút tiền!'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final amount = double.tryParse(amountText);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Số tiền rút không hợp lệ!'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final store = Provider.of<StoreProvider>(context, listen: false);
    final vi = store.viCuaToi;

    if (vi == null || vi.soDuCoTheRut < amount) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Số dư khả dụng không đủ để thực hiện giao dịch!'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final success = store.requestWithdrawal(
      amount: amount,
      bankName: bankName,
      bankAccount: bankAccount,
      accountHolder: accountHolder,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tạo yêu cầu rút tiền thành công! Chờ Admin chuyển khoản.'),
          backgroundColor: AppColors.success,
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đã xảy ra lỗi khi tạo yêu cầu!'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(tieuDe: 'Rút tiền về ngân hàng'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WithdrawBalanceCard(),
            const SizedBox(height: AppSpacing.xl),
            
            Text('Số tiền muốn rút', style: AppTypography.tieuDeNho),
            const SizedBox(height: AppSpacing.sm),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: _inputDecoration('Nhập số tiền muốn rút', Icons.monetization_on_outlined),
            ),
            const SizedBox(height: AppSpacing.lg),

            Text('Thông tin tài khoản nhận tiền', style: AppTypography.tieuDeNho),
            const SizedBox(height: AppSpacing.sm),
            TextField(
              controller: _bankNameController,
              decoration: _inputDecoration('Tên ngân hàng (ví dụ: Vietcombank, MBBank...)', Icons.account_balance),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _bankAccountController,
              keyboardType: TextInputType.number,
              decoration: _inputDecoration('Số tài khoản nhận tiền', Icons.pin_outlined),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _accountHolderController,
              decoration: _inputDecoration('Tên chủ tài khoản (viết hoa không dấu)', Icons.person_outline),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Summary Info
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Phí giao dịch', style: AppTypography.noiDung),
                      Text('Miễn phí', style: AppTypography.noiDung.copyWith(color: AppColors.success, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Divider(height: AppSpacing.lg),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text('Thời gian xử lý dự kiến', style: AppTypography.noiDung),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Text('Trong vòng 24h làm việc', style: AppTypography.noiDung),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _xacNhanRutTien,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryDark,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                  ),
                ),
                child: Text('Xác nhận yêu cầu rút tiền', style: AppTypography.tieuDeNho.copyWith(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

