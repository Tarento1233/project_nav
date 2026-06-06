// features/admin/users/user_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/headers/custom_app_bar.dart';
import '../../../../models/user_model.dart';
import '../../../../providers/store_provider.dart';

import 'user_profile_card.dart';
import 'user_statistics_card.dart';
import 'user_activity_section.dart';
import 'user_management_action.dart';

class UserDetailScreen extends StatelessWidget {
  final NguoiDungModel user;

  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<StoreProvider>(context);
    
    // Tìm kiếm thông tin người dùng mới nhất từ store để tự động cập nhật UI khi thay đổi role hoặc block status
    final activeUser = store.danhSachNguoiDung.firstWhere(
      (u) => u.id == user.id,
      orElse: () => user,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(tieuDe: 'Chi tiết người dùng'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            UserProfileCard(user: activeUser),
            const SizedBox(height: AppSpacing.xl),
            UserStatisticsCard(user: activeUser),
            const SizedBox(height: AppSpacing.xl),
            UserActivitySection(user: activeUser),
            const SizedBox(height: AppSpacing.xl),
            UserManagementAction(user: activeUser),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
