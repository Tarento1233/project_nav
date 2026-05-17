// features/admin/dashboard/dashboard_screen.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

import '../../../../core/widgets/headers/custom_app_bar.dart';

import 'dashboard_stat_card.dart';
import 'dashboard_chart_card.dart';
import 'recent_order_card.dart';
import 'quick_action_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: const CustomAppBar(tieuDe: 'Dashboard'),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            GridView.count(
              crossAxisCount: 2,

              shrinkWrap: true,

              physics: const NeverScrollableScrollPhysics(),

              crossAxisSpacing: AppSpacing.lg,

              mainAxisSpacing: AppSpacing.lg,

              childAspectRatio: 1.1,

              children: const [
                DashboardStatCard(
                  title: 'Doanh thu',
                  value: '120M',
                  icon: Icons.attach_money,
                ),

                DashboardStatCard(
                  title: 'Đơn hàng',
                  value: '245',
                  icon: Icons.shopping_bag,
                ),

                DashboardStatCard(
                  title: 'Ký gửi',
                  value: '82',
                  icon: Icons.inventory_2,
                ),

                DashboardStatCard(
                  title: 'Người dùng',
                  value: '1.2K',
                  icon: Icons.people,
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.xl),

            const DashboardChartCard(),

            const SizedBox(height: AppSpacing.xl),

            Text(
              'Đơn hàng gần đây',

              style: Theme.of(context).textTheme.titleMedium,
            ),

            const SizedBox(height: AppSpacing.lg),

            const RecentOrderCard(
              maDon: 'DH001',

              khachHang: 'Nguyễn Văn A',

              tongTien: '2.200.000đ',

              trangThai: 'Đang giao',
            ),

            const SizedBox(height: AppSpacing.md),

            const RecentOrderCard(
              maDon: 'DH002',

              khachHang: 'Trần Thị B',

              tongTien: '1.500.000đ',

              trangThai: 'Hoàn thành',
            ),

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

                    onTap: () {},
                  ),
                ),

                const SizedBox(width: AppSpacing.md),

                Expanded(
                  child: QuickActionCard(
                    title: 'Đơn hàng',

                    icon: Icons.shopping_cart,

                    onTap: () {},
                  ),
                ),

                const SizedBox(width: AppSpacing.md),

                Expanded(
                  child: QuickActionCard(
                    title: 'Ký gửi',

                    icon: Icons.sell,

                    onTap: () {},
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
