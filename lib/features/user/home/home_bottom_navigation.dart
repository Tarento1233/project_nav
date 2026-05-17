// features/user/home/widgets/home_bottom_navigation.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class HomeBottomNavigation extends StatelessWidget {
  const HomeBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,

      type: BottomNavigationBarType.fixed,

      selectedItemColor: AppColors.primaryDark,

      unselectedItemColor: AppColors.textSecondary,

      backgroundColor: AppColors.surface,

      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),

          label: 'Trang chủ',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.search_rounded),

          label: 'Tìm kiếm',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag_outlined),

          label: 'Đơn hàng',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline_rounded),

          label: 'Tài khoản',
        ),
      ],
    );
  }
}
