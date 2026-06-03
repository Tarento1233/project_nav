// features/user/profile/profile_screen.dart

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/headers/custom_app_bar.dart';
import '../order/MyOrderScreen/my_order_screen.dart';
import '../wallet/WalletScreen/wallet_screen.dart';
import '../consignment/MyConsignmentScreen/my_consignment_screen.dart';
import '../auth/screens/LoginScreen/login_screen.dart';

import 'profile_header.dart';
import 'profile_quick_action.dart';
import 'profile_menu_item.dart';
import 'logout_button.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/headers/custom_app_bar.dart';
import '../../../providers/store_provider.dart';
import '../order/MyOrderScreen/my_order_screen.dart';
import '../wallet/WalletScreen/wallet_screen.dart';
import '../consignment/MyConsignmentScreen/my_consignment_screen.dart';
import '../auth/screens/LoginScreen/login_screen.dart';

import 'profile_header.dart';
import 'profile_quick_action.dart';
import 'profile_menu_item.dart';
import 'logout_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<StoreProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(tieuDe: 'Tài khoản'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            const ProfileHeader(),
            const SizedBox(height: AppSpacing.xl),

            // Quick actions: Đơn hàng / Ví / Ký gửi
            if (!store.isAdmin) ...[
              ProfileQuickAction(
                onDonHangTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MyOrderScreen()),
                ),
                onViTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const WalletScreen()),
                ),
                onKyGuiTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MyConsignmentScreen()),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],

            ProfileMenuItem(
              icon: Icons.person_outline_rounded,
              tieuDe: 'Thông tin cá nhân',
              onTap: () {},
            ),
            if (!store.isAdmin) ...[
              ProfileMenuItem(
                icon: Icons.location_on_outlined,
                tieuDe: 'Địa chỉ giao hàng',
                onTap: () {},
              ),
              ProfileMenuItem(
                icon: Icons.receipt_long_outlined,
                tieuDe: 'Lịch sử giao dịch',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const WalletScreen()),
                ),
              ),
            ],
            ProfileMenuItem(
              icon: Icons.lock_outline_rounded,
              tieuDe: 'Đổi mật khẩu',
              onTap: () {},
            ),
            
            // Nút chuyển vai trò nhanh để kiểm thử
            ProfileMenuItem(
              icon: Icons.swap_horiz_rounded,
              tieuDe: store.isAdmin ? 'Chuyển sang giao diện Khách' : 'Chuyển sang giao diện Admin',
              onTap: () {
                store.switchUser(store.isAdmin ? 'USER01' : 'ADMIN01');
              },
            ),

            const SizedBox(height: AppSpacing.xl),

            // Đăng xuất → Login
            LogoutButton(
              onLogout: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

