// features/user/product/widgets/add_to_cart_section.dart

import 'package:flutter/material.dart';

import '../../../../models/product_model.dart';

import '../../../../core/theme/app_spacing.dart';

import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/buttons/secondary_button.dart';

class AddToCartSection extends StatelessWidget {
  final SanPhamModel sanPham;
  final VoidCallback onAddToCart;
  final VoidCallback onBuyNow;

  const AddToCartSection({
    super.key,
    required this.sanPham,
    required this.onAddToCart,
    required this.onBuyNow,
  });

  @override
  Widget build(BuildContext context) {
    if (sanPham.tonKho <= 0 || sanPham.trangThai == 'DA_BAN') {
      return const PrimaryButton(
        tieuDe: 'Hết hàng',
        onPressed: null,
      );
    }

    return Row(
      children: [
        Expanded(
          child: SecondaryButton(
            tieuDe: 'Thêm giỏ hàng',
            onPressed: onAddToCart,
          ),
        ),

        const SizedBox(width: AppSpacing.md),

        Expanded(
          child: PrimaryButton(
            tieuDe: 'Mua ngay',
            onPressed: onBuyNow,
          ),
        ),
      ],
    );
  }
}
