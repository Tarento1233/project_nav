// features/user/product/widgets/size_selector.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class SizeSelector extends StatelessWidget {
  const SizeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> sizes = ['S', 'M', 'L', 'XL'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text('Kích thước', style: AppTypography.tieuDeNho),

        const SizedBox(height: AppSpacing.lg),

        Row(
          children: sizes.map((size) {
            final dangChon = size == 'M';

            return Padding(
              padding: const EdgeInsets.only(right: 12),

              child: Container(
                width: 50,

                height: 50,

                alignment: Alignment.center,

                decoration: BoxDecoration(
                  color: dangChon ? AppColors.primary : AppColors.surface,

                  borderRadius: BorderRadius.circular(14),

                  border: Border.all(color: AppColors.border),
                ),

                child: Text(
                  size,

                  style: AppTypography.noiDung.copyWith(
                    color: dangChon ? Colors.white : AppColors.textPrimary,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
