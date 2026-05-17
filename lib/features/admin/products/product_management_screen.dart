// features/admin/products/product_management_screen.dart

import 'package:flutter/material.dart';

import '../../../core/constants/mock_data.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

import '../../../core/widgets/headers/custom_app_bar.dart';

import 'admin_product_card.dart';
import 'product_search_bar.dart';
import 'product_filter_section.dart';
import 'add_product_button.dart';

class ProductManagementScreen extends StatelessWidget {
  const ProductManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final danhSachSanPham = DuLieuMau.danhSachSanPham;

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: const CustomAppBar(tieuDe: 'Quản lý sản phẩm'),

      floatingActionButton: const AddProductButton(),

      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(AppSpacing.lg),

            child: Column(
              children: [
                ProductSearchBar(),

                SizedBox(height: AppSpacing.lg),

                ProductFilterSection(),
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
                return AdminProductCard(
                  sanPham: danhSachSanPham[index],

                  onEdit: () {},

                  onDelete: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
