import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';
import 'app_shadows.dart';

class GlobalStyles {
  static BoxDecoration cardDecoration = BoxDecoration(
    color: AppColors.surface,

    borderRadius: BorderRadius.circular(AppRadius.md),

    boxShadow: AppShadows.cardShadow,
  );

  static InputDecoration inputDecoration({required String hintText}) {
    return InputDecoration(
      hintText: hintText,

      filled: true,

      fillColor: AppColors.surface,

      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),

        borderSide: const BorderSide(color: AppColors.border),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),

        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
    );
  }
}
