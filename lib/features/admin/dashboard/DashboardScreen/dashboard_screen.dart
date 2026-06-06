// features/admin/dashboard/dashboard_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/headers/custom_app_bar.dart';
import '../../../../models/order_model.dart';
import '../../../../providers/store_provider.dart';
import '../../../user/auth/screens/LoginScreen/login_screen.dart';
import '../../commission/CommissionScreen/commission_screen.dart';
import '../../../user/notification/notification_screen.dart';
import '../../orders/OrderDetailAdminScreen/admin_order_detail_screen.dart';
import '../../../../core/navigation/admin_navigation.dart';
import 'dashboard_chart_card.dart';
import 'dashboard_stat_card.dart';
import 'quick_action_card.dart';
import 'recent_order_card.dart';
import '../../reports/admin_revenue_history_screen.dart';
import '../../users/UserManagementScreen/user_management_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<StoreProvider>(context);

    // 1. Tính toán thống kê động (đồng bộ với màn hình Báo cáo)
    final double tongDoanhThu = store.adminTotalRevenue;
    final soDonHang = store.adminTotalOrdersCount.toString();
    final soKyGui = store.adminTotalConsignmentsCount.toString();
    final soNguoiDung = store.adminTotalUsersCount.toString();

    String formatMoney(double amount) {
      return amount.toVND();
    }

    // 2. Lấy 3 đơn hàng gần nhất
    final ordersGanDay = List<DonHangModel>.from(store.danhSachDonHang)
      ..sort((a, b) => b.ngayTao.compareTo(a.ngayTao));
    final recentOrders = ordersGanDay.take(3).toList();

    // 3. Lấy yêu cầu rút tiền chờ xử lý (loai == 'RUT_TIEN' và trangThai == 'CHO_XAC_NHAN')
    final pendingWithdrawals = store.danhSachGiaoDich
        .where((g) => g.loai == 'RUT_TIEN' && g.trangThai == 'CHO_XAC_NHAN')
        .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        tieuDe: 'Dashboard',
        hienThiNutBack: false,
        actions: [
          // Icon Cấu hình Hoa hồng
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: AppColors.textPrimary),
            tooltip: 'Cấu hình hoa hồng',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CommissionScreen()),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          // Icon Quả chuông Thông báo cho Admin
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NotificationScreen()),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.border),
                  ),
                  child: const Icon(
                    Icons.notifications_outlined,
                    color: AppColors.textPrimary,
                  ),
                ),
                Positioned(
                  top: -2,
                  right: -2,
                  child: Consumer<StoreProvider>(
                    builder: (context, store, _) {
                      final count = store.soThongBaoChuaDoc;
                      if (count == 0) return const SizedBox();
                      return Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: AppColors.error,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Center(
                          child: Text(
                            count > 9 ? '9+' : '$count',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: AppColors.error),
            tooltip: 'Đăng xuất',
            onPressed: () async {
              await store.logout();
              if (context.mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              }
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thống kê thẻ Grid
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: AppSpacing.lg,
              mainAxisSpacing: AppSpacing.lg,
              childAspectRatio: 1.25,
              children: [
                DashboardStatCard(
                  title: 'Doanh thu',
                  value: formatMoney(tongDoanhThu),
                  icon: Icons.attach_money,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AdminRevenueHistoryScreen()),
                  ),
                ),
                DashboardStatCard(
                  title: 'Đơn hàng',
                  value: soDonHang,
                  icon: Icons.shopping_bag,
                  onTap: () {
                    final navState = context.findAncestorStateOfType<AdminNavigationState>();
                    if (navState != null) navState.setTab(2);
                  },
                ),
                DashboardStatCard(
                  title: 'Ký gửi',
                  value: soKyGui,
                  icon: Icons.inventory_2,
                  onTap: () {
                    final navState = context.findAncestorStateOfType<AdminNavigationState>();
                    if (navState != null) navState.setTab(3);
                  },
                ),
                DashboardStatCard(
                  title: 'Người dùng',
                  value: soNguoiDung,
                  icon: Icons.people,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const UserManagementScreen()),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),

            const DashboardChartCard(),
            const SizedBox(height: AppSpacing.xl),

            // DANH SÁCH YÊU CẦU RÚT TIỀN (PHẦN MỚI)
            Text(
              'Yêu cầu rút tiền chờ xử lý (${pendingWithdrawals.length})',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.lg),
            if (pendingWithdrawals.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Center(
                  child: Text('Không có yêu cầu rút tiền nào cần xử lý'),
                ),
              )
            else
              ...pendingWithdrawals.map((tx) {
                // Tìm ví để lấy ra người dùng
                final wallet = store.danhSachVi.firstWhere((v) => v.id == tx.viId);
                final user = store.danhSachNguoiDung.firstWhere((u) => u.id == wallet.nguoiDungId);

                return Container(
                  margin: const EdgeInsets.only(bottom: AppSpacing.md),
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(user.ten, style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text(
                            '-${tx.soTien.toVND()}',
                            style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.error),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(tx.moTa, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                      const SizedBox(height: AppSpacing.md),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(foregroundColor: AppColors.error),
                            onPressed: () {
                              store.rejectWithdrawal(tx.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Đã từ chối yêu cầu rút tiền')),
                              );
                            },
                            child: const Text('Từ chối'),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.success,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              store.approveWithdrawal(tx.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Xác nhận rút tiền thành công (Đã trừ số dư ví)'),
                                  backgroundColor: AppColors.success,
                                ),
                              );
                            },
                            child: const Text('Xác nhận thanh toán'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
            const SizedBox(height: AppSpacing.xl),

            // Đơn hàng gần đây
            Text(
              'Đơn hàng gần đây',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.lg),
            ...recentOrders.map((o) {
              final user = store.danhSachNguoiDung.firstWhere(
                (u) => u.id == o.nguoiDungId,
                orElse: () => store.danhSachNguoiDung.first,
              );
              
              String trangThaiViet = o.trangThai;
              if (o.trangThai == 'DANG_GIAO') trangThaiViet = 'Đang giao';
              if (o.trangThai == 'HOAN_THANH') trangThaiViet = 'Hoàn thành';
              if (o.trangThai == 'DA_HUY') trangThaiViet = 'Đã hủy';

              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AdminOrderDetailScreen(donHang: o),
                    ),
                  ),
                  child: RecentOrderCard(
                    maDon: o.id,
                    khachHang: user.ten,
                    tongTien: o.tongTien.toVND(),
                    trangThai: trangThaiViet,
                  ),
                ),
              );

            }).toList(),
            const SizedBox(height: AppSpacing.xl),

            Text(
              'Truy cập nhanh',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                Expanded(
                  child: QuickActionCard(
                    title: 'Sản phẩm',
                    icon: Icons.inventory,
                    onTap: () {
                      final navState = context.findAncestorStateOfType<AdminNavigationState>();
                      if (navState != null) navState.setTab(1);
                    },
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: QuickActionCard(
                    title: 'Đơn hàng',
                    icon: Icons.shopping_cart,
                    onTap: () {
                      final navState = context.findAncestorStateOfType<AdminNavigationState>();
                      if (navState != null) navState.setTab(2);
                    },
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: QuickActionCard(
                    title: 'Ký gửi',
                    icon: Icons.sell,
                    onTap: () {
                      final navState = context.findAncestorStateOfType<AdminNavigationState>();
                      if (navState != null) navState.setTab(3);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

