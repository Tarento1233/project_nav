// features/user/home/widgets/home_header.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

import '../../../../core/widgets/inputs/search_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),

      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text('Outlet Fashion', style: AppTypography.tieuDeLon),

                  const SizedBox(height: 4),

                  Text('Korean Luxury Style', style: AppTypography.moTa),
                ],
              ),

              Container(
                padding: const EdgeInsets.all(AppSpacing.md),

                decoration: BoxDecoration(
                  color: AppColors.surface,

                  shape: BoxShape.circle,

                  border: Border.all(color: AppColors.border),
                ),

                child: const Icon(
                  Icons.notifications_none_rounded,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.xl),

          const SearchField(),
        ],
      ),
    );
  }
}
