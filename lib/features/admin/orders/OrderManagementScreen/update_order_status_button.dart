// features/admin/orders/update_order_status_button.dart

import 'package:flutter/material.dart';

import '../../../../core/widgets/buttons/primary_button.dart';

class UpdateOrderStatusButton extends StatelessWidget {
  final VoidCallback onPressed;

  const UpdateOrderStatusButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(tieuDe: 'Cập nhật', onPressed: onPressed);
  }
}
