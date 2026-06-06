import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class OrderStatusTab extends StatelessWidget {
  final String selectedStatus;
  final ValueChanged<String> onStatusChanged;

  const OrderStatusTab({
    super.key,
    required this.selectedStatus,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> tabs = [
      'Tất cả',
      'Đang xử lý',
      'Đang giao',
      'Hoàn thành',
      'Đã hủy',
    ];

    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final tab = tabs[index];
          final dangChon = tab == selectedStatus;

          return Center(
            child: GestureDetector(
              onTap: () => onStatusChanged(tab),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  color: dangChon ? AppColors.primary : AppColors.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.border),
                ),
                child: Text(
                  tab,
                  style: AppTypography.noiDung.copyWith(
                    color: dangChon ? Colors.white : AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
