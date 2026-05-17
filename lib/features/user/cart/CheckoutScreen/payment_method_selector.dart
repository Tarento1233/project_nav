// features/user/checkout/payment_method_selector.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class PaymentMethodSelector extends StatelessWidget {
  const PaymentMethodSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final methods = [
      'Thanh toán khi nhận hàng',

      'Ví OutletPay',

      'Chuyển khoản ngân hàng',
    ];

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),

      decoration: BoxDecoration(
        color: AppColors.surface,

        borderRadius: BorderRadius.circular(AppRadius.lg),

        boxShadow: AppShadows.cardShadow,
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text('Phương thức thanh toán', style: AppTypography.tieuDeNho),

          const SizedBox(height: AppSpacing.lg),

          ...methods.map((method) {
            final dangChon = method == methods.first;

            return Container(
              margin: const EdgeInsets.only(bottom: AppSpacing.md),

              padding: const EdgeInsets.all(AppSpacing.md),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.md),

                border: Border.all(
                  color: dangChon ? AppColors.primary : AppColors.border,
                ),
              ),

              child: Row(
                children: [
                  Icon(
                    dangChon
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off,

                    color: AppColors.primary,
                  ),

                  const SizedBox(width: AppSpacing.md),

                  Expanded(child: Text(method, style: AppTypography.noiDung)),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
