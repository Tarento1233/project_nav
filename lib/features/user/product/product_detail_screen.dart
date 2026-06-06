import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/product_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/headers/custom_app_bar.dart';
import '../../../../providers/store_provider.dart';
import '../cart/CartScreen/cart_screen.dart';

import 'product_image_slider.dart';
import 'product_info_section.dart';
import 'product_price_section.dart';
import 'size_selector.dart';
import 'add_to_cart_section.dart';
import 'related_product_section.dart';

class ProductDetailScreen extends StatefulWidget {
  final SanPhamModel sanPham;

  const ProductDetailScreen({super.key, required this.sanPham});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late String selectedSize;
  late List<String> availableSizes;

  @override
  void initState() {
    super.initState();
    availableSizes = widget.sanPham.kichThuoc
        .split(', ')
        .where((s) => s.isNotEmpty)
        .toList();
    selectedSize = availableSizes.isNotEmpty ? availableSizes.first : 'M';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(tieuDe: 'Chi tiết sản phẩm'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            ProductImageSlider(danhSachAnh: widget.sanPham.hinhAnh),

            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductInfoSection(sanPham: widget.sanPham),

                  const SizedBox(height: AppSpacing.xl),

                  ProductPriceSection(sanPham: widget.sanPham),

                  const SizedBox(height: AppSpacing.xl),

                  SizeSelector(
                    sizes: availableSizes,
                    selectedSize: selectedSize,
                    onSelected: (size) {
                      setState(() {
                        selectedSize = size;
                      });
                    },
                  ),

                  const SizedBox(height: AppSpacing.xl),

                  AddToCartSection(
                    sanPham: widget.sanPham,
                    onAddToCart: () {
                      final store = Provider.of<StoreProvider>(context, listen: false);
                      store.addToCart(widget.sanPham, selectedSize);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Đã thêm ${widget.sanPham.ten} (Size $selectedSize) vào giỏ hàng'),
                          duration: const Duration(seconds: 2),
                          backgroundColor: AppColors.primary,
                        ),
                      );
                    },
                    onBuyNow: () {
                      final store = Provider.of<StoreProvider>(context, listen: false);
                      store.addToCart(widget.sanPham, selectedSize);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CartScreen()),
                      );
                    },
                  ),

                  const SizedBox(height: AppSpacing.xl),

                  RelatedProductSection(sanPham: widget.sanPham),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
