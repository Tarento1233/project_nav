import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/headers/custom_app_bar.dart';

import 'report_stat_card.dart';
import 'revenue_chart_section.dart';
import 'top_product_section.dart';
import 'consignment_report_card.dart';
import 'admin_revenue_history_screen.dart';
import '../users/UserManagementScreen/user_management_screen.dart';
import '../../../core/navigation/admin_navigation.dart';

import '../../../core/theme/app_typography.dart';
import 'package:provider/provider.dart';
import '../../../providers/store_provider.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<StoreProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: const CustomAppBar(tieuDe: 'Thống kê & báo cáo'),

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

              children: [
                 ReportStatCard(
                  title: 'Doanh thu',
                  value: store.adminTotalRevenue.toVND(),
                  icon: Icons.attach_money,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AdminRevenueHistoryScreen()),
                  ),
                ),

                ReportStatCard(
                  title: 'Đơn hàng',
                  value: '${store.adminTotalOrdersCount}',
                  icon: Icons.shopping_bag,
                  onTap: () {
                    final navState = context.findAncestorStateOfType<AdminNavigationState>();
                    if (navState != null) navState.setTab(2);
                  },
                ),

                ReportStatCard(
                  title: 'Ký gửi',
                  value: '${store.adminTotalConsignmentsCount}',
                  icon: Icons.inventory_2,
                  onTap: () {
                    final navState = context.findAncestorStateOfType<AdminNavigationState>();
                    if (navState != null) navState.setTab(3);
                  },
                ),

                ReportStatCard(
                  title: 'Người dùng',
                  value: '${store.adminTotalUsersCount}',
                  icon: Icons.people,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const UserManagementScreen()),
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.xl),

            const RevenueChartSection(),

            const SizedBox(height: AppSpacing.xl),

            const TopProductSection(),

            const SizedBox(height: AppSpacing.xl),

            const ConsignmentReportCard(),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
