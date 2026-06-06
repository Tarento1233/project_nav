import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/widgets/buttons/primary_button.dart';
import '../../../../../providers/store_provider.dart';
import '../../widgets/auth_banner.dart';
import '../../widgets/auth_header.dart';
import '../../widgets/password_text_field.dart';
import '../LoginScreen/login_screen.dart';

class ResetNewPasswordScreen extends StatefulWidget {
  final String email;

  const ResetNewPasswordScreen({super.key, required this.email});

  @override
  State<ResetNewPasswordScreen> createState() => _ResetNewPasswordScreenState();
}

class _ResetNewPasswordScreenState extends State<ResetNewPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _resetPassword() async {
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng nhập mật khẩu mới!'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mật khẩu mới phải từ 6 ký tự trở lên!'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mật khẩu nhập lại không khớp!'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final store = Provider.of<StoreProvider>(context, listen: false);
    final errorMsg = await store.resetPasswordInApp(
      email: widget.email,
      newPassword: password,
    );

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }

    if (errorMsg == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Đổi mật khẩu thành công! Vui lòng đăng nhập lại.'),
            backgroundColor: AppColors.success,
          ),
        );
        // Quay trở lại màn hình đăng nhập, xóa tất cả stack trước đó
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
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
                imageUrl: 'https://images.unsplash.com/photo-1509062522246-3755977927d7',
              ),
              const SizedBox(height: AppSpacing.xl),
              const AuthHeader(
                title: 'Đặt lại mật khẩu',
                subtitle: 'Nhập mật khẩu mới cho tài khoản của bạn',
              ),
              const SizedBox(height: AppSpacing.xl),
              PasswordTextField(
                controller: _passwordController,
                hintText: 'Mật khẩu mới',
              ),
              const SizedBox(height: AppSpacing.lg),
              PasswordTextField(
                controller: _confirmPasswordController,
                hintText: 'Nhập lại mật khẩu mới',
              ),
              const SizedBox(height: AppSpacing.xxl),
              _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: AppColors.primary),
                    )
                  : PrimaryButton(
                      tieuDe: 'Đặt lại mật khẩu',
                      onPressed: _resetPassword,
                    ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
