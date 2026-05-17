// features/admin/users/user_detail_screen.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

import '../../../../core/widgets/headers/custom_app_bar.dart';

import 'user_profile_card.dart';
import 'user_statistics_card.dart';
import 'user_activity_section.dart';
import 'user_management_action.dart';

class UserDetailScreen extends StatelessWidget {
  const UserDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: const CustomAppBar(tieuDe: 'Chi tiết người dùng'),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),

        child: Column(
          children: [
            const UserProfileCard(),

            const SizedBox(height: AppSpacing.xl),

            const UserStatisticsCard(),

            const SizedBox(height: AppSpacing.xl),

            const UserActivitySection(),

            const SizedBox(height: AppSpacing.xl),

            const UserManagementAction(),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
