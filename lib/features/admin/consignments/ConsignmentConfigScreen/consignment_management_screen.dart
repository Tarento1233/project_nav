// features/admin/consignments/consignment_management_screen.dart

import 'package:flutter/material.dart';

import '../../../../core/constants/mock_data.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

import '../../../../core/widgets/headers/custom_app_bar.dart';

import 'admin_consignment_card.dart';
import 'consignment_filter_section.dart';
import 'consignment_search_bar.dart';

class ConsignmentManagementScreen extends StatelessWidget {
  const ConsignmentManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final danhSachSanPham = DuLieuMau.danhSachSanPham;

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: const CustomAppBar(tieuDe: 'Quản lý ký gửi'),

      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(AppSpacing.lg),

            child: Column(
              children: [
                ConsignmentSearchBar(),

                SizedBox(height: AppSpacing.lg),

                ConsignmentFilterSection(),
              ],
            ),
          ),

          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),

              itemCount: danhSachSanPham.length,

              separatorBuilder: (_, __) =>
                  const SizedBox(height: AppSpacing.lg),

              itemBuilder: (context, index) {
                return AdminConsignmentCard(
                  sanPham: danhSachSanPham[index],

                  onApprove: () {},

                  onReject: () {},

                  onDetail: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
