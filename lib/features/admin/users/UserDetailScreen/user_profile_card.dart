// features/admin/users/user_profile_card.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../models/user_model.dart';

class UserProfileCard extends StatelessWidget {
  final NguoiDungModel user;

  const UserProfileCard({super.key, required this.user});

  Widget thongTin({required String title, required String value, Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTypography.moTa),
          Text(
            value,
            style: AppTypography.noiDung.copyWith(color: valueColor),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateStr = '${user.ngayTao.day.toString().padLeft(2, '0')}/${user.ngayTao.month.toString().padLeft(2, '0')}/${user.ngayTao.year}';
    final biKhoa = user.trangThai == 'BLOCKED';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: AppShadows.cardShadow,
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 45,
            backgroundImage: NetworkImage(
              user.avatar.isNotEmpty ? user.avatar : 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde',
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(user.ten, style: AppTypography.tieuDe),
          const SizedBox(height: 4),
          Text(user.email, style: AppTypography.moTa),
          const SizedBox(height: AppSpacing.lg),
          thongTin(title: 'Role', value: user.vaiTro),
          thongTin(
            title: 'Trạng thái',
            value: user.trangThai,
            valueColor: biKhoa ? Colors.red : Colors.green,
          ),
          thongTin(
            title: 'Số điện thoại',
            value: user.soDienThoai.isNotEmpty ? user.soDienThoai : 'Chưa cập nhật',
          ),
          thongTin(title: 'Ngày tham gia', value: dateStr),
        ],
      ),
    );
  }
}
