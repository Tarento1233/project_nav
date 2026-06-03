// features/user/home/home_screen.dart

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/constants/mock_data.dart';
import '../../../features/user/product/product_detail_screen.dart';
import '../../../features/user/cart/CartScreen/cart_screen.dart';

import 'home_banner.dart';
import 'home_header.dart';
import 'category_list.dart';
import 'featured_product_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // Header với icon giỏ hàng dẫn tới CartScreen
              HomeHeader(
                onGioHangTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CartScreen()),
                ),
              ),
              const HomeBanner(),
              const CategoryList(),
              // Featured products dẫn tới ProductDetailScreen
              FeaturedProductSection(
                onSanPhamTap: (sanPham) => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailScreen(sanPham: sanPham),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
