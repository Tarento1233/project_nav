// features/auth/widgets/auth_header.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class AuthHeader extends StatelessWidget {
  final String title;

  final String subtitle;

  const AuthHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(title, style: AppTypography.tieuDe),

        const SizedBox(height: AppSpacing.sm),

        Text(
          subtitle,

          style: AppTypography.moTa.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
