// features/admin/users/user_action_button.dart

import 'package:flutter/material.dart';

import '../../../../core/widgets/buttons/primary_button.dart';

class UserActionButton extends StatelessWidget {
  final String title;

  final VoidCallback onPressed;

  const UserActionButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(tieuDe: title, onPressed: onPressed);
  }
}
