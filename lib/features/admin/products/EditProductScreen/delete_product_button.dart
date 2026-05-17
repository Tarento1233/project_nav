// features/admin/products/delete_product_button.dart

import 'package:flutter/material.dart';

import '../../../../core/widgets/buttons/secondary_button.dart';

class DeleteProductButton extends StatelessWidget {
  const DeleteProductButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SecondaryButton(tieuDe: 'Xóa sản phẩm', onPressed: () {});
  }
}
