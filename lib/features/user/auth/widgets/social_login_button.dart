// features/auth/widgets/social_login_button.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';

class SocialLoginButton extends StatelessWidget {
  final String title;

  final String imagePath;

  final VoidCallback onPressed;

  const SocialLoginButton({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,

      child: Container(
        width: double.infinity,

        padding: const EdgeInsets.symmetric(vertical: 16),

        decoration: BoxDecoration(
          color: AppColors.surface,

          borderRadius: BorderRadius.circular(AppRadius.lg),

          border: Border.all(color: AppColors.border),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, width: 24, height: 24),

            const SizedBox(width: AppSpacing.md),

            Flexible(child: Text(title, overflow: TextOverflow.ellipsis)),
          ],
        ),
      ),
    );
  }
}
