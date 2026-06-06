// features/user/auth/screens/RegisterScreen/register_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/widgets/buttons/primary_button.dart';
import '../../../../../core/navigation/root_navigation.dart';
import '../../../../../providers/store_provider.dart';
import '../../widgets/auth_banner.dart';
import '../../widgets/auth_divider.dart';
import '../../widgets/auth_footer.dart';
import '../../widgets/auth_header.dart';
import '../../widgets/auth_text_field.dart';
import '../../widgets/password_text_field.dart';
import '../../widgets/social_login_button.dart';

import 'otp_screen.dart';
import '../../../../../core/services/email_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _tenController = TextEditingController();
  final _emailController = TextEditingController();
  final _soDienThoaiController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _dongYDieuKhoan = false;

  @override
  void dispose() {
    _tenController.dispose();
    _emailController.dispose();
    _soDienThoaiController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _dangKy() async {
    final ten = _tenController.text.trim();
    final email = _emailController.text.trim();
    final soDienThoai = _soDienThoaiController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (ten.isEmpty || email.isEmpty || soDienThoai.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng điền đầy đủ các trường thông tin!'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    // Email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Định dạng Email không hợp lệ!'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    // Phone validation
    if (soDienThoai.length < 10 || soDienThoai.length > 11 || !RegExp(r'^[0-9]+$').hasMatch(soDienThoai)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Số điện thoại phải chứa từ 10 đến 11 ký số!'),
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

    if (!_dongYDieuKhoan) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bạn phải đồng ý với điều khoản dịch vụ để đăng ký!'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final otp = EmailService.generateOTP();
    final bool emailSent = await EmailService.sendOTP(email, otp);

    if (mounted) {
      setState(() {
        _isLoading = false;
      });

      // Điều hướng sang màn hình OTP
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OTPScreen(
            email: email,
            password: password,
            ten: ten,
            soDienThoai: soDienThoai,
            otpCode: otp,
            emailSent: emailSent,
          ),
        ),
      );
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
                imageUrl: 'https://images.unsplash.com/photo-1529139574466-a303027c1d8b',
              ),
              const SizedBox(height: AppSpacing.xl),
              const AuthHeader(
                title: 'Create Account',
                subtitle: 'Tạo tài khoản mới để bắt đầu',
              ),
              const SizedBox(height: AppSpacing.xl),
              AuthTextField(
                controller: _tenController,
                hintText: 'Họ và tên',
                prefixIcon: Icons.person_outline,
              ),
              const SizedBox(height: AppSpacing.lg),
              AuthTextField(
                controller: _emailController,
                hintText: 'Email',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: AppSpacing.lg),
              AuthTextField(
                controller: _soDienThoaiController,
                hintText: 'Số điện thoại',
                prefixIcon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: AppSpacing.lg),
              PasswordTextField(
                controller: _passwordController,
              ),
              const SizedBox(height: AppSpacing.lg),
              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Nhập lại mật khẩu',
                  prefixIcon: const Icon(Icons.lock_outline),
                  filled: true,
                  fillColor: AppColors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                children: [
                  Checkbox(
                    value: _dongYDieuKhoan,
                    activeColor: AppColors.primary,
                    onChanged: (val) {
                      setState(() {
                        _dongYDieuKhoan = val ?? false;
                      });
                    },
                  ),
                  const Expanded(
                    child: Text(
                      'Tôi đồng ý với điều khoản dịch vụ (bao gồm chính sách trích tối đa 20% phí hoa hồng ký gửi cho Shop).',
                      style: TextStyle(fontSize: 12, height: 1.4),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              
              _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: AppColors.primary),
                    )
                  : PrimaryButton(
                      tieuDe: 'Tạo tài khoản',
                      onPressed: _dangKy,
                    ),
              const SizedBox(height: AppSpacing.xl),
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
