// features/user/home/screens/home_screen.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

import 'home_banner.dart';
import 'home_bottom_navigation.dart';
import 'home_header.dart';
import 'category_list.dart';
import 'featured_product_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: const SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),

          child: Column(
            children: [
              HomeHeader(),

              HomeBanner(),

              CategoryList(),

              FeaturedProductSection(),
            ],
          ),
        ),
      ),

      bottomNavigationBar: const HomeBottomNavigation(),
    );
  }
}
