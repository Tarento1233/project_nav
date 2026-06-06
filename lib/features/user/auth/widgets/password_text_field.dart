// features/auth/widgets/password_text_field.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;

  const PasswordTextField({
    super.key,
    this.controller,
    this.hintText = 'Mật khẩu',
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,

      obscureText: isHidden,

      decoration: InputDecoration(
        hintText: widget.hintText,

        prefixIcon: const Icon(Icons.lock),

        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              isHidden = !isHidden;
            });
          },

          icon: Icon(isHidden ? Icons.visibility_off : Icons.visibility),
        ),

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
