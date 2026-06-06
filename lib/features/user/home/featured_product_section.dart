// features/user/home/featured_product_section.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/mock_data.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/cards/product_card.dart';
import '../../../core/widgets/headers/section_header.dart';
import '../../../models/product_model.dart';
import '../../../providers/store_provider.dart';

class FeaturedProductSection extends StatelessWidget {
  final void Function(SanPhamModel sanPham)? onSanPhamTap;
  final String selectedCategory;
  final String searchQuery;

  const FeaturedProductSection({
    super.key,
    this.onSanPhamTap,
    required this.selectedCategory,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Consumer<StoreProvider>(
        builder: (context, store, child) {
          final activeProducts = store.danhSachSanPham
              .where((p) => p.trangThai == 'DANG_BAN')
              .where((p) {
                if (selectedCategory != 'Tất cả') {
                  if (selectedCategory == 'Khác') {
                    final standardCategories = List<String>.from(DuLieuMau.danhMuc)..remove('Khác');
                    if (standardCategories.contains(p.danhMucId)) {
                      return false;
                    }
                  } else if (p.danhMucId != selectedCategory) {
                    return false;
                  }
                }
                if (searchQuery.isNotEmpty) {
                  final q = searchQuery.toLowerCase();
                  final matchTen = p.ten.toLowerCase().contains(q);
                  final matchMoTa = p.moTa.toLowerCase().contains(q);
                  if (!matchTen && !matchMoTa) return false;
                }
                return true;
              })
              .toList();

          // Sắp xếp ưu tiên các sản phẩm nổi bật (noiBat == true) lên đầu danh sách hiển thị
          activeProducts.sort((a, b) {
            if (a.noiBat && !b.noiBat) return -1;
            if (!a.noiBat && b.noiBat) return 1;
            return 0;
          });

          if (activeProducts.isEmpty) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 30.0),
              child: Center(
                child: Text('Không tìm thấy sản phẩm phù hợp'),
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
                  childAspectRatio: 0.6,
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
