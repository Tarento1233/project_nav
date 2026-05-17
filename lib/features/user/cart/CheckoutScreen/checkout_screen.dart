// features/user/checkout/checkout_screen.dart

import 'package:flutter/material.dart';

import '../../../../core/constants/mock_data.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

import '../../../../core/widgets/headers/custom_app_bar.dart';

import 'address_card.dart';
import 'checkout_product_item.dart';
import 'payment_method_selector.dart';
import 'checkout_summary_section.dart';
import 'place_order_bottom_bar.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final danhSachSanPham = DuLieuMau.danhSachSanPham;

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: const CustomAppBar(tieuDe: 'Thanh toán'),

      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),

              child: Column(
                children: [
                  const AddressCard(),

                  const SizedBox(height: AppSpacing.xl),

                  ...List.generate(danhSachSanPham.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.lg),

                      child: CheckoutProductItem(
                        sanPham: danhSachSanPham[index],
                      ),
                    );
                  }),

                  const PaymentMethodSelector(),

                  const SizedBox(height: AppSpacing.xl),

                  const CheckoutSummarySection(),

                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),

          PlaceOrderBottomBar(tongTien: 6389000, onPlaceOrder: () {}),
        ],
      ),
    );
  }
}
