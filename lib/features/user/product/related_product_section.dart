// features/user/product/widgets/related_product_section.dart

import 'package:flutter/material.dart';

import '../../../../models/product_model.dart';

import '../../../../core/constants/mock_data.dart';

import '../../../../core/theme/app_spacing.dart';

import '../../../../core/widgets/cards/product_card.dart';
import '../../../../core/widgets/headers/section_header.dart';

class RelatedProductSection extends StatelessWidget {
  final SanPhamModel sanPham;

  const RelatedProductSection({super.key, required this.sanPham});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(
          tieuDe: 'Sản phẩm liên quan',

          nutText: 'Xem thêm',

          onPressed: () {},
        ),

        const SizedBox(height: AppSpacing.lg),

        SizedBox(
          height: 320,

          child: ListView.separated(
            scrollDirection: Axis.horizontal,

            itemCount: 4,

            separatorBuilder: (_, __) => const SizedBox(width: 16),

            itemBuilder: (context, index) {
              return SizedBox(
                width: 180,

                child: ProductCard(
                  sanPham: DuLieuMau.danhSachSanPham[index],

                  onTap: () {},
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
