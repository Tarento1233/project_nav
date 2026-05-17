// features/user/order/order_timeline.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class OrderTimeline extends StatelessWidget {
  final String trangThai;

  const OrderTimeline({super.key, required this.trangThai});

  @override
  Widget build(BuildContext context) {
    final List<String> steps = [
      'Đặt hàng',

      'Xác nhận',

      'Đang giao',

      'Hoàn thành',
    ];

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),

      decoration: BoxDecoration(
        color: AppColors.surface,

        borderRadius: BorderRadius.circular(AppRadius.lg),

        boxShadow: AppShadows.cardShadow,
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: List.generate(steps.length, (index) {
          final hoanThanh = index <= 2;

          return Column(
            children: [
              Container(
                width: 40,

                height: 40,

                decoration: BoxDecoration(
                  color: hoanThanh ? AppColors.primary : AppColors.border,

                  shape: BoxShape.circle,
                ),

                child: Icon(
                  Icons.check,

                  color: hoanThanh ? Colors.white : AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: 8),

              Text(steps[index], style: AppTypography.moTa),
            ],
          );
        }),
      ),
    );
  }
}
