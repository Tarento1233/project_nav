// features/admin/dashboard/recent_order_card.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class RecentOrderCard extends StatelessWidget {
  final String maDon;

  final String khachHang;

  final String tongTien;

  final String trangThai;

  const RecentOrderCard({
    super.key,
    required this.maDon,
    required this.khachHang,
    required this.tongTien,
    required this.trangThai,
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

      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(maDon, style: AppTypography.tieuDeNho),

                const SizedBox(height: 4),

                Text(khachHang, style: AppTypography.moTa),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,

            children: [
              Text(tongTien, style: AppTypography.gia),

              const SizedBox(height: 4),

              Text(
                trangThai,

                style: AppTypography.moTa.copyWith(color: AppColors.primary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
