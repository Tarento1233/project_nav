// features/user/auth/screens/RegisterScreen/otp_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../core/widgets/headers/custom_app_bar.dart';
import '../../../../../core/widgets/buttons/primary_button.dart';
import '../../../../../core/navigation/root_navigation.dart';
import '../../../../../providers/store_provider.dart';

class OTPScreen extends StatefulWidget {
  final String email;
  final String password;
  final String ten;
  final String soDienThoai;
  final String otpCode;
  final bool emailSent;

  const OTPScreen({
    super.key,
    required this.email,
    required this.password,
    required this.ten,
    required this.soDienThoai,
    required this.otpCode,
    required this.emailSent,
  });

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _otpController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Hiển thị thông báo SnackBar khi vào màn hình
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.emailSent) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Mã OTP thật đã gửi đến email ${widget.email}. Vui lòng kiểm tra hộp thư!'),
            backgroundColor: AppColors.success,
            duration: const Duration(seconds: 5),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Không thể gửi mail (Chưa cấu hình App Password). Mã OTP test là: ${widget.otpCode}'),
            backgroundColor: AppColors.primary,
            duration: const Duration(seconds: 8),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _xacThucOtp() async {
    final otpInput = _otpController.text.trim();
    if (otpInput.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng nhập mã OTP!'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    if (otpInput != widget.otpCode) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.emailSent
              ? 'Mã OTP không chính xác! Vui lòng kiểm tra lại email của bạn.'
              : 'Mã OTP không chính xác! Vui lòng nhập lại (Mã gợi ý: ${widget.otpCode}).'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final store = Provider.of<StoreProvider>(context, listen: false);
    final success = await store.registerWithEmailAndPassword(
      email: widget.email,
      password: widget.password,
      ten: widget.ten,
      soDienThoai: widget.soDienThoai,
    );

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }

    if (success) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Xác thực thành công! Tạo tài khoản thành công.'),
            backgroundColor: AppColors.success,
          ),
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const RootNavigation()),
          (route) => false,
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Đăng ký thất bại! Email có thể đã được đăng ký trước đó.'),
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
      appBar: const CustomAppBar(tieuDe: 'Xác thực tài khoản'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.xl),
            Container(
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: BoxDecoration(
                color: AppColors.surface,
                shape: BoxShape.circle,
                boxShadow: AppShadows.cardShadow,
              ),
              child: const Icon(
                Icons.mark_email_unread_outlined,
                size: 64,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              'Xác nhận mã OTP',
              style: AppTypography.tieuDe,
            ),
            const SizedBox(height: AppSpacing.md),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Text(
                'Mã xác thực gồm 6 chữ số được áp dụng cho email của bạn: ${widget.email}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.textSecondary, height: 1.4),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            
            // Hộp nhập OTP
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22, letterSpacing: 8, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                hintText: 'xxxxxx',
                hintStyle: const TextStyle(fontSize: 22, letterSpacing: 8, color: AppColors.textLight),
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  borderSide: BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Hộp hiển thị trạng thái OTP & mã OTP để test/chấm bài
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: widget.emailSent 
                    ? AppColors.success.withOpacity(0.1)
                    : AppColors.primaryLight.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(
                  color: widget.emailSent 
                      ? AppColors.success.withOpacity(0.3)
                      : AppColors.primary.withOpacity(0.3)
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    widget.emailSent ? Icons.mark_email_read_outlined : Icons.vpn_key_outlined, 
                    color: widget.emailSent ? AppColors.success : AppColors.primaryDark
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(color: AppColors.textPrimary, fontSize: 13, height: 1.4),
                        children: widget.emailSent
                          ? [
                              const TextSpan(
                                text: 'Hệ thống đã gửi một email thật chứa mã OTP đến địa chỉ trên. Vui lòng kiểm tra Hộp thư đến hoặc Thư rác (Spam) để lấy mã xác nhận.',
                              ),
                            ]
                          : [
                              const TextSpan(
                                text: 'Hệ thống đang hoạt động ở chế độ giả lập (do chưa cấu hình Gmail App Password trong EmailService).\n'
                              ),
                              const TextSpan(text: 'Mã OTP để đăng ký thành công là: '),
                              TextSpan(
                                text: widget.otpCode,
                                style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.error, fontSize: 15),
                              ),
                            ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            _isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  )
                : PrimaryButton(
                    tieuDe: 'Xác thực & Đăng ký',
                    onPressed: _xacThucOtp,
                  ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

