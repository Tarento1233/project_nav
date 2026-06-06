// features/user/product/widgets/size_selector.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class SizeSelector extends StatelessWidget {
  final List<String> sizes;
  final String selectedSize;
  final ValueChanged<String> onSelected;

  const SizeSelector({
    super.key,
    required this.sizes,
    required this.selectedSize,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (sizes.isEmpty) return const SizedBox.shrink();

    // Dự phòng phòng trường hợp selectedSize không khớp với danh sách sizes
    final value = sizes.contains(selectedSize) ? selectedSize : sizes.first;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Kích thước', style: AppTypography.tieuDeNho),
        const SizedBox(height: AppSpacing.md),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textPrimary),
              style: AppTypography.noiDung.copyWith(color: AppColors.textPrimary),
              dropdownColor: AppColors.surface,
              borderRadius: BorderRadius.circular(14),
              items: sizes.map((String size) {
                return DropdownMenuItem<String>(
                  value: size,
                  child: Text('Size: $size', style: const TextStyle(fontWeight: FontWeight.w500)),
                );
              }).toList(),
              onChanged: (newValue) {
                if (newValue != null) {
                  onSelected(newValue);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
