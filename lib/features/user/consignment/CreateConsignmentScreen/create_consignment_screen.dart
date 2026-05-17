// features/user/consignment/create_consignment_screen.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

import '../../../../core/widgets/headers/custom_app_bar.dart';
import '../../../../core/widgets/buttons/primary_button.dart';

import 'upload_image_box.dart';
import 'consignment_form.dart';
import 'condition_selector.dart';
import 'consignment_term_card.dart';

class CreateConsignmentScreen extends StatelessWidget {
  const CreateConsignmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: const CustomAppBar(tieuDe: 'Tạo yêu cầu ký gửi'),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),

        child: Column(
          children: [
            const UploadImageBox(),

            const SizedBox(height: AppSpacing.xl),

            const ConsignmentForm(),

            const SizedBox(height: AppSpacing.xl),

            const ConditionSelector(),

            const SizedBox(height: AppSpacing.xl),

            const ConsignmentTermCard(),

            const SizedBox(height: AppSpacing.xl),

            PrimaryButton(tieuDe: 'Gửi yêu cầu ký gửi', onPressed: () {}),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
