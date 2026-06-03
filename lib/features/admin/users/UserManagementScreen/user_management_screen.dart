// features/admin/users/UserManagementScreen/user_management_screen.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/headers/custom_app_bar.dart';
import '../UserDetailScreen/user_detail_screen.dart';

import 'admin_user_card.dart';
import 'user_search_bar.dart';
import 'user_filter_section.dart';

class UserManagementScreen extends StatelessWidget {
  const UserManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(tieuDe: 'Quản lý người dùng', hienThiNutBack: false),
      body: Column(
        children: [
          const UserSearchBar(),
          const UserFilterSection(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.lg),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                  child: AdminUserCard(
                    tenNguoiDung: 'Nguyễn Văn A',
                    email: 'user${index + 1}@gmail.com',
                    role: index % 3 == 0 ? 'ADMIN' : 'USER',
                    trangThai: index % 4 == 0 ? 'BLOCKED' : 'ACTIVE',
                    onDetail: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const UserDetailScreen()),
                    ),
                    onAction: () {},
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
