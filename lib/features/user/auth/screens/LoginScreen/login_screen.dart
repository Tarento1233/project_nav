// features/user/auth/screens/LoginScreen/login_screen.dart

import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/widgets/buttons/primary_button.dart';
import '../../../../../core/navigation/user_tab_navigation.dart';
import '../../widgets/auth_banner.dart';
import '../../widgets/auth_header.dart';
import '../../widgets/auth_text_field.dart';
import '../../widgets/password_text_field.dart';
import '../../widgets/social_login_button.dart';
import '../../widgets/auth_footer.dart';
import '../../widgets/auth_divider.dart';
import '../RegisterScreen/register_screen.dart';
import '../ForgotPassWordScreen/forgot_password_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../core/widgets/buttons/primary_button.dart';
import '../../../../../core/navigation/root_navigation.dart';
import '../../../../../providers/store_provider.dart';
import '../../widgets/auth_banner.dart';
import '../../widgets/auth_header.dart';
import '../../widgets/auth_text_field.dart';
import '../../widgets/password_text_field.dart';
import '../../widgets/social_login_button.dart';
import '../../widgets/auth_footer.dart';
import '../../widgets/auth_divider.dart';
import '../RegisterScreen/register_screen.dart';
import '../ForgotPassWordScreen/forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _selectedUserId = 'USER01';

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
                imageUrl: 'https://images.unsplash.com/photo-1496747611176-843222e1e57c',
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
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
                  ),
                  child: const Text('Quên mật khẩu?'),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              
              Text(
                'Tài khoản đăng nhập thử nghiệm:',
                style: AppTypography.noiDung.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.border),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedUserId,
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(
                        value: 'USER01',
                        child: Text('Khách hàng ký gửi (Nguyễn Văn A)'),
                      ),
                      DropdownMenuItem(
                        value: 'USER02',
                        child: Text('Khách hàng mua sắm (Nguyễn Văn B)'),
                      ),
                      DropdownMenuItem(
                        value: 'ADMIN01',
                        child: Text('Chủ cửa hàng (Admin)'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedUserId = value;
                        });
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              
              PrimaryButton(
                tieuDe: 'Đăng nhập',
                onPressed: () {
                  final store = Provider.of<StoreProvider>(context, listen: false);
                  store.switchUser(_selectedUserId);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const RootNavigation()),
                    (route) => false,
                  );
                },
              ),
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
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RegisterScreen()),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

