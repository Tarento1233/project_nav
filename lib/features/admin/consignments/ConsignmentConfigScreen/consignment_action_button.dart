// features/admin/consignments/consignment_action_button.dart

import 'package:flutter/material.dart';

import '../../../../core/widgets/buttons/primary_button.dart';

class ConsignmentActionButton extends StatelessWidget {
  final String title;

  final VoidCallback onPressed;

  const ConsignmentActionButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(tieuDe: title, onPressed: onPressed);
  }
}
