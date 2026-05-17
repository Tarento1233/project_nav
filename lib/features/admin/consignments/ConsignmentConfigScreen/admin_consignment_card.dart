// features/admin/consignments/admin_consignment_card.dart

import 'package:flutter/material.dart';

import '../../../../models/product_model.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

import '../../../../core/widgets/common/network_image_widget.dart';
import '../../../../core/widgets/badges/status_badge.dart';

import 'consignment_action_button.dart';

class AdminConsignmentCard extends StatelessWidget {
  final SanPhamModel sanPham;

  final VoidCallback onApprove;

  final VoidCallback onReject;

  final VoidCallback onDetail;

  const AdminConsignmentCard({
    super.key,
    required this.sanPham,
    required this.onApprove,
    required this.onReject,
    required this.onDetail,
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

      child: Column(
        children: [
          Row(
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
                      '${sanPham.gia.toStringAsFixed(0)}đ',

                      style: AppTypography.gia,
                    ),

                    const SizedBox(height: AppSpacing.sm),

                    Text('Người gửi: USER_01', style: AppTypography.moTa),

                    const SizedBox(height: AppSpacing.sm),

                    StatusBadge(trangThai: sanPham.trangThai),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          Row(
            children: [
              Expanded(
                child: ConsignmentActionButton(
                  title: 'Duyệt',

                  onPressed: onApprove,
                ),
              ),

              const SizedBox(width: AppSpacing.md),

              Expanded(
                child: ConsignmentActionButton(
                  title: 'Từ chối',

                  onPressed: onReject,
                ),
              ),

              const SizedBox(width: AppSpacing.md),

              Expanded(
                child: OutlinedButton(
                  onPressed: onDetail,

                  child: const Text('Chi tiết'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
