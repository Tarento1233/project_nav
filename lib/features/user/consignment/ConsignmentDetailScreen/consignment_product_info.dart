// features/user/consignment/consignment_product_info.dart

import 'package:flutter/material.dart';

import '../../../../models/product_model.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class ConsignmentProductInfo extends StatelessWidget {
  final SanPhamModel sanPham;

  const ConsignmentProductInfo({super.key, required this.sanPham});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      decoration: BoxDecoration(
        color: AppColors.surface,

        borderRadius: BorderRadius.circular(AppRadius.lg),

        boxShadow: AppShadows.cardShadow,
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppRadius.lg),

              topRight: Radius.circular(AppRadius.lg),
            ),

            child: Image.network(
              sanPham.hinhAnh.first,

              width: double.infinity,

              height: 250,

              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(sanPham.ten, style: AppTypography.tieuDe),

                const SizedBox(height: AppSpacing.md),

                Text(sanPham.moTa, style: AppTypography.noiDung),

                const SizedBox(height: AppSpacing.lg),

                thongTin('Thương hiệu', sanPham.thuongHieuId),

                thongTin('Danh mục', sanPham.danhMucId),

                thongTin('Kích thước', sanPham.kichThuoc),

                thongTin('Tình trạng', sanPham.tinhTrang),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget thongTin(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text(title, style: AppTypography.moTa),

          Text(value, style: AppTypography.noiDung),
        ],
      ),
    );
  }
}
