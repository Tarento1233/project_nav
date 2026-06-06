// core/navigation/admin_navigation.dart
// Bottom tab navigation cho Admin: Dashboard / Sản phẩm / Đơn hàng / Ký gửi / Báo cáo

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../features/admin/dashboard/DashboardScreen/dashboard_screen.dart';
import '../../features/admin/products/product_management_screen.dart';
import '../../features/admin/orders/OrderManagementScreen/order_management_screen.dart';
import '../../features/admin/consignments/ConsignmentConfigScreen/consignment_management_screen.dart';
import '../../features/admin/reports/report_screen.dart';

class AdminNavigation extends StatefulWidget {
  const AdminNavigation({super.key});

  @override
  State<AdminNavigation> createState() => AdminNavigationState();
}

class AdminNavigationState extends State<AdminNavigation> {
  int _viTriHienTai = 0;

  void setTab(int index) {
    setState(() {
      _viTriHienTai = index;
    });
  }

  final List<Widget> _danhSachTab = const [
    DashboardScreen(),
    ProductManagementScreen(),
    OrderManagementScreen(),
    ConsignmentManagementScreen(),
    ReportScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _viTriHienTai,
        children: _danhSachTab,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _viTriHienTai,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryDark,
        unselectedItemColor: AppColors.textSecondary,
        backgroundColor: AppColors.surface,
        onTap: (index) => setTab(index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_outlined),
            label: 'Sản phẩm',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: 'Đơn hàng',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sell_outlined),
            label: 'Ký gửi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_rounded),
            label: 'Báo cáo',
          ),
        ],
      ),
    );
  }
}
