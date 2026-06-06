// features/admin/products/admin_product_card.dart

import 'package:flutter/material.dart';

import '../../../models/product_model.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

import '../../../core/widgets/common/network_image_widget.dart';
import '../../../core/widgets/badges/status_badge.dart';

class AdminProductCard extends StatelessWidget {
  final SanPhamModel sanPham;

  final VoidCallback? onEdit;

  final VoidCallback onDelete;

  final VoidCallback? onToggleFeatured;

  const AdminProductCard({
    super.key,
    required this.sanPham,
    this.onEdit,
    required this.onDelete,
    this.onToggleFeatured,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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

            width: 90,

            height: 90,
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

                Text('Tồn kho: ${sanPham.tonKho}', style: AppTypography.moTa),

                const SizedBox(height: AppSpacing.sm),

                StatusBadge(trangThai: sanPham.trangThai),
              ],
            ),
          ),

          Column(
            children: [
              Builder(
                builder: (context) {
                  final isDANG_BAN = sanPham.trangThai == 'DANG_BAN';
                  final isConHang = sanPham.tonKho > 0;
                  final canBeFeatured = isDANG_BAN && isConHang;

                  return IconButton(
                    onPressed: canBeFeatured && onToggleFeatured != null
                        ? onToggleFeatured
                        : () {
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Chỉ sản phẩm Đang bán và Còn hàng mới được thiết lập nổi bật!'),
                                backgroundColor: AppColors.error,
                              ),
                            );
                          },
                    icon: Icon(
                      sanPham.noiBat ? Icons.star_rounded : Icons.star_border_rounded,
                      color: canBeFeatured
                          ? (sanPham.noiBat ? Colors.amber : AppColors.textSecondary)
                          : Colors.grey.withOpacity(0.3),
                    ),
                    tooltip: canBeFeatured
                        ? (sanPham.noiBat ? 'Bỏ nổi bật' : 'Đánh dấu nổi bật')
                        : 'Không thể thiết lập nổi bật',
                  );
                }
              ),

              if (onEdit != null)
                IconButton(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit_outlined),
                ),

              IconButton(
                onPressed: onDelete,

                icon: const Icon(Icons.delete_outline),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
