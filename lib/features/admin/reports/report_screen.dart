import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/headers/custom_app_bar.dart';

import 'report_stat_card.dart';
import 'revenue_chart_section.dart';
import 'top_product_section.dart';
import 'consignment_report_card.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: const CustomAppBar(tieuDe: 'Báo cáo & thống kê'),

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
                ReportStatCard(
                  title: 'Doanh thu',
                  value: '120M',
                  icon: Icons.attach_money,
                ),

                ReportStatCard(
                  title: 'Đơn hàng',
                  value: '245',
                  icon: Icons.shopping_bag,
                ),

                ReportStatCard(
                  title: 'Ký gửi',
                  value: '82',
                  icon: Icons.inventory_2,
                ),

                ReportStatCard(
                  title: 'Người dùng',
                  value: '1.2K',
                  icon: Icons.people,
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
