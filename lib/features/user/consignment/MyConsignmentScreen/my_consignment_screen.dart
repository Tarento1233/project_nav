// features/user/consignment/my_consignment_screen.dart

import 'package:flutter/material.dart';

import '../../../../core/constants/mock_data.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

import '../../../../core/widgets/headers/custom_app_bar.dart';

import 'consignment_card.dart';
import 'consignment_status_tab.dart';
import 'create_consignment_button.dart';

class MyConsignmentScreen extends StatelessWidget {
  const MyConsignmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final danhSachSanPham = DuLieuMau.danhSachSanPham;

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: const CustomAppBar(tieuDe: 'Sản phẩm ký gửi'),

      floatingActionButton: const CreateConsignmentButton(),

      body: Column(
        children: [
          const ConsignmentStatusTab(),

          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.lg),

              itemCount: danhSachSanPham.length,

              separatorBuilder: (_, __) =>
                  const SizedBox(height: AppSpacing.lg),

              itemBuilder: (context, index) {
                return ConsignmentCard(
                  sanPham: danhSachSanPham[index],

                  onTap: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
