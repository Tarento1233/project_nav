import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../theme/app_spacing.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String tieuDe;

  final bool hienThiNutBack;

  final List<Widget>? actions;

  final VoidCallback? onBack;

  const CustomAppBar({
    super.key,
    required this.tieuDe,
    this.hienThiNutBack = true,
    this.actions,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,

      backgroundColor: AppColors.surface,

      elevation: 0,

      scrolledUnderElevation: 0,

      centerTitle: true,

      leading: hienThiNutBack
          ? IconButton(
              onPressed:
                  onBack ??
                  () {
                    Navigator.pop(context);
                  },

              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColors.textPrimary,
                size: 20,
              ),
            )
          : null,

      title: Text(
        tieuDe,

        style: AppTypography.tieuDeNho.copyWith(fontWeight: FontWeight.w600),
      ),

      actions: actions != null
          ? [
              Padding(
                padding: const EdgeInsets.only(right: AppSpacing.sm),

                child: Row(children: actions!),
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
