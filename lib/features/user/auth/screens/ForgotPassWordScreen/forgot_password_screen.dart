// features/auth/screens/forgot_password_screen.dart

import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';

import '../../../../../core/widgets/buttons/primary_button.dart';

import '../../widgets/auth_banner.dart';
import '../../widgets/auth_footer.dart';
import '../../widgets/auth_header.dart';
import '../../widgets/auth_text_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

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
                    'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f',
              ),

              const SizedBox(height: AppSpacing.xl),

              const AuthHeader(
                title: 'Forgot Password',

                subtitle: 'Nhập email để nhận liên kết khôi phục mật khẩu',
              ),

              const SizedBox(height: AppSpacing.xl),

              const AuthTextField(
                hintText: 'Email',

                prefixIcon: Icons.email_outlined,

                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: AppSpacing.xxl),

              PrimaryButton(tieuDe: 'Gửi email xác nhận', onPressed: () {}),

              const SizedBox(height: AppSpacing.xl),

              AuthFooter(
                text: 'Đã nhớ mật khẩu? ',

                actionText: 'Đăng nhập',

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
