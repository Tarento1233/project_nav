// features/user/consignment/consignment_card.dart

import 'package:flutter/material.dart';

import '../../../../models/product_model.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

import '../../../../core/widgets/common/network_image_widget.dart';
import '../../../../core/widgets/badges/status_badge.dart';

class ConsignmentCard extends StatelessWidget {
  final SanPhamModel sanPham;

  final VoidCallback onTap;

  const ConsignmentCard({
    super.key,
    required this.sanPham,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),

        decoration: BoxDecoration(
          color: AppColors.surface,

          borderRadius: BorderRadius.circular(AppRadius.lg),

          boxShadow: AppShadows.cardShadow,
        ),

        child: Row(
          children: [
            NetworkImageWidget(
              imageUrl: sanPham.hinhAnh.first,

              width: 100,

              height: 100,
            ),

            const SizedBox(width: AppSpacing.md),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    sanPham.ten,

                    maxLines: 2,

                    overflow: TextOverflow.ellipsis,

                    style: AppTypography.tieuDeNho,
                  ),

                  const SizedBox(height: AppSpacing.sm),

                  Text(
                    sanPham.gia.toVND(),

                    style: AppTypography.gia,
                  ),

                  const SizedBox(height: AppSpacing.sm),

                  Text('Ngày gửi: 12/05/2026', style: AppTypography.moTa),
                ],
              ),
            ),

            StatusBadge(trangThai: sanPham.trangThai),
          ],
        ),
      ),
    );
  }
}
