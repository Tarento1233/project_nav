// features/auth/widgets/onboarding_indicator.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

class OnboardingIndicator extends StatelessWidget {
  final int currentIndex;

  final int itemCount;

  const OnboardingIndicator({
    super.key,
    required this.currentIndex,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,

      children: List.generate(itemCount, (index) {
        final isSelected = currentIndex == index;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),

          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),

          width: isSelected ? 24 : 10,

          height: 10,

          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.border,

            borderRadius: BorderRadius.circular(20),
          ),
        );
      }),
    );
  }
}
