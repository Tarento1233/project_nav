// features/admin/users/user_management_screen.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

import '../../../../core/widgets/headers/custom_app_bar.dart';

import 'admin_user_card.dart';
import 'user_filter_section.dart';
import 'user_search_bar.dart';

class UserManagementScreen extends StatelessWidget {
  const UserManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: const CustomAppBar(tieuDe: 'Quản lý người dùng'),

      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(AppSpacing.lg),

            child: Column(
              children: [
                UserSearchBar(),

                SizedBox(height: AppSpacing.lg),

                UserFilterSection(),
              ],
            ),
          ),

          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),

              itemCount: 6,

              separatorBuilder: (_, __) =>
                  const SizedBox(height: AppSpacing.lg),

              itemBuilder: (context, index) {
                return AdminUserCard(
                  tenNguoiDung: 'Nguyễn Văn A',

                  email: 'nguyenvana@gmail.com',

                  role: 'USER',

                  trangThai: index == 2 ? 'BLOCKED' : 'ACTIVE',

                  onDetail: () {},

                  onAction: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
