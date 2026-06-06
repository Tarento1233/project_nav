// features/admin/commission/CommissionScreen/commission_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/headers/custom_app_bar.dart';
import '../../../../providers/store_provider.dart';

class CommissionScreen extends StatefulWidget {
  const CommissionScreen({super.key});

  @override
  State<CommissionScreen> createState() => _CommissionScreenState();
}

class _CommissionScreenState extends State<CommissionScreen> {
  final _rateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final store = Provider.of<StoreProvider>(context, listen: false);
    _rateController.text = store.defaultCommissionRate.toStringAsFixed(0);
  }

  @override
  void dispose() {
    _rateController.dispose();
    super.dispose();
  }

  void _luuCauHinh() async {
    if (!_formKey.currentState!.validate()) return;

    final rate = double.tryParse(_rateController.text.trim());
    if (rate == null || rate < 0 || rate > 20) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tỷ lệ hoa hồng phải từ 0% đến 20%!'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final store = Provider.of<StoreProvider>(context, listen: false);
      await store.updateDefaultCommissionRate(rate);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cập nhật cấu hình hoa hồng thành công!'),
          backgroundColor: AppColors.success,
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lỗi: ${e.toString()}'),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<StoreProvider>(context);
    final tongHoaHongShop = store.adminTotalCommissionEarned;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(tieuDe: 'Tài chính & Hoa hồng'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thẻ Thống Kê Tổng Hoa Hồng
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.xl),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryDark],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  boxShadow: AppShadows.cardShadow,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.analytics_outlined, color: Colors.white70, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Tổng hoa hồng shop đã thu',
                          style: AppTypography.noiDung.copyWith(color: Colors.white70),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      tongHoaHongShop.toVND(),
                      style: AppTypography.gia.copyWith(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Tính trên tất cả các đơn ký gửi đã bán thành công',
                      style: TextStyle(color: Colors.white60, fontSize: 11),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Thẻ Cấu Hình Hoa Hồng Mặc Định
              Text(
                'Cấu hình tỷ lệ hoa hồng mặc định',
                style: AppTypography.tieuDeNho,
              ),
              const SizedBox(height: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(color: AppColors.border),
                  boxShadow: AppShadows.cardShadow,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tỷ lệ phần trăm hoa hồng mặc định mà Shop thu trên mỗi đơn hàng ký gửi của khách hàng.',
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.4),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    TextFormField(
                      controller: _rateController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Tỷ lệ mặc định (%)',
                        suffixText: '%',
                        prefixIcon: const Icon(Icons.percent, color: AppColors.primaryDark),
                        filled: true,
                        fillColor: AppColors.background,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppRadius.md),
                          borderSide: BorderSide(color: AppColors.border),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Vui lòng nhập tỷ lệ hoa hồng!';
                        }
                        final numVal = double.tryParse(value.trim());
                        if (numVal == null || numVal < 0) {
                          return 'Vui lòng nhập số hợp lệ lớn hơn 0!';
                        }
                        if (numVal > 20) {
                          return 'Tỷ lệ hoa hồng tối đa chỉ được 20%!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: AppColors.warning.withOpacity(0.8), size: 16),
                        const SizedBox(width: 6),
                        const Expanded(
                          child: Text(
                            'Lưu ý: Tỷ lệ chỉ được cấu hình tối đa là 20%.',
                            style: TextStyle(
                              color: AppColors.textLight,
                              fontSize: 11,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Nút Lưu Cấu Hình
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _luuCauHinh,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryDark,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                    ),
                    elevation: 2,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                        )
                      : Text(
                          'Lưu cấu hình hệ thống',
                          style: AppTypography.tieuDeNho.copyWith(color: Colors.white),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
