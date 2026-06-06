// features/admin/products/product_search_bar.dart

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';

class ProductSearchBar extends StatelessWidget {
  final TextEditingController? controller;

  const ProductSearchBar({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Tìm sản phẩm...',

        prefixIcon: const Icon(Icons.search),

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
