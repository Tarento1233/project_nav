// features/user/cart/checkout_bottom_bar.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

import '../../../../core/widgets/buttons/primary_button.dart';

class CheckoutBottomBar extends StatelessWidget {
  final double tongTien;

  final VoidCallback onCheckout;

  const CheckoutBottomBar({
    super.key,
    required this.tongTien,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),

      decoration: const BoxDecoration(color: AppColors.surface),

      child: SafeArea(
        top: false,

        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                mainAxisSize: MainAxisSize.min,

                children: [
                  Text('Tổng tiền', style: AppTypography.moTa),

                  const SizedBox(height: 4),

                  Text(
                    '${tongTien.toStringAsFixed(0)}đ',

                    style: AppTypography.gia,
                  ),
                ],
              ),
            ),

            Expanded(
              child: PrimaryButton(tieuDe: 'Thanh toán', onPressed: onCheckout),
            ),
          ],
        ),
      ),
    );
  }
}
