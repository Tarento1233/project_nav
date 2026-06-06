// features/admin/users/user_management_action.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/buttons/secondary_button.dart';
import '../../../../models/user_model.dart';
import '../../../../providers/store_provider.dart';

class UserManagementAction extends StatelessWidget {
  final NguoiDungModel user;

  const UserManagementAction({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<StoreProvider>(context);
    final isBlocked = user.trangThai == 'BLOCKED';

    return Column(
      children: [
        PrimaryButton(
          tieuDe: isBlocked ? 'Mở khóa tài khoản' : 'Khóa tài khoản',
          onPressed: () async {
            await store.toggleUserBlockStatus(user.id, user.trangThai);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  isBlocked
                      ? 'Đã mở khóa tài khoản thành công!'
                      : 'Đã khóa tài khoản thành công!',
                ),
              ),
            );
          },
        ),
        const SizedBox(height: AppSpacing.lg),
        PrimaryButton(
          tieuDe: user.vaiTro == 'ADMIN' ? 'Đổi quyền thành USER' : 'Đổi quyền thành ADMIN',
          onPressed: () async {
            final newRole = user.vaiTro == 'ADMIN' ? 'USER' : 'ADMIN';
            await store.updateUserRole(user.id, newRole);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Đã đổi quyền sang $newRole thành công!'),
              ),
            );
          },
        ),
        const SizedBox(height: AppSpacing.lg),
        SecondaryButton(
          tieuDe: 'Xóa tài khoản',
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Xác nhận xóa'),
                content: Text('Bạn có chắc chắn muốn xóa tài khoản của ${user.ten} không? Hành động này không thể hoàn tác.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text('Hủy'),
                  ),
                  TextButton(
                    onPressed: () async {
                      Navigator.pop(ctx); // Đóng dialog
                      await store.deleteUser(user.id);
                      Navigator.pop(context); // Quay về màn hình quản lý
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Đã xóa tài khoản thành công!'),
                          backgroundColor: AppColors.error,
                        ),
                      );
                    },
                    child: const Text('Xóa', style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
