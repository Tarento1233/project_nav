// features/user/order/order_detail_screen.dart

import 'package:flutter/material.dart';

import '../../../../models/order_model.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

import '../../../../core/widgets/headers/custom_app_bar.dart';

import 'order_timeline.dart';
import 'shipping_info_card.dart';
import 'payment_info_card.dart';
import 'order_summary_card.dart';

class OrderDetailScreen extends StatelessWidget {
  final DonHangModel donHang;

  const OrderDetailScreen({super.key, required this.donHang});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: const CustomAppBar(tieuDe: 'Chi tiết đơn hàng'),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),

        child: Column(
          children: [
            OrderTimeline(trangThai: donHang.trangThai),

            const SizedBox(height: AppSpacing.xl),

            const ShippingInfoCard(),

            const SizedBox(height: AppSpacing.xl),

            PaymentInfoCard(donHang: donHang),

            const SizedBox(height: AppSpacing.xl),

            OrderSummaryCard(donHang: donHang),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
