import 'package:flutter/material.dart';

import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';
import '../../theme/global_styles.dart';
import '../badges/status_badge.dart';

class OrderCard extends StatelessWidget {
  final String maDonHang;

  final String trangThai;

  final double tongTien;

  const OrderCard({
    super.key,
    required this.maDonHang,
    required this.trangThai,
    required this.tongTien,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: GlobalStyles.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(maDonHang, style: AppTypography.tieuDeNho),
              StatusBadge(trangThai: trangThai),
            ],
          ),
          const SizedBox(height: 12),
          Text('${tongTien.toStringAsFixed(0)}đ', style: AppTypography.gia),
        ],
      ),
    );
  }
}
