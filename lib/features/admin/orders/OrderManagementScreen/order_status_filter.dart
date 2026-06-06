// features/admin/orders/order_status_filter.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

class OrderStatusFilter extends StatelessWidget {
  final String selectedStatus;
  final ValueChanged<String> onStatusChanged;

  const OrderStatusFilter({
    super.key,
    required this.selectedStatus,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    final filters = [
      'Tất cả',
      'Đang xử lý',
      'Đang giao',
      'Hoàn thành',
      'Đã hủy',
    ];

    return SizedBox(
      height: 45,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final selected = filter == selectedStatus;

          return GestureDetector(
            onTap: () => onStatusChanged(filter),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: selected ? AppColors.primary : AppColors.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border),
              ),
              child: Text(
                filter,
                style: TextStyle(
                  color: selected ? Colors.white : AppColors.textPrimary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
