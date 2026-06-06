// features/user/auth/screens/LoginScreen/login_screen.dart

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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _dangNhap() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng điền đầy đủ Email và Mật khẩu!'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final store = Provider.of<StoreProvider>(context, listen: false);
    final errorMsg = await store.loginWithEmailAndPassword(email, password);

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }

    if (errorMsg == null) {
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const RootNavigation()),
          (route) => false,
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMsg),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

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
              AuthTextField(
                controller: _emailController,
                hintText: 'Email',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: AppSpacing.lg),
              PasswordTextField(
                controller: _passwordController,
              ),
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
              const SizedBox(height: AppSpacing.md),
              

              
              _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: AppColors.primary),
                    )
                  : PrimaryButton(
                      tieuDe: 'Đăng nhập',
                      onPressed: _dangNhap,
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

