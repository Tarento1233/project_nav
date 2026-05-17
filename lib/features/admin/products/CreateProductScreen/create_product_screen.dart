// features/admin/products/create_product_screen.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

import '../../../../core/widgets/headers/custom_app_bar.dart';

import 'product_image_upload.dart';
import 'product_form_section.dart';
import 'product_price_section.dart';
import 'product_inventory_section.dart';
import 'create_product_button.dart';

class CreateProductScreen extends StatelessWidget {
  const CreateProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: const CustomAppBar(tieuDe: 'Tạo sản phẩm'),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),

        child: Column(
          children: [
            const ProductImageUpload(),

            const SizedBox(height: AppSpacing.xl),

            const ProductFormSection(),

            const SizedBox(height: AppSpacing.xl),

            const ProductPriceSection(),

            const SizedBox(height: AppSpacing.xl),

            const ProductInventorySection(),

            const SizedBox(height: AppSpacing.xl),

            const CreateProductButton(),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
