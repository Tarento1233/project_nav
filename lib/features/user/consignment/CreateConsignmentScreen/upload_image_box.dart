// features/user/consignment/upload_image_box.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/services/firebase_service.dart';

class UploadImageBox extends StatefulWidget {
  final String? selectedImageUrl;
  final ValueChanged<String> onImageSelected;

  const UploadImageBox({
    super.key,
    required this.selectedImageUrl,
    required this.onImageSelected,
  });

  @override
  State<UploadImageBox> createState() => _UploadImageBoxState();
}

class _UploadImageBoxState extends State<UploadImageBox> {
  bool _isUploading = false;

  Future<void> _pickAndUploadImage() async {
    final picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80, // Tối ưu kích thước ảnh trước khi gửi
      );
      
      if (image == null) return;

      if (!mounted) return;
      setState(() {
        _isUploading = true;
      });

      // Hiển thị thông báo bắt đầu upload
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đang tải ảnh lên ImgBB, vui lòng đợi...'),
          duration: Duration(seconds: 2),
        ),
      );

      final url = await FirebaseService.instance.uploadImage(File(image.path));
      
      if (!mounted) return;
      widget.onImageSelected(url);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tải ảnh thành công!'),
          backgroundColor: AppColors.success,
        ),
      );
    } catch (e) {
      print('Lỗi chọn/tải ảnh: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lỗi tải ảnh: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  void _showImagePicker(BuildContext context) {
    // Danh sách các ảnh thời trang Unsplash mẫu đẹp mắt để chọn lựa làm fallback
    final fashionImages = [
      {
        'name': 'Áo Blazer Cao Cấp',
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
                'Chọn nguồn ảnh',
                style: AppTypography.tieuDe.copyWith(fontSize: 18),
              ),
              const SizedBox(height: AppSpacing.md),
              
              // Tùy chọn 1: Chọn ảnh từ máy
              ListTile(
                leading: const Icon(Icons.photo_library_outlined, color: AppColors.primary),
                title: const Text('Chọn ảnh từ Thư viện máy'),
                onTap: () {
                  Navigator.pop(context);
                  _pickAndUploadImage();
                },
              ),
              const Divider(),
              
              const SizedBox(height: AppSpacing.sm),
              const Text(
                'Hoặc chọn nhanh từ sản phẩm mẫu:',
                style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: AppSpacing.md),
              
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
                        widget.onImageSelected(img['url']!);
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
    final hasImage = widget.selectedImageUrl != null && widget.selectedImageUrl!.isNotEmpty;

    return GestureDetector(
      onTap: _isUploading ? null : () => _showImagePicker(context),
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
        child: _isUploading
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: AppColors.primary),
                    SizedBox(height: AppSpacing.md),
                    Text('Đang upload ảnh...', style: TextStyle(color: AppColors.textSecondary)),
                  ],
                ),
              )
            : hasImage
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.lg - 1),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          widget.selectedImageUrl!,
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
                        'Nhấn để chọn ảnh từ máy hoặc mẫu',
                        style: AppTypography.moTa.copyWith(color: AppColors.primary),
                      ),
                    ],
                  ),
      ),
    );
  }
}

