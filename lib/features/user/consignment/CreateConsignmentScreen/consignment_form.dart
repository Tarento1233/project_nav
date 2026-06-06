// features/user/consignment/consignment_form.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';

import '../../../../core/constants/mock_data.dart';

class ConsignmentForm extends StatelessWidget {
  final TextEditingController tenController;
  final TextEditingController moTaController;
  final String selectedCategory;
  final ValueChanged<String?> onCategoryChanged;
  final TextEditingController? customCategoryController;
  final TextEditingController thuongHieuController;
  final List<String> selectedSizes;
  final ValueChanged<List<String>> onSizesChanged;
  final TextEditingController giaController;
  final TextEditingController soLuongController;

  const ConsignmentForm({
    super.key,
    required this.tenController,
    required this.moTaController,
    required this.selectedCategory,
    required this.onCategoryChanged,
    this.customCategoryController,
    required this.thuongHieuController,
    required this.selectedSizes,
    required this.onSizesChanged,
    required this.giaController,
    required this.soLuongController,
  });

  InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: AppColors.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sizeOptions = ['S', 'M', 'L', 'XL', 'XXL', 'Free Size', '38', '39', '40', '41', '42', '43'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: tenController,
          decoration: inputDecoration('Tên sản phẩm'),
        ),
        const SizedBox(height: AppSpacing.lg),
        TextField(
          controller: moTaController,
          maxLines: 4,
          decoration: inputDecoration('Mô tả sản phẩm'),
        ),
        const SizedBox(height: AppSpacing.lg),
        
        // Category Dropdown
        DropdownButtonFormField<String>(
          value: DuLieuMau.danhMuc.contains(selectedCategory) ? selectedCategory : 'Khác',
          decoration: inputDecoration('Danh mục'),
          items: DuLieuMau.danhMuc.map((cat) => DropdownMenuItem(
            value: cat,
            child: Text(cat),
          )).toList(),
          onChanged: onCategoryChanged,
        ),
        if (selectedCategory == 'Khác' || !DuLieuMau.danhMuc.contains(selectedCategory)) ...[
          const SizedBox(height: AppSpacing.lg),
          TextField(
            controller: customCategoryController,
            decoration: inputDecoration('Nhập danh mục khác'),
          ),
        ],
        const SizedBox(height: AppSpacing.lg),
        TextField(
          controller: thuongHieuController,
          decoration: inputDecoration('Thương hiệu (ví dụ: Nike, Gucci...)'),
        ),
        const SizedBox(height: AppSpacing.lg),

        // Size Selection Chips
        const Padding(
          padding: EdgeInsets.only(left: 4.0),
          child: Text('Kích thước (Chọn một hoặc nhiều)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textPrimary)),
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: sizeOptions.map((size) {
              final isSelected = selectedSizes.contains(size);
              return FilterChip(
                label: Text(size),
                selected: isSelected,
                selectedColor: AppColors.primary.withOpacity(0.25),
                checkmarkColor: AppColors.primary,
                labelStyle: TextStyle(
                  color: isSelected ? AppColors.primaryDark : AppColors.textPrimary,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                onSelected: (selected) {
                  final newSizes = List<String>.from(selectedSizes);
                  if (selected) {
                    newSizes.add(size);
                  } else {
                    newSizes.remove(size);
                  }
                  onSizesChanged(newSizes);
                },
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        
        // Desired Price
        TextField(
          controller: giaController,
          keyboardType: TextInputType.number,
          decoration: inputDecoration('Giá mong muốn'),
        ),
        const SizedBox(height: AppSpacing.lg),

        // Quantity (Số lượng)
        TextField(
          controller: soLuongController,
          keyboardType: TextInputType.number,
          decoration: inputDecoration('Số lượng ký gửi'),
        ),
      ],
    );
  }
}

