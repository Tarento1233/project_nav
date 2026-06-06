import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTypography {
  static const tieuDeLon = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const tieuDe = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const tieuDeNho = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static const noiDung = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static const moTa = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static const gia = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.accent,
  );

  static const giaGiam = TextStyle(
    fontSize: 14,
    decoration: TextDecoration.lineThrough,
    color: AppColors.textLight,
  );

  static const nutBam = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}

extension DinhDangTien on num {
  String toVND() {
    String str = toStringAsFixed(0);
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String formatted = str.replaceAllMapped(reg, (Match m) => '${m[1]}.');
    return '${formatted}đ';
  }
}
