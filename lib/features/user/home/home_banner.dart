// features/user/home/widgets/home_banner.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),

      child: Container(
        width: double.infinity,

        height: 180,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),

          gradient: const LinearGradient(
            colors: [AppColors.primary, AppColors.primaryDark],
          ),
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Text(
                'NEW OUTLET\nCOLLECTION',

                style: AppTypography.tieuDeLon.copyWith(
                  color: Colors.white,

                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              Text(
                'Giảm đến 50% cho sản phẩm thời trang Hàn Quốc',

                style: AppTypography.noiDung.copyWith(color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
