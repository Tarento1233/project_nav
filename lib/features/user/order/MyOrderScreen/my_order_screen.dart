import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/headers/custom_app_bar.dart';
import '../../../../providers/store_provider.dart';
import '../OrderDetailScreen/order_detail_screen.dart';

import 'order_card.dart';
import 'order_status_tab.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  String _selectedStatus = 'Tất cả';

  bool _matchesOrderStatus(String orderStatus, String filterValue) {
    if (filterValue == 'Tất cả') return true;
    final s = orderStatus.toUpperCase();
    if (filterValue == 'Đang xử lý') return s == 'DANG_XU_LY' || s == 'ĐANG_XỬ_LÝ';
    if (filterValue == 'Đang giao') return s == 'DANG_GIAO' || s == 'ĐANG_GIAO';
    if (filterValue == 'Hoàn thành') return s == 'HOAN_THANH' || s == 'HOÀN_THÀNH';
    if (filterValue == 'Đã hủy') return s == 'DA_HUY' || s == 'ĐÃ_HỦY';
    return false;
  }

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
              .where((o) => _matchesOrderStatus(o.trangThai, _selectedStatus))
              .toList()
              ..sort((a, b) => b.ngayTao.compareTo(a.ngayTao));

          return Column(
            children: [
              OrderStatusTab(
                selectedStatus: _selectedStatus,
                onStatusChanged: (status) {
                  setState(() {
                    _selectedStatus = status;
                  });
                },
              ),
              Expanded(
                child: danhSachDonHang.isEmpty
                    ? const Center(child: Text('Không có đơn hàng nào phù hợp'))
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
