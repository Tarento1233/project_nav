// features/user/home/home_header.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/inputs/search_field.dart';
import '../../../providers/store_provider.dart';

class HomeHeader extends StatelessWidget {
  final VoidCallback? onGioHangTap;
  final VoidCallback? onNotificationTap;
  final TextEditingController? searchController;

  const HomeHeader({
    super.key,
    this.onGioHangTap,
    this.onNotificationTap,
    this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Outlet Fashion', style: AppTypography.tieuDeLon),
                  const SizedBox(height: 4),
                  Text('Korean Luxury Style', style: AppTypography.moTa),
                ],
              ),
              Row(
                children: [
                  // Icon Quả chuông Thông báo
                  GestureDetector(
                    onTap: onNotificationTap,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.border),
                          ),
                          child: const Icon(
                            Icons.notifications_outlined,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        // Badge hiển thị số thông báo chưa đọc
                        Positioned(
                          top: -2,
                          right: -2,
                          child: Consumer<StoreProvider>(
                            builder: (context, store, _) {
                              final count = store.soThongBaoChuaDoc;
                              if (count == 0) return const SizedBox();
                              return Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: AppColors.error,
                                  shape: BoxShape.circle,
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 16,
                                  minHeight: 16,
                                ),
                                child: Center(
                                  child: Text(
                                    count > 9 ? '9+' : '$count',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  // Icon Giỏ hàng
                  GestureDetector(
                    onTap: onGioHangTap,
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.border),
                      ),
                      child: const Icon(
                        Icons.shopping_bag_outlined,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          SearchField(controller: searchController),
        ],
      ),
    );
  }
}
