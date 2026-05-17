// features/admin/orders/admin_order_detail_screen.dart

import 'package:flutter/material.dart';

import '../../../../models/order_model.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

import '../../../../core/widgets/headers/custom_app_bar.dart';

import '../../../../core/constants/mock_data.dart';

import 'admin_customer_info_card.dart';
import 'admin_order_product_item.dart';
import 'admin_payment_info_card.dart';
import 'admin_order_summary_card.dart';
import 'admin_update_status_section.dart';

class AdminOrderDetailScreen extends StatelessWidget {
  final DonHangModel donHang;

  const AdminOrderDetailScreen({super.key, required this.donHang});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: const CustomAppBar(tieuDe: 'Chi tiết đơn hàng'),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            AdminCustomerInfoCard(donHang: donHang),

            const SizedBox(height: AppSpacing.xl),

            Text('Sản phẩm', style: Theme.of(context).textTheme.titleMedium),

            const SizedBox(height: AppSpacing.lg),

            ...List.generate(2, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.lg),

                child: AdminOrderProductItem(
                  sanPham: DuLieuMau.danhSachSanPham[index],
                ),
              );
            }),

            const AdminPaymentInfoCard(),

            const SizedBox(height: AppSpacing.xl),

            AdminOrderSummaryCard(donHang: donHang),

            const SizedBox(height: AppSpacing.xl),

            const AdminUpdateStatusSection(),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
