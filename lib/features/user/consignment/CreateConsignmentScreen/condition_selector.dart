// features/user/consignment/condition_selector.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class ConditionSelector extends StatelessWidget {
  final String selectedCondition;
  final ValueChanged<String> onConditionChanged;

  const ConditionSelector({
    super.key,
    required this.selectedCondition,
    required this.onConditionChanged,
  });

  @override
  Widget build(BuildContext context) {
    final conditions = ['Mới', 'Like New', '99%', '98%', 'Đã sử dụng'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tình trạng sản phẩm', style: AppTypography.tieuDeNho),
        const SizedBox(height: AppSpacing.md),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(conditions.length, (index) {
              final condName = conditions[index];
              final selected = condName == selectedCondition;

              return GestureDetector(
                onTap: () => onConditionChanged(condName),
                child: Container(
                  margin: const EdgeInsets.only(right: AppSpacing.md),
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.primary : AppColors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    border: Border.all(
                      color: selected ? AppColors.primary : AppColors.border,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      condName,
                      style: AppTypography.noiDung.copyWith(
                        color: selected ? Colors.white : AppColors.textPrimary,
                        fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

