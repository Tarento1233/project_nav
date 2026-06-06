import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/widgets/buttons/primary_button.dart';
import '../../../../../core/services/email_service.dart';
import '../../widgets/auth_banner.dart';
import '../../widgets/auth_footer.dart';
import '../../widgets/auth_header.dart';
import '../../widgets/auth_text_field.dart';
import 'forgot_pass_otp_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _sendPasswordResetEmail() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng nhập Email!'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

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

    setState(() {
      _isLoading = true;
    });

    try {
      // Kiểm tra xem email có tồn tại trên hệ thống Firestore hay không
      final userQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (userQuery.docs.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Email này chưa được đăng ký tài khoản!'),
              backgroundColor: AppColors.error,
            ),
          );
        }
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // Tạo OTP
      final otp = EmailService.generateOTP();
      
      // Gửi OTP
      final bool emailSent = await EmailService.sendForgotPasswordOTP(email, otp);

      if (mounted) {
        // Chuyển sang màn hình xác thực OTP khôi phục mật khẩu
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ForgotPassOtpScreen(
              email: email,
              otpCode: otp,
              emailSent: emailSent,
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lỗi: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
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
                imageUrl: 'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f',
              ),
              const SizedBox(height: AppSpacing.xl),
              const AuthHeader(
                title: 'Forgot Password',
                subtitle: 'Nhập email để nhận liên kết khôi phục mật khẩu',
              ),
              const SizedBox(height: AppSpacing.xl),
              AuthTextField(
                controller: _emailController,
                hintText: 'Email',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: AppSpacing.xxl),
              _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: AppColors.primary),
                    )
                  : PrimaryButton(
                      tieuDe: 'Gửi email xác nhận',
                      onPressed: _sendPasswordResetEmail,
                    ),
              const SizedBox(height: AppSpacing.xl),
              AuthFooter(
                text: 'Đã nhớ mật khẩu? ',
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
