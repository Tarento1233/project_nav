// features/admin/orders/OrderManagementScreen/order_management_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/mock_data.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/headers/custom_app_bar.dart';
import '../../../../providers/store_provider.dart';
import '../OrderDetailAdminScreen/admin_order_detail_screen.dart';


import 'admin_order_card.dart';
import 'order_search_bar.dart';
import 'order_status_filter.dart';

class OrderManagementScreen extends StatelessWidget {
  const OrderManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<StoreProvider>(context);
    final danhSachDonHang = store.danhSachDonHang;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(tieuDe: 'Quản lý đơn hàng', hienThiNutBack: false),
      body: Column(
        children: [
          const OrderSearchBar(),
          const OrderStatusFilter(),
          Expanded(
            child: danhSachDonHang.isEmpty
                ? const Center(
                    child: Text('Không có đơn hàng nào'),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    itemCount: danhSachDonHang.length,
                    separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.lg),
                    itemBuilder: (context, index) {
                      final donHang = danhSachDonHang[index];
                      return AdminOrderCard(
                        donHang: donHang,
                        onDetail: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AdminOrderDetailScreen(donHang: donHang),
                          ),
                        ),
                        onUpdate: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AdminOrderDetailScreen(donHang: donHang),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
