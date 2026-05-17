import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_typography.dart';

class StatusBadge extends StatelessWidget {
  final String trangThai;

  const StatusBadge({super.key, required this.trangThai});

  Color layMauNen() {
    switch (trangThai.toUpperCase()) {
      case 'CHO_XAC_NHAN':
      case 'CHO_DUYET':
        return AppColors.warning.withOpacity(0.15);

      case 'DA_XAC_NHAN':
      case 'DA_DUYET':
      case 'THANH_CONG':
        return AppColors.success.withOpacity(0.15);

      case 'DANG_GIAO':
      case 'DANG_BAN':
        return AppColors.primary.withOpacity(0.15);

      case 'DA_HUY':
      case 'BI_TU_CHOI':
      case 'THAT_BAI':
        return AppColors.error.withOpacity(0.15);

      case 'DA_GIAO':
      case 'DA_BAN':
        return AppColors.accent.withOpacity(0.12);

      default:
        return AppColors.border;
    }
  }

  Color layMauChu() {
    switch (trangThai.toUpperCase()) {
      case 'CHO_XAC_NHAN':
      case 'CHO_DUYET':
        return AppColors.warning;

      case 'DA_XAC_NHAN':
      case 'DA_DUYET':
      case 'THANH_CONG':
        return AppColors.success;

      case 'DANG_GIAO':
      case 'DANG_BAN':
        return AppColors.primaryDark;

      case 'DA_HUY':
      case 'BI_TU_CHOI':
      case 'THAT_BAI':
        return AppColors.error;

      case 'DA_GIAO':
      case 'DA_BAN':
        return AppColors.accent;

      default:
        return AppColors.textSecondary;
    }
  }

  String hienThiTrangThai() {
    switch (trangThai.toUpperCase()) {
      case 'CHO_XAC_NHAN':
        return 'Chờ xác nhận';

      case 'CHO_DUYET':
        return 'Chờ duyệt';

      case 'DA_XAC_NHAN':
        return 'Đã xác nhận';

      case 'DA_DUYET':
        return 'Đã duyệt';

      case 'DANG_GIAO':
        return 'Đang giao';

      case 'DA_GIAO':
        return 'Đã giao';

      case 'DANG_BAN':
        return 'Đang bán';

      case 'DA_BAN':
        return 'Đã bán';

      case 'DA_HUY':
        return 'Đã hủy';

      case 'BI_TU_CHOI':
        return 'Bị từ chối';

      case 'THANH_CONG':
        return 'Thành công';

      case 'THAT_BAI':
        return 'Thất bại';

      default:
        return trangThai;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),

      decoration: BoxDecoration(
        color: layMauNen(),

        borderRadius: BorderRadius.circular(AppRadius.md),
      ),

      child: Text(
        hienThiTrangThai(),

        style: AppTypography.moTa.copyWith(
          color: layMauChu(),

          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
