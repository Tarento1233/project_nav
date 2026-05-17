// features/user/wallet/withdraw_amount_input.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class WithdrawAmountInput extends StatelessWidget {
  const WithdrawAmountInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text('Số tiền muốn rút', style: AppTypography.tieuDeNho),

        const SizedBox(height: AppSpacing.md),

        TextField(
          keyboardType: TextInputType.number,

          decoration: InputDecoration(
            hintText: 'Nhập số tiền',

            filled: true,

            fillColor: AppColors.surface,

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.lg),

              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
