import 'package:flutter/material.dart';

import '../../../../models/order_model.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

import '../../../../core/widgets/badges/status_badge.dart';

class OrderCard extends StatelessWidget {
  final DonHangModel donHang;

  final VoidCallback onTap;

  const OrderCard({super.key, required this.donHang, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),

        decoration: BoxDecoration(
          color: AppColors.surface,

          borderRadius: BorderRadius.circular(AppRadius.lg),

          boxShadow: AppShadows.cardShadow,
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text('Đơn #${donHang.id}', style: AppTypography.tieuDeNho),

                StatusBadge(trangThai: donHang.trangThai),
              ],
            ),

            const SizedBox(height: AppSpacing.md),

            Text('4 sản phẩm', style: AppTypography.moTa),

            const SizedBox(height: AppSpacing.sm),

            Text('Ngày đặt: ${donHang.ngayTao}', style: AppTypography.moTa),

            const SizedBox(height: AppSpacing.lg),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text('Tổng thanh toán', style: AppTypography.noiDung),

                Text(
                  '${donHang.tongTien.toStringAsFixed(0)}đ',

                  style: AppTypography.gia,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
