// features/auth/screens/onboarding_screen.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

import '../../../../core/widgets/buttons/primary_button.dart';

import '../widgets/onboarding_page.dart';
import '../widgets/onboarding_indicator.dart';

import '../screens/LoginScreen/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController pageController = PageController();

  int currentIndex = 0;

  final List<Map<String, String>> onboardingData = [
    {
      'image': 'https://images.unsplash.com/photo-1496747611176-843222e1e57c',

      'title': 'Luxury Outlet Fashion',

      'description': 'Khám phá thời trang outlet cao cấp với mức giá tốt nhất.',
    },

    {
      'image': 'https://images.unsplash.com/photo-1529139574466-a303027c1d8b',

      'title': 'Consignment Marketplace',

      'description': 'Ký gửi và mua bán các sản phẩm thời trang chính hãng.',
    },

    {
      'image': 'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f',

      'title': 'Fast & Secure Shopping',

      'description': 'Trải nghiệm mua sắm hiện đại, an toàn và tiện lợi.',
    },
  ];

  void nextPage() {
    if (currentIndex < onboardingData.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),

        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,

        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,

              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),

                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,

                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  },

                  child: const Text('Skip'),
                ),
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: pageController,

                itemCount: onboardingData.length,

                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },

                itemBuilder: (context, index) {
                  final item = onboardingData[index];

                  return OnboardingPage(
                    imageUrl: item['image']!,

                    title: item['title']!,

                    description: item['description']!,
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),

              child: Column(
                children: [
                  OnboardingIndicator(
                    currentIndex: currentIndex,

                    itemCount: onboardingData.length,
                  ),

                  const SizedBox(height: AppSpacing.xl),

                  PrimaryButton(
                    tieuDe: currentIndex == onboardingData.length - 1
                        ? 'Bắt đầu'
                        : 'Tiếp theo',

                    onPressed: nextPage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
