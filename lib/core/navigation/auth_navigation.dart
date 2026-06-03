// core/navigation/auth_navigation.dart
// Splash → Onboarding → Login / Register / ForgotPassword

import 'package:flutter/material.dart';

import '../../features/user/auth/screens/splash_screen.dart';
import '../../features/user/auth/screens/onboarding_screen.dart';
import '../../features/user/auth/screens/LoginScreen/login_screen.dart';
import '../../features/user/auth/screens/RegisterScreen/register_screen.dart';
import '../../features/user/auth/screens/ForgotPassWordScreen/forgot_password_screen.dart';

class AuthNavigation {
  // Chuyển tới Splash (entry point đầu tiên)
  static void toiSplash(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const SplashScreen()),
      (route) => false,
    );
  }

  // Chuyển tới Onboarding
  static void toiOnboarding(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const OnboardingScreen()),
    );
  }

  // Chuyển tới Login
  static void toiDangNhap(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  // Chuyển tới Register
  static void toiDangKy(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RegisterScreen()),
    );
  }

  // Chuyển tới Forgot Password
  static void toiQuenMatKhau(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
    );
  }
}
