// features/admin/orders/order_search_bar.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';

class OrderSearchBar extends StatelessWidget {
  final TextEditingController? controller;

  const OrderSearchBar({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Tìm mã đơn hàng...',

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
