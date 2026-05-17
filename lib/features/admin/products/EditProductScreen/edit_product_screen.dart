// features/admin/products/edit_product_screen.dart

import 'package:flutter/material.dart';

import '../../../../models/product_model.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

import '../../../../core/widgets/headers/custom_app_bar.dart';

import '../CreateProductScreen/product_image_upload.dart';
import 'edit_product_form.dart';
import '../CreateProductScreen/product_price_section.dart';
import '../CreateProductScreen/product_inventory_section.dart';
import 'update_product_button.dart';
import 'delete_product_button.dart';

class EditProductScreen extends StatelessWidget {
  final SanPhamModel sanPham;

  const EditProductScreen({super.key, required this.sanPham});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: const CustomAppBar(tieuDe: 'Chỉnh sửa sản phẩm'),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),

        child: Column(
          children: [
            const ProductImageUpload(),

            const SizedBox(height: AppSpacing.xl),

            EditProductForm(sanPham: sanPham),

            const SizedBox(height: AppSpacing.xl),

            const ProductPriceSection(),

            const SizedBox(height: AppSpacing.xl),

            const ProductInventorySection(),

            const SizedBox(height: AppSpacing.xl),

            const UpdateProductButton(),

            const SizedBox(height: AppSpacing.lg),

            const DeleteProductButton(),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
