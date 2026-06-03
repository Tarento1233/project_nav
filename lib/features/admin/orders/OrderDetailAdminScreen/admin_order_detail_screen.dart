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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/order_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/headers/custom_app_bar.dart';
import '../../../../providers/store_provider.dart';

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
    final store = Provider.of<StoreProvider>(context);
    
    // Tìm đơn hàng thực tế trong store để lấy trạng thái mới nhất
    final activeDonHang = store.danhSachDonHang.firstWhere(
      (o) => o.id == donHang.id,
      orElse: () => donHang,
    );

    // Lọc ra các sản phẩm thực tế trong đơn hàng này
    final chiTietDonHang = store.danhSachChiTietDonHang.where((i) => i.donHangId == donHang.id).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(tieuDe: 'Chi tiết đơn hàng'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AdminCustomerInfoCard(donHang: activeDonHang),
            const SizedBox(height: AppSpacing.xl),
            
            Text('Sản phẩm', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AppSpacing.lg),
            
            if (chiTietDonHang.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text('Không có sản phẩm nào trong đơn hàng này'),
              )
            else
              ...chiTietDonHang.map((item) {
                final product = store.danhSachSanPham.firstWhere(
                  (p) => p.id == item.sanPhamId,
                  orElse: () => store.danhSachSanPham.first,
                );
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                  child: AdminOrderProductItem(
                    sanPham: product,
                  ),
                );
              }).toList(),

            const AdminPaymentInfoCard(),
            const SizedBox(height: AppSpacing.xl),
            AdminOrderSummaryCard(donHang: activeDonHang),
            const SizedBox(height: AppSpacing.xl),
            AdminUpdateStatusSection(donHang: activeDonHang),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

