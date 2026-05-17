import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';

class LoadingWidget extends StatelessWidget {
  final String? noiDung;

  final double kichThuoc;

  const LoadingWidget({super.key, this.noiDung, this.kichThuoc = 32});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),

        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            SizedBox(
              width: kichThuoc,

              height: kichThuoc,

              child: const CircularProgressIndicator(
                strokeWidth: 3,

                color: AppColors.primary,
              ),
            ),

            if (noiDung != null) ...[
              const SizedBox(height: AppSpacing.lg),

              Text(
                noiDung!,

                textAlign: TextAlign.center,

                style: AppTypography.moTa.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
