// features/admin/consignments/admin_consignment_detail_screen.dart

import 'package:flutter/material.dart';

import '../../../../models/product_model.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

import '../../../../core/widgets/headers/custom_app_bar.dart';

import '../../../user/consignment/ConsignmentDetailScreen/consignment_product_info.dart';

import 'consignor_info_card.dart';
import 'consignment_term_admin_card.dart';
import 'consignment_status_admin_card.dart';
import 'consignment_action_section.dart';

class AdminConsignmentDetailScreen extends StatelessWidget {
  final SanPhamModel sanPham;

  const AdminConsignmentDetailScreen({super.key, required this.sanPham});

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

            const ConsignorInfoCard(),

            const SizedBox(height: AppSpacing.xl),

            ConsignmentStatusAdminCard(trangThai: sanPham.trangThai),

            const SizedBox(height: AppSpacing.xl),

            const ConsignmentTermAdminCard(),

            const SizedBox(height: AppSpacing.xl),

            const ConsignmentActionSection(),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
