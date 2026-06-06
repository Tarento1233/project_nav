// features/admin/users/user_statistics_card.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../models/user_model.dart';
import '../../../../providers/store_provider.dart';

class UserStatisticsCard extends StatelessWidget {
  final NguoiDungModel user;

  const UserStatisticsCard({super.key, required this.user});

  Widget item({required String title, required String value}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: AppTypography.gia.copyWith(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTypography.moTa.copyWith(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<StoreProvider>(context);

    // Tính toán số liệu thống kê thực tế từ database
    final totalOrders = store.danhSachDonHang.where((o) => o.nguoiDungId == user.id).length;
    
    final completedOrders = store.danhSachDonHang
        .where((o) => o.nguoiDungId == user.id && o.trangThai == 'HOAN_THANH')
        .toList();
    final totalSpending = completedOrders.fold<double>(0, (sum, order) => sum + order.tongTien);

    final totalConsignments = store.danhSachKyGui.where((k) => k.nguoiDungId == user.id).length;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: AppShadows.cardShadow,
      ),
      child: Row(
        children: [
          item(title: 'Đơn hàng', value: '$totalOrders'),
          const SizedBox(width: AppSpacing.md),
          item(title: 'Chi tiêu', value: totalSpending.toVND()),
          const SizedBox(width: AppSpacing.md),
          item(title: 'Ký gửi', value: '$totalConsignments'),
        ],
      ),
    );
  }
}
