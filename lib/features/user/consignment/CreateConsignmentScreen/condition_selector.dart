// features/user/consignment/condition_selector.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class ConditionSelector extends StatelessWidget {
  const ConditionSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final conditions = ['Mới', 'Like New', 'Đã qua sử dụng'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text('Tình trạng sản phẩm', style: AppTypography.tieuDeNho),

        const SizedBox(height: AppSpacing.md),

        Row(
          children: List.generate(conditions.length, (index) {
            final selected = index == 0;

            return Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  right: index != conditions.length - 1 ? AppSpacing.md : 0,
                ),

                padding: const EdgeInsets.symmetric(vertical: 14),

                decoration: BoxDecoration(
                  color: selected ? AppColors.primary : AppColors.surface,

                  borderRadius: BorderRadius.circular(AppRadius.lg),

                  border: Border.all(color: AppColors.border),
                ),

                child: Center(
                  child: Text(
                    conditions[index],

                    style: AppTypography.noiDung.copyWith(
                      color: selected ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
