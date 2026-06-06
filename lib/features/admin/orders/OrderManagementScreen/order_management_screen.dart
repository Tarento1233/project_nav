// features/admin/orders/OrderManagementScreen/order_management_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/mock_data.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/headers/custom_app_bar.dart';
import '../../../../providers/store_provider.dart';
import '../../../../models/user_model.dart';
import '../OrderDetailAdminScreen/admin_order_detail_screen.dart';


import 'admin_order_card.dart';
import 'order_search_bar.dart';
import 'order_status_filter.dart';

class OrderManagementScreen extends StatefulWidget {
  const OrderManagementScreen({super.key});

  @override
  State<OrderManagementScreen> createState() => _OrderManagementScreenState();
}

class _OrderManagementScreenState extends State<OrderManagementScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedStatus = 'Tất cả';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
    final store = Provider.of<StoreProvider>(context);
    
    final danhSachDonHang = store.danhSachDonHang.where((o) {
      if (_selectedStatus != 'Tất cả' && !_matchesOrderStatus(o.trangThai, _selectedStatus)) {
        return false;
      }
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        final matchId = o.id.toLowerCase().contains(q);
        final matchUser = o.nguoiDungId.toLowerCase().contains(q);
        
        final user = store.danhSachNguoiDung.firstWhere(
          (u) => u.id == o.nguoiDungId,
          orElse: () => NguoiDungModel(
            id: o.nguoiDungId,
            ten: '',
            email: '',
            soDienThoai: '',
            avatar: '',
            vaiTro: 'USER',
            ngayTao: DateTime.now(),
          ),
        );
        final matchUsername = user.ten.toLowerCase().contains(q);
        
        if (!matchId && !matchUser && !matchUsername) return false;
      }
      return true;
    }).toList()
      ..sort((a, b) => b.ngayTao.compareTo(a.ngayTao));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(tieuDe: 'Quản lý đơn hàng', hienThiNutBack: false),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
            child: OrderSearchBar(controller: _searchController),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
            child: OrderStatusFilter(
              selectedStatus: _selectedStatus,
              onStatusChanged: (status) {
                setState(() {
                  _selectedStatus = status;
                });
              },
            ),
          ),
          Expanded(
            child: danhSachDonHang.isEmpty
                ? const Center(
                    child: Text('Không tìm thấy đơn hàng nào'),
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
