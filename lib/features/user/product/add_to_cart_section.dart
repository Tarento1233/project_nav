// features/user/product/widgets/add_to_cart_section.dart

import 'package:flutter/material.dart';

import '../../../../models/product_model.dart';

import '../../../../core/theme/app_spacing.dart';

import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/buttons/secondary_button.dart';

class AddToCartSection extends StatelessWidget {
  final SanPhamModel sanPham;

  const AddToCartSection({super.key, required this.sanPham});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SecondaryButton(tieuDe: 'Thêm giỏ hàng', onPressed: () {}),
        ),

        const SizedBox(width: AppSpacing.md),

        Expanded(
          child: PrimaryButton(tieuDe: 'Mua ngay', onPressed: () {}),
        ),
      ],
    );
  }
}
