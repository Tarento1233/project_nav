// features/user/home/featured_product_section.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/cards/product_card.dart';
import '../../../core/widgets/headers/section_header.dart';
import '../../../models/product_model.dart';
import '../../../providers/store_provider.dart';

class FeaturedProductSection extends StatelessWidget {
  final void Function(SanPhamModel sanPham)? onSanPhamTap;

  const FeaturedProductSection({super.key, this.onSanPhamTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Consumer<StoreProvider>(
        builder: (context, store, child) {
          final activeProducts = store.danhSachSanPham
              .where((p) => p.trangThai == 'DANG_BAN')
              .toList();

          if (activeProducts.isEmpty) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 30.0),
              child: Center(
                child: Text('Không có sản phẩm nào đang bán'),
              ),
            );
          }

          return Column(
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
                itemCount: activeProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.62,
                ),
                itemBuilder: (context, index) {
                  final sanPham = activeProducts[index];
                  return ProductCard(
                    sanPham: sanPham,
                    onTap: () => onSanPhamTap?.call(sanPham),
                  );
                },
              ),
              const SizedBox(height: 100),
            ],
          );
        },
      ),
    );
  }
}
