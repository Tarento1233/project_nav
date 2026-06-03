import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/headers/custom_app_bar.dart';
import '../../../../providers/store_provider.dart';
import '../OrderDetailScreen/order_detail_screen.dart';

import 'order_card.dart';
import 'order_status_tab.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(tieuDe: 'Đơn hàng của tôi'),
      body: Consumer<StoreProvider>(
        builder: (context, store, child) {
          final currentUserId = store.currentUser?.id ?? '';
          final danhSachDonHang = store.danhSachDonHang
              .where((o) => o.nguoiDungId == currentUserId)
              .toList()
              ..sort((a, b) => b.ngayTao.compareTo(a.ngayTao));

          return Column(
            children: [
              const OrderStatusTab(),
              Expanded(
                child: danhSachDonHang.isEmpty
                    ? const Center(child: Text('Bạn chưa có đơn hàng nào'))
                    : ListView.separated(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        itemCount: danhSachDonHang.length,
                        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.lg),
                        itemBuilder: (context, index) {
                          final donHang = danhSachDonHang[index];
                          return OrderCard(
                            donHang: donHang,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => OrderDetailScreen(donHang: donHang),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
