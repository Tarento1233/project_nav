// core/widgets/cards/product_card.dart

import 'package:flutter/material.dart';

import '../../../models/product_model.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_shadows.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';

class ProductCard extends StatelessWidget {
  final SanPhamModel sanPham;

  final VoidCallback onTap;

  const ProductCard({super.key, required this.sanPham, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        width: 180,

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(AppRadius.lg),

          boxShadow: AppShadows.cardShadow,
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            AspectRatio(
              aspectRatio: 1.1,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppRadius.lg),
                  topRight: Radius.circular(AppRadius.lg),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      sanPham.hinhAnh.first,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    if (sanPham.tonKho <= 0 || sanPham.trangThai == 'DA_BAN')
                      Container(
                        color: Colors.black.withOpacity(0.5),
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.error.withOpacity(0.85),
                              borderRadius: BorderRadius.circular(AppRadius.sm),
                            ),
                            child: const Text(
                              'Hết hàng',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Text(
                      sanPham.ten,

                      maxLines: 2,

                      overflow: TextOverflow.ellipsis,

                      style: AppTypography.tieuDeNho.copyWith(fontSize: 16),
                    ),

                    const SizedBox(height: AppSpacing.sm),

                    Text(
                      sanPham.gia.toVND(),

                      style: AppTypography.gia.copyWith(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
