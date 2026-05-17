// features/admin/products/create_product_button.dart

import 'package:flutter/material.dart';

import '../../../../core/widgets/buttons/primary_button.dart';

class CreateProductButton extends StatelessWidget {
  const CreateProductButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(tieuDe: 'Tạo sản phẩm', onPressed: () {});
  }
}
