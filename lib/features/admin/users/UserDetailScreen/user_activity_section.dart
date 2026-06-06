// features/admin/users/user_activity_section.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../models/user_model.dart';
import '../../../../providers/store_provider.dart';

class UserActivitySection extends StatelessWidget {
  final NguoiDungModel user;

  const UserActivitySection({super.key, required this.user});

  Widget activityItem({required String title, required String time}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.history, color: AppColors.primary),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.noiDung),
                const SizedBox(height: 4),
                Text(time, style: AppTypography.moTa),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<StoreProvider>(context);

    // Thu thập hoạt động gần đây
    final userOrders = store.danhSachDonHang.where((o) => o.nguoiDungId == user.id).toList();
    final userConsignments = store.danhSachKyGui.where((k) => k.nguoiDungId == user.id).toList();
    
    final walletIdx = store.danhSachVi.indexWhere((v) => v.nguoiDungId == user.id);
    final walletId = walletIdx != -1 ? store.danhSachVi[walletIdx].id : 'V_${user.id}';
    final userTransactions = store.danhSachGiaoDich.where((g) => g.viId == walletId).toList();

    final activitiesList = <_ActivityLog>[];

    for (var order in userOrders) {
      activitiesList.add(_ActivityLog(
        title: 'Đặt đơn hàng #${order.id} - ${order.tongTien.toVND()}',
        date: order.ngayTao,
      ));
    }

    for (var consignment in userConsignments) {
      activitiesList.add(_ActivityLog(
        title: 'Yêu cầu ký gửi: ${consignment.tenSanPham}',
        date: consignment.ngayTao,
      ));
    }

    for (var tx in userTransactions) {
      if (tx.loai == 'RUT_TIEN') {
        activitiesList.add(_ActivityLog(
          title: 'Yêu cầu rút tiền: -${tx.soTien.toVND()}',
          date: tx.ngayTao,
        ));
      } else if (tx.loai == 'NHAN_TIEN_KY_GUI') {
        activitiesList.add(_ActivityLog(
          title: 'Nhận tiền ký gửi: +${tx.soTien.toVND()}',
          date: tx.ngayTao,
        ));
      }
    }

    // Sắp xếp các hoạt động theo thời gian mới nhất
    activitiesList.sort((a, b) => b.date.compareTo(a.date));
    final displayActivities = activitiesList.take(3).toList();

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
          Text('Hoạt động gần đây', style: AppTypography.tieuDeNho),
          const SizedBox(height: AppSpacing.lg),
          if (displayActivities.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Center(
                child: Text(
                  'Không có hoạt động nào gần đây',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ),
            )
          else
            ...displayActivities.map((act) {
              final formattedTime = '${act.date.day.toString().padLeft(2, '0')}/${act.date.month.toString().padLeft(2, '0')}/${act.date.year} ${act.date.hour.toString().padLeft(2, '0')}:${act.date.minute.toString().padLeft(2, '0')}';
              return activityItem(title: act.title, time: formattedTime);
            }),
        ],
      ),
    );
  }
}

class _ActivityLog {
  final String title;
  final DateTime date;

  _ActivityLog({required this.title, required this.date});
}
