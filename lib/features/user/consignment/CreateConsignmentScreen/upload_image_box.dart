// features/user/consignment/upload_image_box.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class UploadImageBox extends StatelessWidget {
  final String? selectedImageUrl;
  final ValueChanged<String> onImageSelected;

  const UploadImageBox({
    super.key,
    required this.selectedImageUrl,
    required this.onImageSelected,
  });

  void _showImagePicker(BuildContext context) {
    // Danh sách các ảnh thời trang Unsplash mẫu đẹp mắt để chọn lựa
    final fashionImages = [
      {
        'name': 'Áo Blazer Blazer Cao Cấp',
        'url': 'https://images.unsplash.com/photo-1591047139829-d91aecb6caea'
      },
      {
        'name': 'Váy Dạ Hội Đỏ Zara',
        'url': 'https://images.unsplash.com/photo-1595777457583-95e059d581b8'
      },
      {
        'name': 'Túi Xách Nữ Gucci Gold',
        'url': 'https://images.unsplash.com/photo-1584917865442-de89df76afd3'
      },
      {
        'name': 'Giày Sneaker Nike Red',
        'url': 'https://images.unsplash.com/photo-1542291026-7eec264c27ff'
      },
    ];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Chọn ảnh minh họa ký gửi',
                style: AppTypography.tieuDe.copyWith(fontSize: 18),
              ),
              const SizedBox(height: AppSpacing.md),
              const Text(
                'Nhấn vào một sản phẩm thời trang mẫu để tải ảnh lên:',
                style: TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: AppSpacing.lg),
              SizedBox(
                height: 120,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: fashionImages.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final img = fashionImages[index];
                    return GestureDetector(
                      onTap: () {
                        onImageSelected(img['url']!);
                        Navigator.pop(context);
                      },
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              img['url']!,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 6),
                          SizedBox(
                            width: 80,
                            child: Text(
                              img['name']!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 10),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasImage = selectedImageUrl != null && selectedImageUrl!.isNotEmpty;

    return GestureDetector(
      onTap: () => _showImagePicker(context),
      child: Container(
        width: double.infinity,
        height: 180,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(
            color: hasImage ? AppColors.primary : AppColors.border,
            width: hasImage ? 2.0 : 1.0,
          ),
        ),
        child: hasImage
            ? ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.lg - 1),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      selectedImageUrl!,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      color: Colors.black26,
                      child: const Center(
                        child: Icon(
                          Icons.cached_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.cloud_upload_outlined,
                    size: 50,
                    color: AppColors.primary,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text('Tải ảnh sản phẩm', style: AppTypography.tieuDeNho),
                  const SizedBox(height: 4),
                  Text(
                    'Nhấn để chọn ảnh mẫu thời trang',
                    style: AppTypography.moTa.copyWith(color: AppColors.primary),
                  ),
                ],
              ),
      ),
    );
  }
}

