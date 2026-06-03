// features/user/cart/quantity_selector.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 6,
      ),

      decoration: BoxDecoration(
        color: AppColors.background,

        borderRadius: BorderRadius.circular(AppRadius.md),

        border: Border.all(color: AppColors.border),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,

        children: [
          GestureDetector(
            onTap: onDecrement,
            child: const Icon(Icons.remove, size: 18),
          ),

          const SizedBox(width: AppSpacing.md),

          Text('$quantity', style: AppTypography.noiDung),

          const SizedBox(width: AppSpacing.md),

          GestureDetector(
            onTap: onIncrement,
            child: const Icon(Icons.add, size: 18),
          ),
        ],
      ),
    );
  }
}
