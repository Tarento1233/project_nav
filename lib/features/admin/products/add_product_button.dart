// features/admin/products/add_product_button.dart

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class AddProductButton extends StatelessWidget {
  const AddProductButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.primary,

      onPressed: () {},

      child: const Icon(Icons.add, color: Colors.white),
    );
  }
}
