// features/admin/orders/admin_update_status_section.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';

import '../../../../core/widgets/buttons/primary_button.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../models/order_model.dart';
import '../../../../providers/store_provider.dart';

class AdminUpdateStatusSection extends StatelessWidget {
  final DonHangModel donHang;

  const AdminUpdateStatusSection({super.key, required this.donHang});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<StoreProvider>(context);
    
    // Ánh xạ trạng thái hiển thị tiếng Việt và giá trị lưu trữ
    final List<Map<String, String>> statuses = [
      {'label': 'Đang giao', 'value': 'DANG_GIAO'},
      {'label': 'Hoàn tất', 'value': 'HOAN_THANH'},
      {'label': 'Đã hủy', 'value': 'DA_HUY'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cập nhật trạng thái (Hiện tại: ${donHang.trangThai})',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.lg),
        Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.md,
          children: List.generate(statuses.length, (index) {
            final status = statuses[index];
            final value = status['value']!;
            final label = status['label']!;
            
            // Highlight trạng thái hiện tại
            final isCurrent = donHang.trangThai == value;

            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isCurrent ? AppColors.primary : AppColors.surface,
                foregroundColor: isCurrent ? Colors.white : AppColors.textPrimary,
                side: BorderSide(color: isCurrent ? AppColors.primary : AppColors.border),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: isCurrent
                  ? null
                  : () {
                      store.updateOrderStatus(donHang.id, value);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Đã cập nhật trạng thái đơn hàng thành: $label'),
                          backgroundColor: value == 'HOAN_THANH' ? AppColors.success : AppColors.primaryDark,
                        ),
                      );
                    },
              child: Text(label),
            );
          }),
        ),
      ],
    );
  }
}

