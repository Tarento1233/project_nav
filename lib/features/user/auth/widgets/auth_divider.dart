// features/auth/widgets/auth_divider.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

class AuthDivider extends StatelessWidget {
  const AuthDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: AppColors.border)),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),

          child: Text('Hoặc'),
        ),

        Expanded(child: Divider(color: AppColors.border)),
      ],
    );
  }
}
