import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import 'custom_text_field.dart';

class SearchField extends StatelessWidget {
  final TextEditingController? controller;

  const SearchField({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      hintText: 'Tìm kiếm sản phẩm',
      prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
    );
  }
}
