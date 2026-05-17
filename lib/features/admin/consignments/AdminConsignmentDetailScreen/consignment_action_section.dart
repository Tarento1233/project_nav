// features/admin/consignments/consignment_action_section.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';

import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/buttons/secondary_button.dart';

class ConsignmentActionSection extends StatelessWidget {
  const ConsignmentActionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryButton(tieuDe: 'Duyệt ký gửi', onPressed: () {}),

        const SizedBox(height: AppSpacing.lg),

        PrimaryButton(tieuDe: 'Đăng bán sản phẩm', onPressed: () {}),

        const SizedBox(height: AppSpacing.lg),

        SecondaryButton(tieuDe: 'Từ chối ký gửi', onPressed: () {}),
      ],
    );
  }
}
