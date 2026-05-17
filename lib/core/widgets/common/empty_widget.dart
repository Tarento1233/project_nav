import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';
import '../../constants/app_assets.dart';

class EmptyWidget extends StatelessWidget {
  final String tieuDe;

  final String moTa;

  final String? hinhAnh;

  final Widget? action;

  const EmptyWidget({
    super.key,
    required this.tieuDe,
    required this.moTa,
    this.hinhAnh,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Image.asset(
              hinhAnh ?? TaiNguyenUngDung.gioHangTrong,

              width: 180,

              height: 180,

              fit: BoxFit.contain,
            ),

            const SizedBox(height: AppSpacing.xl),

            Text(
              tieuDe,

              textAlign: TextAlign.center,

              style: AppTypography.tieuDe.copyWith(
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            Text(
              moTa,

              textAlign: TextAlign.center,

              style: AppTypography.moTa.copyWith(
                color: AppColors.textSecondary,

                height: 1.5,
              ),
            ),

            if (action != null) ...[
              const SizedBox(height: AppSpacing.xl),

              action!,
            ],
          ],
        ),
      ),
    );
  }
}
