// core/navigation/user_tab_navigation.dart
// Bottom tab navigation cho User: Home / Đơn hàng / Ký gửi / Tài khoản

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../features/user/home/home_screen.dart';
import '../../features/user/order/MyOrderScreen/my_order_screen.dart';
import '../../features/user/consignment/MyConsignmentScreen/my_consignment_screen.dart';
import '../../features/user/profile/profile_screen.dart';

class UserTabNavigation extends StatefulWidget {
  const UserTabNavigation({super.key});

  @override
  State<UserTabNavigation> createState() => _UserTabNavigationState();
}

class _UserTabNavigationState extends State<UserTabNavigation> {
  int _viTriHienTai = 0;

  final List<Widget> _danhSachTab = const [
    HomeScreen(),
    MyOrderScreen(),
    MyConsignmentScreen(),
    ProfileScreen(),
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
        onTap: (index) => setState(() => _viTriHienTai = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Đơn hàng',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2_outlined),
            label: 'Ký gửi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            label: 'Tài khoản',
          ),
        ],
      ),
    );
  }
}
