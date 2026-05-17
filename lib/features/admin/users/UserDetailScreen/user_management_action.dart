// features/admin/users/user_management_action.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';

import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/buttons/secondary_button.dart';

class UserManagementAction extends StatelessWidget {
  const UserManagementAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryButton(tieuDe: 'Khóa tài khoản', onPressed: () {}),

        const SizedBox(height: AppSpacing.lg),

        PrimaryButton(tieuDe: 'Đổi quyền người dùng', onPressed: () {}),

        const SizedBox(height: AppSpacing.lg),

        SecondaryButton(tieuDe: 'Xóa tài khoản', onPressed: () {}),
      ],
    );
  }
}
