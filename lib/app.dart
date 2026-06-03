// app.dart
// Entry point: Splash → Login → UserTabNavigation / AdminNavigation

import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/user/auth/screens/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Outlet Fashion',
      theme: AppTheme.lightTheme,
      // Entry point: SplashScreen → OnboardingScreen → LoginScreen → UserTabNavigation
      home: const SplashScreen(),
    );
  }
}
