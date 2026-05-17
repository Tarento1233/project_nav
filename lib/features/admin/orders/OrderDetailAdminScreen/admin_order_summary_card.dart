// features/admin/orders/admin_order_summary_card.dart

import 'package:flutter/material.dart';

import '../../../../models/order_model.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class AdminOrderSummaryCard extends StatelessWidget {
  final DonHangModel donHang;

  const AdminOrderSummaryCard({super.key, required this.donHang});

  Widget thongTin({required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text(title, style: AppTypography.noiDung),

          Text(value, style: AppTypography.noiDung),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(AppSpacing.lg),

      decoration: BoxDecoration(
        color: AppColors.surface,

        borderRadius: BorderRadius.circular(AppRadius.lg),

        boxShadow: AppShadows.cardShadow,
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text('Tổng thanh toán', style: AppTypography.tieuDeNho),

          const SizedBox(height: AppSpacing.lg),

          thongTin(
            title: 'Tạm tính',
            value: '${donHang.tongTien.toStringAsFixed(0)}đ',
          ),

          thongTin(title: 'Phí vận chuyển', value: '30.000đ'),

          const Divider(),

          thongTin(
            title: 'Tổng cộng',
            value: '${(donHang.tongTien + 30000).toStringAsFixed(0)}đ',
          ),
        ],
      ),
    );
  }
}
