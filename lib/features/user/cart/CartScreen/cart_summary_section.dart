import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../providers/store_provider.dart';

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
    return Consumer<StoreProvider>(
      builder: (context, store, child) {
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
              dongThongTin(
                tieuDe: 'Tạm tính',
                giaTri: store.cartSubtotal.toVND(),
              ),

              dongThongTin(
                tieuDe: 'Phí vận chuyển',
                giaTri: store.shippingFee.toVND(),
              ),

              if (store.discount > 0)
                dongThongTin(
                  tieuDe: 'Giảm giá',
                  giaTri: '-${store.discount.toVND()}',
                ),

              const Divider(),

              dongThongTin(
                tieuDe: 'Tổng thanh toán',
                giaTri: store.cartTotal.toVND(),
                laTong: true,
              ),
            ],
          ),
        );
      },
    );
  }
}
