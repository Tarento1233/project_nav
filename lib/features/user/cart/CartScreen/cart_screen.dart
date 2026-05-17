// features/user/cart/cart_screen.dart

import 'package:flutter/material.dart';

import '../../../../core/constants/mock_data.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

import '../../../../core/widgets/headers/custom_app_bar.dart';
// ignore: unused_import
import '../../../../core/widgets/buttons/primary_button.dart';

import 'cart_item_card.dart';
import 'cart_summary_section.dart';
import 'checkout_bottom_bar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final danhSachGioHang = DuLieuMau.danhSachSanPham;

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: const CustomAppBar(tieuDe: 'Giỏ hàng'),

      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.lg),

              itemCount: danhSachGioHang.length,

              separatorBuilder: (_, __) =>
                  const SizedBox(height: AppSpacing.lg),

              itemBuilder: (context, index) {
                return CartItemCard(sanPham: danhSachGioHang[index]);
              },
            ),
          ),

          const CartSummarySection(),

          CheckoutBottomBar(tongTien: 6890000, onCheckout: () {}),
        ],
      ),
    );
  }
}
