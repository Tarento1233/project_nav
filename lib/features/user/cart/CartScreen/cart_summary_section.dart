// features/user/cart/cart_summary_section.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class CartSummarySection extends StatelessWidget {
  const CartSummarySection({super.key});

  Widget dongThongTin({
    required String tieuDe,
    required String giaTri,
    bool laTong = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text(
            tieuDe,

            style: laTong ? AppTypography.tieuDeNho : AppTypography.noiDung,
          ),

          Text(
            giaTri,

            style: laTong ? AppTypography.gia : AppTypography.noiDung,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppSpacing.lg),

      padding: const EdgeInsets.all(AppSpacing.lg),

      decoration: BoxDecoration(
        color: AppColors.surface,

        borderRadius: BorderRadius.circular(AppRadius.lg),

        boxShadow: AppShadows.cardShadow,
      ),

      child: Column(
        children: [
          dongThongTin(tieuDe: 'Tạm tính', giaTri: '6.500.000đ'),

          dongThongTin(tieuDe: 'Phí vận chuyển', giaTri: '39.000đ'),

          dongThongTin(tieuDe: 'Giảm giá', giaTri: '-150.000đ'),

          const Divider(),

          dongThongTin(
            tieuDe: 'Tổng thanh toán',
            giaTri: '6.389.000đ',
            laTong: true,
          ),
        ],
      ),
    );
  }
}
