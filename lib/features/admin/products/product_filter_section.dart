// features/admin/products/product_filter_section.dart

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

import '../../../core/constants/mock_data.dart';

class ProductFilterSection extends StatelessWidget {
  final String selectedCategory;
  final String selectedBrand;
  final String selectedStatus;
  final ValueChanged<String> onCategoryChanged;
  final ValueChanged<String> onBrandChanged;
  final ValueChanged<String> onStatusChanged;

  const ProductFilterSection({
    super.key,
    required this.selectedCategory,
    required this.selectedBrand,
    required this.selectedStatus,
    required this.onCategoryChanged,
    required this.onBrandChanged,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: filterButton(
            title: 'Danh mục',
            currentVal: selectedCategory,
            options: ['Tất cả', ...DuLieuMau.danhMuc],
            onChanged: onCategoryChanged,
          ),
        ),

        const SizedBox(width: AppSpacing.md),

        Expanded(
          child: filterButton(
            title: 'Brand',
            currentVal: selectedBrand,
            options: ['Tất cả', ...DuLieuMau.thuongHieu],
            onChanged: onBrandChanged,
          ),
        ),

        const SizedBox(width: AppSpacing.md),

        Expanded(
          child: filterButton(
            title: 'Trạng thái',
            currentVal: selectedStatus,
            options: ['Tất cả', 'Đang bán', 'Chờ duyệt', 'Bị từ chối', 'Đã bán'],
            onChanged: onStatusChanged,
          ),
        ),
      ],
    );
  }

  Widget filterButton({
    required String title,
    required String currentVal,
    required List<String> options,
    required ValueChanged<String> onChanged,
  }) {
    return PopupMenuButton<String>(
      initialValue: currentVal,
      onSelected: onChanged,
      itemBuilder: (context) => options
          .map((opt) => PopupMenuItem<String>(
                value: opt,
                child: Text(opt),
              ))
          .toList(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),

        decoration: BoxDecoration(
          color: AppColors.surface,

          borderRadius: BorderRadius.circular(12),

          border: Border.all(color: AppColors.border),
        ),

        child: Center(
          child: Text(
            currentVal == 'Tất cả' ? title : currentVal,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
