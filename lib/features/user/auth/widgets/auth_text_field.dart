// features/auth/widgets/auth_text_field.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';

class AuthTextField extends StatelessWidget {
  final String hintText;

  final IconData prefixIcon;

  final TextInputType? keyboardType;

  final TextEditingController? controller;

  const AuthTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.keyboardType,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,

      keyboardType: keyboardType,

      decoration: InputDecoration(
        hintText: hintText,

        prefixIcon: Icon(prefixIcon),

        filled: true,

        fillColor: AppColors.surface,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),

          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
