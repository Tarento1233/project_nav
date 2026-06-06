// features/user/profile/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/headers/custom_app_bar.dart';
import '../../../providers/store_provider.dart';
import '../../../models/address_model.dart';
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

  void _showEditProfileDialog(BuildContext context, StoreProvider store) {
    final user = store.currentUser;
    if (user == null) return;
    final nameController = TextEditingController(text: user.ten);
    final phoneController = TextEditingController(text: user.soDienThoai);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cập nhật thông tin cá nhân'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Họ và tên'),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Số điện thoại'),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              store.updateUserProfile(
                nameController.text.trim(),
                phoneController.text.trim(),
              );
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cập nhật thông tin cá nhân thành công!'), backgroundColor: AppColors.success),
              );
            },
            child: const Text('Lưu'),
          ),
        ],
      ),
    );
  }

  void _showEditAddressDialog(BuildContext context, StoreProvider store) {
    final diaChi = store.diaChiMacDinh;
    final tenController = TextEditingController(text: diaChi.tenNguoiNhan);
    final phoneController = TextEditingController(text: diaChi.soDienThoai);
    final detailController = TextEditingController(text: diaChi.diaChiChiTiet);
    final phuongController = TextEditingController(text: diaChi.phuongXa);
    final quanController = TextEditingController(text: diaChi.quanHuyen);
    final tinhController = TextEditingController(text: diaChi.tinhThanh);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cập nhật địa chỉ giao hàng'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: tenController,
                decoration: const InputDecoration(labelText: 'Tên người nhận'),
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Số điện thoại'),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: detailController,
                decoration: const InputDecoration(labelText: 'Địa chỉ chi tiết'),
              ),
              TextField(
                controller: phuongController,
                decoration: const InputDecoration(labelText: 'Phường/Xã'),
              ),
              TextField(
                controller: quanController,
                decoration: const InputDecoration(labelText: 'Quận/Huyện'),
              ),
              TextField(
                controller: tinhController,
                decoration: const InputDecoration(labelText: 'Tỉnh/Thành phố'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              final updated = DiaChiModel(
                id: diaChi.id,
                nguoiDungId: diaChi.nguoiDungId,
                tenNguoiNhan: tenController.text.trim(),
                soDienThoai: phoneController.text.trim(),
                tinhThanh: tinhController.text.trim(),
                quanHuyen: quanController.text.trim(),
                phuongXa: phuongController.text.trim(),
                diaChiChiTiet: detailController.text.trim(),
                macDinh: diaChi.macDinh,
              );
              store.updateAddress(updated);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cập nhật địa chỉ giao hàng thành công!'), backgroundColor: AppColors.success),
              );
            },
            child: const Text('Lưu'),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    final oldPassController = TextEditingController();
    final newPassController = TextEditingController();
    final store = Provider.of<StoreProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Đổi mật khẩu'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: oldPassController,
              decoration: const InputDecoration(labelText: 'Mật khẩu cũ'),
              obscureText: true,
            ),
            TextField(
              controller: newPassController,
              decoration: const InputDecoration(labelText: 'Mật khẩu mới'),
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () async {
              final oldPass = oldPassController.text.trim();
              final newPass = newPassController.text.trim();

              if (oldPass.isEmpty || newPass.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Vui lòng nhập đầy đủ mật khẩu cũ và mới!'), backgroundColor: AppColors.error),
                );
                return;
              }

              if (newPass.length < 6) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Mật khẩu mới phải từ 6 ký tự trở lên!'), backgroundColor: AppColors.error),
                );
                return;
              }

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Đang xử lý đổi mật khẩu...'),
                  duration: Duration(seconds: 1),
                ),
              );

              final error = await store.changePassword(oldPass, newPass);

              if (context.mounted) {
                if (error == null) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Đổi mật khẩu thành công!'), backgroundColor: AppColors.success),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(error), backgroundColor: AppColors.error),
                  );
                }
              }
            },
            child: const Text('Đổi mật khẩu'),
          ),
        ],
      ),
    );
  }

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
              onTap: () => _showEditProfileDialog(context, store),
            ),
            if (!store.isAdmin) ...[
              ProfileMenuItem(
                icon: Icons.location_on_outlined,
                tieuDe: 'Địa chỉ giao hàng',
                onTap: () => _showEditAddressDialog(context, store),
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
              onTap: () => _showChangePasswordDialog(context),
            ),
            
            const SizedBox(height: AppSpacing.xl),

            // Đăng xuất → Login
            LogoutButton(
              onLogout: () async {
                await store.logout();
                if (context.mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
