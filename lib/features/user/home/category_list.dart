// features/user/home/widgets/category_list.dart

import 'package:flutter/material.dart';

import '../../../../core/constants/mock_data.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

import '../../../../core/widgets/headers/section_header.dart';

class CategoryList extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const CategoryList({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final categories = ['Tất cả', ...DuLieuMau.danhMuc];

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          SectionHeader(
            tieuDe: 'Danh mục',
            nutText: 'Xem thêm',
            onPressed: () {},
          ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            height: 50,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final category = categories[index];
                final dangChon = category == selectedCategory;

                return GestureDetector(
                  onTap: () => onCategorySelected(category),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: dangChon ? AppColors.primary : AppColors.surface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Center(
                      child: Text(
                        category,
                        style: TextStyle(
                          color: dangChon ? Colors.white : AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
