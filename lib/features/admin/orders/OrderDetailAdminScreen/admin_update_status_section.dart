// features/admin/orders/admin_update_status_section.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';

import '../../../../core/widgets/buttons/primary_button.dart';

class AdminUpdateStatusSection extends StatelessWidget {
  const AdminUpdateStatusSection({super.key});

  @override
  Widget build(BuildContext context) {
    final statuses = ['Đang xử lý', 'Đang giao', 'Hoàn thành', 'Đã hủy'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          'Cập nhật trạng thái',

          style: Theme.of(context).textTheme.titleMedium,
        ),

        const SizedBox(height: AppSpacing.lg),

        Wrap(
          spacing: AppSpacing.md,

          runSpacing: AppSpacing.md,

          children: List.generate(statuses.length, (index) {
            return PrimaryButton(tieuDe: statuses[index], onPressed: () {});
          }),
        ),
      ],
    );
  }
}
