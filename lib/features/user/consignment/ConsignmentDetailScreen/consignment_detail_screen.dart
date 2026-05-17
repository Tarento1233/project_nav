// features/user/consignment/consignment_detail_screen.dart

import 'package:flutter/material.dart';

import '../../../../models/product_model.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

import '../../../../core/widgets/headers/custom_app_bar.dart';

import 'consignment_product_info.dart';
import 'consignment_status_card.dart';
import 'consignment_term_detail.dart';
import 'consignment_revenue_card.dart';

class ConsignmentDetailScreen extends StatelessWidget {
  final SanPhamModel sanPham;

  const ConsignmentDetailScreen({super.key, required this.sanPham});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: const CustomAppBar(tieuDe: 'Chi tiết ký gửi'),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),

        child: Column(
          children: [
            ConsignmentProductInfo(sanPham: sanPham),

            const SizedBox(height: AppSpacing.xl),

            ConsignmentStatusCard(trangThai: sanPham.trangThai),

            const SizedBox(height: AppSpacing.xl),

            const ConsignmentTermDetail(),

            const SizedBox(height: AppSpacing.xl),

            const ConsignmentRevenueCard(),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
