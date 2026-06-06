// features/user/order/order_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/order_model.dart';
import '../../../../providers/store_provider.dart';

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
    final store = Provider.of<StoreProvider>(context);
    final activeDonHang = store.danhSachDonHang.firstWhere(
      (o) => o.id == donHang.id,
      orElse: () => donHang,
    );

    final showCancelButton = activeDonHang.trangThai == 'DANG_GIAO' || 
                             activeDonHang.trangThai == 'CHO_XAC_NHAN' || 
                             activeDonHang.trangThai == 'DANG_XU_LY';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(tieuDe: 'Chi tiết đơn hàng'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            OrderTimeline(trangThai: activeDonHang.trangThai),
            const SizedBox(height: AppSpacing.xl),
            ShippingInfoCard(donHang: activeDonHang),
            const SizedBox(height: AppSpacing.xl),
            PaymentInfoCard(donHang: activeDonHang),
            const SizedBox(height: AppSpacing.xl),
            OrderSummaryCard(donHang: activeDonHang),
            if (showCancelButton) ...[
              const SizedBox(height: AppSpacing.xl),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Xác nhận hủy đơn'),
                      content: const Text('Bạn có chắc chắn muốn hủy đơn hàng này không?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Không'),
                        ),
                        TextButton(
                          onPressed: () {
                            store.updateOrderStatus(activeDonHang.id, 'DA_HUY');
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Đã hủy đơn hàng thành công!'),
                                backgroundColor: AppColors.success,
                              ),
                            );
                          },
                          child: const Text('Hủy đơn', style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.error.withOpacity(0.1),
                  foregroundColor: AppColors.error,
                  elevation: 0,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: const BorderSide(color: AppColors.error),
                  ),
                ),
                child: const Text(
                  'Hủy đơn hàng',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ],
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
