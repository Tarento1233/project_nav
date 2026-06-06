// features/user/notification/notification_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/headers/custom_app_bar.dart';
import '../../../providers/store_provider.dart';
import '../../../models/notification_model.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  IconData _layIconTheoLoai(String loai) {
    switch (loai) {
      case 'DON_HANG':
        return Icons.local_shipping_outlined;
      case 'KY_GUI':
        return Icons.sell_outlined;
      case 'VI_TIEN':
        return Icons.account_balance_wallet_outlined;
      default:
        return Icons.notifications_none_outlined;
    }
  }

  Color _layMauTheoLoai(String loai) {
    switch (loai) {
      case 'DON_HANG':
        return AppColors.primaryDark;
      case 'KY_GUI':
        return AppColors.success;
      case 'VI_TIEN':
        return AppColors.warning;
      default:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<StoreProvider>(context);
    final thongBaos = store.thongBaoCuaToi;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        tieuDe: 'Thông báo',
        actions: [
          if (store.soThongBaoChuaDoc > 0)
            IconButton(
              icon: const Icon(Icons.done_all_rounded, color: AppColors.primaryDark),
              tooltip: 'Đọc tất cả',
              onPressed: () {
                store.markAllNotificationsAsRead();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Đã đánh dấu đọc tất cả thông báo!'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
            ),
        ],
      ),
      body: thongBaos.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      shape: BoxShape.circle,
                      boxShadow: AppShadows.cardShadow,
                    ),
                    child: const Icon(
                      Icons.notifications_off_outlined,
                      size: 64,
                      color: AppColors.textLight,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    'Không có thông báo nào',
                    style: AppTypography.tieuDeNho.copyWith(color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Thông báo về đơn hàng và ký gửi sẽ xuất hiện ở đây',
                    style: TextStyle(color: AppColors.textLight, fontSize: 13),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.lg),
              itemCount: thongBaos.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final tb = thongBaos[index];
                final icon = _layIconTheoLoai(tb.loai);
                final color = _layMauTheoLoai(tb.loai);
                final dateStr = '${tb.ngayTao.day.toString().padLeft(2, '0')}/${tb.ngayTao.month.toString().padLeft(2, '0')}/${tb.ngayTao.year} ${tb.ngayTao.hour.toString().padLeft(2, '0')}:${tb.ngayTao.minute.toString().padLeft(2, '0')}';

                return GestureDetector(
                  onTap: () {
                    if (!tb.daDoc) {
                      store.markNotificationAsRead(tb.id);
                    }
                    // Hiển thị dialog chi tiết thông báo
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.lg),
                        ),
                        title: Row(
                          children: [
                            Icon(icon, color: color),
                            const SizedBox(width: 10),
                            Expanded(child: Text(tb.tieuDe, style: AppTypography.tieuDeNho)),
                          ],
                        ),
                        content: Text(tb.noiDung, style: AppTypography.noiDung),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Đóng'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: BoxDecoration(
                      color: tb.daDoc ? AppColors.surface : AppColors.primaryLight.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      border: Border.all(
                        color: tb.daDoc ? AppColors.border : AppColors.primaryDark.withOpacity(0.3),
                      ),
                      boxShadow: tb.daDoc ? AppShadows.cardShadow : null,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Icon quả chuông hoặc xe tải, thẻ giá, ví tiền tương ứng
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(icon, color: color, size: 24),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      tb.tieuDe,
                                      style: AppTypography.tieuDeNho.copyWith(
                                        fontSize: 15,
                                        fontWeight: tb.daDoc ? FontWeight.w500 : FontWeight.bold,
                                        color: tb.daDoc ? AppColors.textPrimary : AppColors.accent,
                                      ),
                                    ),
                                  ),
                                  if (!tb.daDoc)
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: const BoxDecoration(
                                        color: AppColors.error,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                tb.noiDung,
                                style: AppTypography.moTa.copyWith(
                                  color: tb.daDoc ? AppColors.textSecondary : AppColors.textPrimary,
                                  fontSize: 13,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                dateStr,
                                style: const TextStyle(
                                  color: AppColors.textLight,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
