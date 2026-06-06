import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/product_model.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

import '../../../../core/widgets/headers/custom_app_bar.dart';
import '../../../../providers/store_provider.dart';
import '../EditConsignmentScreen/edit_consignment_screen.dart';

import 'consignment_product_info.dart';
import 'consignment_status_card.dart';
import 'consignment_term_detail.dart';
import 'consignment_revenue_card.dart';

class ConsignmentDetailScreen extends StatelessWidget {
  final SanPhamModel sanPham;

  const ConsignmentDetailScreen({super.key, required this.sanPham});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<StoreProvider>(context);
    final isOwner = store.currentUser != null && sanPham.nguoiBanId == store.currentUser!.id;

    // Lấy sản phẩm mới nhất từ store để tự động cập nhật UI khi quay lại từ màn hình chỉnh sửa
    final currentProduct = store.danhSachSanPham.firstWhere(
      (p) => p.id == sanPham.id,
      orElse: () => sanPham,
    );

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: CustomAppBar(
        tieuDe: 'Chi tiết ký gửi',
        actions: isOwner
            ? [
                IconButton(
                  icon: const Icon(Icons.edit_outlined, color: AppColors.textPrimary),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditConsignmentScreen(sanPham: currentProduct),
                    ),
                  ),
                ),
              ]
            : null,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),

        child: Column(
          children: [
            ConsignmentProductInfo(sanPham: currentProduct),
            const SizedBox(height: AppSpacing.xl),
            ConsignmentStatusCard(trangThai: currentProduct.trangThai),
            const SizedBox(height: AppSpacing.xl),
            ConsignmentTermDetail(sanPham: currentProduct),
            const SizedBox(height: AppSpacing.xl),
            ConsignmentRevenueCard(sanPham: currentProduct),
            const SizedBox(height: 100),
          ],
        ),

      ),
    );
  }
}
