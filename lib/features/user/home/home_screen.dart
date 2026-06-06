// features/user/home/home_screen.dart

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/constants/mock_data.dart';
import '../../../features/user/product/product_detail_screen.dart';
import '../../../features/user/cart/CartScreen/cart_screen.dart';
import '../notification/notification_screen.dart';

import 'home_banner.dart';
import 'home_header.dart';
import 'category_list.dart';
import 'featured_product_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'Tất cả';
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // Header với icon giỏ hàng dẫn tới CartScreen & thông báo tới NotificationScreen
              HomeHeader(
                searchController: _searchController,
                onGioHangTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CartScreen()),
                ),
                onNotificationTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const NotificationScreen()),
                ),
              ),
              const HomeBanner(),
              CategoryList(
                selectedCategory: _selectedCategory,
                onCategorySelected: (category) {
                  setState(() {
                    _selectedCategory = category;
                  });
                },
              ),
              // Featured products dẫn tới ProductDetailScreen
              FeaturedProductSection(
                selectedCategory: _selectedCategory,
                searchQuery: _searchQuery,
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
