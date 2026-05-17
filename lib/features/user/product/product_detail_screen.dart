// features/user/product/screens/product_detail_screen.dart

import 'package:flutter/material.dart';

import '../../../../models/product_model.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

import '../../../../core/widgets/headers/custom_app_bar.dart';

import 'product_image_slider.dart';
import 'product_info_section.dart';
import 'product_price_section.dart';
import 'size_selector.dart';
import 'add_to_cart_section.dart';
import 'related_product_section.dart';

class ProductDetailScreen extends StatelessWidget {
  final SanPhamModel sanPham;

  const ProductDetailScreen({super.key, required this.sanPham});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: const CustomAppBar(tieuDe: 'Chi tiết sản phẩm'),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),

        child: Column(
          children: [
            ProductImageSlider(danhSachAnh: sanPham.hinhAnh),

            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  ProductInfoSection(sanPham: sanPham),

                  const SizedBox(height: AppSpacing.xl),

                  ProductPriceSection(sanPham: sanPham),

                  const SizedBox(height: AppSpacing.xl),

                  const SizeSelector(),

                  const SizedBox(height: AppSpacing.xl),

                  AddToCartSection(sanPham: sanPham),

                  const SizedBox(height: AppSpacing.xl),

                  RelatedProductSection(sanPham: sanPham),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
