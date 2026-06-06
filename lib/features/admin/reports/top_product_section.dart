// features/admin/reports/top_product_section.dart

import 'package:flutter/material.dart';

import '../../../core/constants/mock_data.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

import '../../../core/widgets/common/network_image_widget.dart';

class TopProductSection extends StatelessWidget {
  const TopProductSection({super.key});

  @override
  Widget build(BuildContext context) {
    final sanPham = DuLieuMau.danhSachSanPham;

    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(AppSpacing.lg),

      decoration: BoxDecoration(
        color: AppColors.surface,

        borderRadius: BorderRadius.circular(AppRadius.lg),

        boxShadow: AppShadows.cardShadow,
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text('Sản phẩm bán chạy', style: AppTypography.tieuDeNho),

          const SizedBox(height: AppSpacing.lg),

          ...List.generate(3, (index) {
            final item = sanPham[index];

            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.lg),

              child: Row(
                children: [
                  NetworkImageWidget(
                    imageUrl: item.hinhAnh.first,

                    width: 70,

                    height: 70,
                  ),

                  const SizedBox(width: AppSpacing.md),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(item.ten, style: AppTypography.noiDung),

                        const SizedBox(height: 4),

                        Text(
                          item.gia.toVND(),

                          style: AppTypography.gia,
                        ),
                      ],
                    ),
                  ),

                  Text('#${index + 1}', style: AppTypography.tieuDe),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
