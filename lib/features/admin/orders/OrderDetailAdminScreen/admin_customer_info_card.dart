// features/admin/orders/admin_customer_info_card.dart

import 'package:flutter/material.dart';

import '../../../../models/order_model.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class AdminCustomerInfoCard extends StatelessWidget {
  final DonHangModel donHang;

  const AdminCustomerInfoCard({super.key, required this.donHang});

  Widget thongTin({required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text(title, style: AppTypography.moTa),

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
          Text('Thông tin khách hàng', style: AppTypography.tieuDeNho),

          const SizedBox(height: AppSpacing.lg),

          thongTin(title: 'Mã đơn', value: donHang.id),

          thongTin(title: 'Khách hàng', value: donHang.nguoiDungId),

          thongTin(title: 'Địa chỉ', value: donHang.diaChiId),

          thongTin(title: 'Trạng thái', value: donHang.trangThai),
        ],
      ),
    );
  }
}
