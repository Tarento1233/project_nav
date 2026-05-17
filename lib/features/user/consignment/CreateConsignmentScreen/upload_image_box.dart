// features/user/consignment/upload_image_box.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class UploadImageBox extends StatelessWidget {
  const UploadImageBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      height: 180,

      decoration: BoxDecoration(
        color: AppColors.surface,

        borderRadius: BorderRadius.circular(AppRadius.lg),

        border: Border.all(color: AppColors.border),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Icon(Icons.cloud_upload_outlined, size: 50, color: AppColors.primary),

          const SizedBox(height: AppSpacing.md),

          Text('Tải ảnh sản phẩm', style: AppTypography.tieuDeNho),

          const SizedBox(height: 4),

          Text('PNG, JPG hoặc JPEG', style: AppTypography.moTa),
        ],
      ),
    );
  }
}
