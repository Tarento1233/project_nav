// features/user/home/widgets/featured_product_section.dart

import 'package:flutter/material.dart';

import '../../../../core/constants/mock_data.dart';

import '../../../../core/theme/app_spacing.dart';

import '../../../../core/widgets/cards/product_card.dart';
import '../../../../core/widgets/headers/section_header.dart';

class FeaturedProductSection extends StatelessWidget {
  const FeaturedProductSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),

      child: Column(
        children: [
          SectionHeader(
            tieuDe: 'Sản phẩm nổi bật',

            nutText: 'Xem thêm',

            onPressed: () {},
          ),

          const SizedBox(height: AppSpacing.lg),

          GridView.builder(
            shrinkWrap: true,

            physics: const NeverScrollableScrollPhysics(),

            itemCount: DuLieuMau.danhSachSanPham.length,

            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,

              crossAxisSpacing: 16,

              mainAxisSpacing: 16,

              childAspectRatio: 0.62,
            ),

            itemBuilder: (context, index) {
              return ProductCard(
                sanPham: DuLieuMau.danhSachSanPham[index],

                onTap: () {},
              );
            },
          ),

          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
