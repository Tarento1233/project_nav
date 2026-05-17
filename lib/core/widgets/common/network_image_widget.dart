import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import '../../constants/app_assets.dart';

class NetworkImageWidget extends StatelessWidget {
  final String imageUrl;

  final double width;

  final double height;

  final BoxFit fit;

  final double radius;

  const NetworkImageWidget({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
    this.radius = AppRadius.md,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),

      child: Image.network(
        imageUrl,

        width: width,

        height: height,

        fit: fit,

        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }

          return Container(
            width: width,

            height: height,

            color: AppColors.surface,

            alignment: Alignment.center,

            child: const CircularProgressIndicator(color: AppColors.primary),
          );
        },

        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: width,

            height: height,

            color: AppColors.surface,

            alignment: Alignment.center,

            child: Image.asset(
              TaiNguyenUngDung.anhSanPhamMacDinh,

              fit: BoxFit.contain,
            ),
          );
        },
      ),
    );
  }
}
