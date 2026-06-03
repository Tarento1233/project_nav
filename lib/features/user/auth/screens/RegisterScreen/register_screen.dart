// features/user/auth/screens/RegisterScreen/register_screen.dart

import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/widgets/buttons/primary_button.dart';
import '../../../../../core/navigation/user_tab_navigation.dart';
import '../../widgets/auth_banner.dart';
import '../../widgets/auth_divider.dart';
import '../../widgets/auth_footer.dart';
import '../../widgets/auth_header.dart';
import '../../widgets/auth_text_field.dart';
import '../../widgets/password_text_field.dart';
import '../../widgets/social_login_button.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AuthBanner(
                imageUrl: 'https://images.unsplash.com/photo-1529139574466-a303027c1d8b',
              ),
              const SizedBox(height: AppSpacing.xl),
              const AuthHeader(
                title: 'Create Account',
                subtitle: 'Tạo tài khoản mới để bắt đầu',
              ),
              const SizedBox(height: AppSpacing.xl),
              const AuthTextField(hintText: 'Họ và tên', prefixIcon: Icons.person_outline),
              const SizedBox(height: AppSpacing.lg),
              const AuthTextField(
                hintText: 'Email',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: AppSpacing.lg),
              const AuthTextField(
                hintText: 'Số điện thoại',
                prefixIcon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: AppSpacing.lg),
              const PasswordTextField(),
              const SizedBox(height: AppSpacing.lg),
              const PasswordTextField(),
              const SizedBox(height: AppSpacing.xl),
              // Tạo tài khoản → UserTabNavigation
              PrimaryButton(
                tieuDe: 'Tạo tài khoản',
                onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const UserTabNavigation()),
                  (route) => false,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              const AuthDivider(),
              const SizedBox(height: AppSpacing.xl),
              SocialLoginButton(
                title: 'Đăng ký với Google',
                imagePath: 'assets/icons/google.png',
                onPressed: () {},
              ),
              const SizedBox(height: AppSpacing.lg),
              SocialLoginButton(
                title: 'Đăng ký với Facebook',
                imagePath: 'assets/icons/facebook.png',
                onPressed: () {},
              ),
              const SizedBox(height: AppSpacing.xl),
              // Footer → back to Login
              AuthFooter(
                text: 'Đã có tài khoản? ',
                actionText: 'Đăng nhập',
                onTap: () => Navigator.pop(context),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
