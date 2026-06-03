// features/user/wallet/WalletScreen/withdraw_button_section.dart

import 'package:flutter/material.dart';

import '../../../../core/widgets/buttons/primary_button.dart';

class WithdrawButtonSection extends StatelessWidget {
  final VoidCallback? onRutTien;

  const WithdrawButtonSection({super.key, this.onRutTien});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(tieuDe: 'Rút tiền', onPressed: onRutTien ?? () {});
  }
}
