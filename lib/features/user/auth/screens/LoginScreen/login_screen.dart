// features/auth/screens/login_screen.dart

import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';

import '../../../../../core/widgets/buttons/primary_button.dart';

import '../../widgets/auth_banner.dart';
import '../../widgets/auth_header.dart';
import '../../widgets/auth_text_field.dart';
import '../../widgets/password_text_field.dart';
import '../../widgets/social_login_button.dart';
import '../../widgets/auth_footer.dart';
import '../../widgets/auth_divider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                imageUrl:
                    'https://images.unsplash.com/photo-1496747611176-843222e1e57c',
              ),

              const SizedBox(height: AppSpacing.xl),

              const AuthHeader(
                title: 'Welcome Back',

                subtitle: 'Đăng nhập để tiếp tục mua sắm',
              ),

              const SizedBox(height: AppSpacing.xl),

              const AuthTextField(
                hintText: 'Email',

                prefixIcon: Icons.email_outlined,

                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: AppSpacing.lg),

              const PasswordTextField(),

              const SizedBox(height: AppSpacing.md),

              Align(
                alignment: Alignment.centerRight,

                child: TextButton(
                  onPressed: () {},

                  child: const Text('Quên mật khẩu?'),
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              PrimaryButton(tieuDe: 'Đăng nhập', onPressed: () {}),

              const SizedBox(height: AppSpacing.xl),

              const AuthDivider(),

              const SizedBox(height: AppSpacing.xl),

              SocialLoginButton(
                title: 'Tiếp tục với Google',

                imagePath: 'assets/icons/google.png',

                onPressed: () {},
              ),

              const SizedBox(height: AppSpacing.lg),

              SocialLoginButton(
                title: 'Tiếp tục với Facebook',

                imagePath: 'assets/icons/facebook.png',

                onPressed: () {},
              ),

              const SizedBox(height: AppSpacing.xl),

              AuthFooter(
                text: 'Chưa có tài khoản? ',

                actionText: 'Đăng ký',

                onTap: () {},
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
