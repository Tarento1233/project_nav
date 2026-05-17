// features/user/consignment/create_consignment_button.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class CreateConsignmentButton extends StatelessWidget {
  const CreateConsignmentButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.primary,

      onPressed: () {},

      child: const Icon(Icons.add, color: Colors.white),
    );
  }
}
