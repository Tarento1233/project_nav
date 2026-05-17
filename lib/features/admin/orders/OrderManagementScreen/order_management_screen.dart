// features/admin/orders/order_management_screen.dart

import 'package:flutter/material.dart';

import '../../../../core/constants/mock_data.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

import '../../../../core/widgets/headers/custom_app_bar.dart';

import 'admin_order_card.dart';
import 'order_search_bar.dart';
import 'order_status_filter.dart';

class OrderManagementScreen extends StatelessWidget {
  const OrderManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final danhSachDonHang = DuLieuMau.danhSachDonHang;

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: const CustomAppBar(tieuDe: 'Quản lý đơn hàng'),

      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(AppSpacing.lg),

            child: Column(
              children: [
                OrderSearchBar(),

                SizedBox(height: AppSpacing.lg),

                OrderStatusFilter(),
              ],
            ),
          ),

          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),

              itemCount: danhSachDonHang.length,

              separatorBuilder: (_, __) =>
                  const SizedBox(height: AppSpacing.lg),

              itemBuilder: (context, index) {
                return AdminOrderCard(
                  donHang: danhSachDonHang[index],

                  onDetail: () {},

                  onUpdate: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
