// features/user/profile/logout_button.dart

import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';

import '../../../core/widgets/buttons/secondary_button.dart';

class LogoutButton extends StatelessWidget {
  final VoidCallback onLogout;

  const LogoutButton({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xl),

      child: SecondaryButton(tieuDe: 'Đăng xuất', onPressed: onLogout),
    );
  }
}
