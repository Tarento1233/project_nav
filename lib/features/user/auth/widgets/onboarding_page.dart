// features/auth/widgets/onboarding_page.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class OnboardingPage extends StatelessWidget {
  final String imageUrl;

  final String title;

  final String description;

  const OnboardingPage({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Expanded(
            flex: 5,

            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),

              child: Image.network(
                imageUrl,

                width: double.infinity,

                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.xxl),

          Text(title, textAlign: TextAlign.center, style: AppTypography.tieuDe),

          const SizedBox(height: AppSpacing.lg),

          Text(
            description,

            textAlign: TextAlign.center,

            style: AppTypography.moTa,
          ),

          const Spacer(),
        ],
      ),
    );
  }
}
