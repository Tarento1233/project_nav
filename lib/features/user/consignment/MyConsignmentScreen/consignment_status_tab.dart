// features/user/consignment/consignment_status_tab.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class ConsignmentStatusTab extends StatelessWidget {
  const ConsignmentStatusTab({super.key});

  @override
  Widget build(BuildContext context) {
    final tabs = ['Tất cả', 'Chờ duyệt', 'Đang bán', 'Đã bán', 'Từ chối'];

    return Container(
      height: 60,

      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),

      child: ListView.separated(
        scrollDirection: Axis.horizontal,

        itemCount: tabs.length,

        separatorBuilder: (_, __) => const SizedBox(width: 12),

        itemBuilder: (context, index) {
          final dangChon = index == 0;

          return Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),

              decoration: BoxDecoration(
                color: dangChon ? AppColors.primary : AppColors.surface,

                borderRadius: BorderRadius.circular(14),

                border: Border.all(color: AppColors.border),
              ),

              child: Text(
                tabs[index],

                style: AppTypography.noiDung.copyWith(
                  color: dangChon ? Colors.white : AppColors.textPrimary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
