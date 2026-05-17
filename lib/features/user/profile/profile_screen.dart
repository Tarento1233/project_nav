// features/user/profile/profile_screen.dart

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

import '../../../core/widgets/headers/custom_app_bar.dart';

import 'profile_header.dart';
import 'profile_quick_action.dart';
import 'profile_menu_item.dart';
import 'logout_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: const CustomAppBar(tieuDe: 'Tài khoản'),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),

        child: Column(
          children: [
            const ProfileHeader(),

            const SizedBox(height: AppSpacing.xl),

            const ProfileQuickAction(),

            const SizedBox(height: AppSpacing.xl),

            ProfileMenuItem(
              icon: Icons.person_outline_rounded,

              tieuDe: 'Thông tin cá nhân',

              onTap: () {},
            ),

            ProfileMenuItem(
              icon: Icons.location_on_outlined,

              tieuDe: 'Địa chỉ giao hàng',

              onTap: () {},
            ),

            ProfileMenuItem(
              icon: Icons.receipt_long_outlined,

              tieuDe: 'Lịch sử giao dịch',

              onTap: () {},
            ),

            ProfileMenuItem(
              icon: Icons.lock_outline_rounded,

              tieuDe: 'Đổi mật khẩu',

              onTap: () {},
            ),

            const SizedBox(height: AppSpacing.xl),

            LogoutButton(onLogout: () {}),
          ],
        ),
      ),
    );
  }
}
