// features/user/order/order_summary_card.dart

import 'package:flutter/material.dart';

import '../../../../models/order_model.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class OrderSummaryCard extends StatelessWidget {
  final DonHangModel donHang;

  const OrderSummaryCard({super.key, required this.donHang});

  Widget dongThongTin({
    required String tieuDe,
    required String giaTri,
    bool tong = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text(
            tieuDe,

            style: tong ? AppTypography.tieuDeNho : AppTypography.noiDung,
          ),

          Text(giaTri, style: tong ? AppTypography.gia : AppTypography.noiDung),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            giaTri: '${donHang.tongTien.toStringAsFixed(0)}đ',
          ),

          dongThongTin(
            tieuDe: 'Phí vận chuyển',
            giaTri: '${donHang.phiVanChuyen.toStringAsFixed(0)}đ',
          ),

          const Divider(),

          dongThongTin(
            tieuDe: 'Tổng thanh toán',
            giaTri:
                '${(donHang.tongTien + donHang.phiVanChuyen).toStringAsFixed(0)}đ',
            tong: true,
          ),
        ],
      ),
    );
  }
}
