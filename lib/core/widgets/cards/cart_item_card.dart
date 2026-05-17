import 'package:flutter/material.dart';

import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';
import '../../theme/global_styles.dart';

class CartItemCard extends StatelessWidget {
  final String ten;

  final String hinhAnh;

  final double gia;

  final int soLuong;

  const CartItemCard({
    super.key,
    required this.ten,
    required this.hinhAnh,
    required this.gia,
    required this.soLuong,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: GlobalStyles.cardDecoration,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              hinhAnh,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ten, style: AppTypography.noiDung),
                const SizedBox(height: 8),
                Text('${gia.toStringAsFixed(0)}đ', style: AppTypography.gia),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
