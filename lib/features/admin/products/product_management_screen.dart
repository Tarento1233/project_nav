// features/admin/products/product_management_screen.dart

import 'package:flutter/material.dart';

import '../../../core/constants/mock_data.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/headers/custom_app_bar.dart';
import 'CreateProductScreen/create_product_screen.dart';
import 'EditProductScreen/edit_product_screen.dart';

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
      appBar: const CustomAppBar(tieuDe: 'Quản lý sản phẩm', hienThiNutBack: false),
      // FAB → CreateProductScreen
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CreateProductScreen()),
        ),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        children: [
          const ProductSearchBar(),
          const ProductFilterSection(),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(AppSpacing.lg),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.7,
              ),
              itemCount: danhSachSanPham.length,
              itemBuilder: (context, index) {
                final sanPham = danhSachSanPham[index];
                return AdminProductCard(
                  sanPham: sanPham,
                  onEdit: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditProductScreen(sanPham: sanPham),
                    ),
                  ),
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
