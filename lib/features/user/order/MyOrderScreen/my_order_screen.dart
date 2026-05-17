// features/user/order/my_order_screen.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

import '../../../../core/widgets/headers/custom_app_bar.dart';

import '../../../../core/constants/mock_data.dart';

import 'order_card.dart';
import 'order_status_tab.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final danhSachDonHang = DuLieuMau.danhSachDonHang;

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: const CustomAppBar(tieuDe: 'Đơn hàng của tôi'),

      body: Column(
        children: [
          const OrderStatusTab(),

          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.lg),

              itemCount: danhSachDonHang.length,

              separatorBuilder: (_, __) =>
                  const SizedBox(height: AppSpacing.lg),

              itemBuilder: (context, index) {
                return OrderCard(donHang: danhSachDonHang[index], onTap: () {});
              },
            ),
          ),
        ],
      ),
    );
  }
}
