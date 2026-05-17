// features/user/product/widgets/product_image_slider.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';

class ProductImageSlider extends StatelessWidget {
  final List<String> danhSachAnh;

  const ProductImageSlider({super.key, required this.danhSachAnh});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 420,

      child: PageView.builder(
        itemCount: danhSachAnh.length,

        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),

            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),

              child: Image.network(danhSachAnh[index], fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}
