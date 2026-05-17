// features/auth/screens/splash_screen.dart

import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

import '../screens/LoginScreen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    dieuHuong();
  }

  void dieuHuong() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,

        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Container(
              width: 120,

              height: 120,

              decoration: BoxDecoration(
                color: AppColors.primary,

                borderRadius: BorderRadius.circular(30),
              ),

              child: const Icon(
                Icons.shopping_bag_outlined,

                size: 60,

                color: Colors.white,
              ),
            ),

            const SizedBox(height: AppSpacing.xl),

            Text(
              'Outlet Fashion',

              style: AppTypography.tieuDe.copyWith(fontSize: 32),
            ),

            const SizedBox(height: AppSpacing.md),

            Text('Luxury Outlet & Consignment', style: AppTypography.moTa),

            const SizedBox(height: AppSpacing.xxl),

            SizedBox(
              width: 35,

              height: 35,

              child: CircularProgressIndicator(
                color: AppColors.primary,

                strokeWidth: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
