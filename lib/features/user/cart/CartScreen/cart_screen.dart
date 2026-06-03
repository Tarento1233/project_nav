import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/headers/custom_app_bar.dart';
import '../../../../providers/store_provider.dart';
import '../../cart/CheckoutScreen/checkout_screen.dart';

import 'cart_item_card.dart';
import 'cart_summary_section.dart';
import 'checkout_bottom_bar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(tieuDe: 'Giỏ hàng'),
      body: Consumer<StoreProvider>(
        builder: (context, store, child) {
          final danhSachGioHang = store.danhSachGioHangCaNhan;

          if (danhSachGioHang.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 64,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(height: AppSpacing.md),
                  Text(
                    'Giỏ hàng của bạn đang trống',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  itemCount: danhSachGioHang.length,
                  separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.lg),
                  itemBuilder: (context, index) {
                    return CartItemCard(cartItem: danhSachGioHang[index]);
                  },
                ),
              ),
              const CartSummarySection(),
              CheckoutBottomBar(
                tongTien: store.cartTotal,
                onCheckout: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CheckoutScreen()),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
