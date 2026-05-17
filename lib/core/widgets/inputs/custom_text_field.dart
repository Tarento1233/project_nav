import 'package:flutter/material.dart';

import '../../theme/global_styles.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;

  final String hintText;

  final bool obscureText;

  final TextInputType keyboardType;

  final Widget? prefixIcon;

  const CustomTextField({
    super.key,
    this.controller,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: GlobalStyles.inputDecoration(
        hintText: hintText,
      ).copyWith(prefixIcon: prefixIcon),
    );
  }
}
