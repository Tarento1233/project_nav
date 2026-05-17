// features/admin/orders/admin_order_card.dart

import 'package:flutter/material.dart';

import '../../../../models/order_model.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

import '../../../../core/widgets/badges/status_badge.dart';

import 'update_order_status_button.dart';

class AdminOrderCard extends StatelessWidget {
  final DonHangModel donHang;

  final VoidCallback onDetail;

  final VoidCallback onUpdate;

  const AdminOrderCard({
    super.key,
    required this.donHang,
    required this.onDetail,
    required this.onUpdate,
  });

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
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Text(donHang.id, style: AppTypography.tieuDeNho),

              StatusBadge(trangThai: donHang.trangThai),
            ],
          ),

          const SizedBox(height: AppSpacing.md),

          Text(
            'Khách hàng: ${donHang.nguoiDungId}',

            style: AppTypography.noiDung,
          ),

          const SizedBox(height: AppSpacing.sm),

          Text(
            'Tổng tiền: ${donHang.tongTien.toStringAsFixed(0)}đ',

            style: AppTypography.gia,
          ),

          const SizedBox(height: AppSpacing.sm),

          Text(
            'Ngày tạo: ${donHang.ngayTao.day}/${donHang.ngayTao.month}/${donHang.ngayTao.year}',

            style: AppTypography.moTa,
          ),

          const SizedBox(height: AppSpacing.lg),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onDetail,

                  child: const Text('Chi tiết'),
                ),
              ),

              const SizedBox(width: AppSpacing.md),

              Expanded(child: UpdateOrderStatusButton(onPressed: onUpdate)),
            ],
          ),
        ],
      ),
    );
  }
}
