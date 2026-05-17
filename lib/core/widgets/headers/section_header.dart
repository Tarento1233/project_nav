import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';

class SectionHeader extends StatelessWidget {
  final String tieuDe;

  final String? nutText;

  final VoidCallback? onPressed;

  const SectionHeader({
    super.key,
    required this.tieuDe,
    this.nutText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Expanded(
            child: Text(
              tieuDe,

              maxLines: 1,

              overflow: TextOverflow.ellipsis,

              style: AppTypography.tieuDe.copyWith(fontWeight: FontWeight.w600),
            ),
          ),

          if (nutText != null && onPressed != null)
            GestureDetector(
              onTap: onPressed,

              child: Padding(
                padding: const EdgeInsets.only(left: AppSpacing.md),

                child: Text(
                  nutText!,

                  style: AppTypography.noiDung.copyWith(
                    color: AppColors.primaryDark,

                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
