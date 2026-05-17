// features/admin/consignments/consignment_filter_section.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

class ConsignmentFilterSection extends StatelessWidget {
  const ConsignmentFilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final filters = ['Tất cả', 'Chờ duyệt', 'Đã duyệt', 'Đang bán', 'Từ chối'];

    return SizedBox(
      height: 45,

      child: ListView.separated(
        scrollDirection: Axis.horizontal,

        itemCount: filters.length,

        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),

        itemBuilder: (context, index) {
          final selected = index == 0;

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),

            decoration: BoxDecoration(
              color: selected ? AppColors.primary : AppColors.surface,

              borderRadius: BorderRadius.circular(14),

              border: Border.all(color: AppColors.border),
            ),

            child: Text(
              filters[index],

              style: TextStyle(
                color: selected ? Colors.white : AppColors.textPrimary,
              ),
            ),
          );
        },
      ),
    );
  }
}
