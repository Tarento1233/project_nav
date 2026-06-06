// features/admin/users/UserManagementScreen/user_management_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/widgets/headers/custom_app_bar.dart';
import '../../../../providers/store_provider.dart';
import '../UserDetailScreen/user_detail_screen.dart';
import 'admin_user_card.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  String _searchQuery = '';
  String _selectedFilter = 'Tất cả';

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<StoreProvider>(context);

    // Lọc danh sách người dùng theo ô tìm kiếm và bộ lọc
    final dynamicUsersList = store.danhSachNguoiDung.where((u) {
      final matchesSearch = u.ten.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          u.email.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          u.soDienThoai.contains(_searchQuery);

      if (_selectedFilter == 'Tất cả') {
        return matchesSearch;
      } else if (_selectedFilter == 'BLOCKED') {
        return matchesSearch && u.trangThai == 'BLOCKED';
      } else {
        return matchesSearch && u.vaiTro == _selectedFilter && u.trangThai != 'BLOCKED';
      }
    }).toList();

    final filterOptions = ['Tất cả', 'USER', 'ADMIN', 'BLOCKED'];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(
        tieuDe: 'Quản lý người dùng',
        hienThiNutBack: true, // Hiển thị nút back để quay lại Dashboard/Reports
      ),
      body: Column(
        children: [
          // Thanh tìm kiếm
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Tìm kiếm theo tên, email, sđt...',
                prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: AppSpacing.md),
              ),
            ),
          ),

          // Bộ lọc dạng cuộn ngang
          SizedBox(
            height: 45,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              itemCount: filterOptions.length,
              separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
              itemBuilder: (context, index) {
                final currentFilter = filterOptions[index];
                final isSelected = _selectedFilter == currentFilter;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedFilter = currentFilter;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : AppColors.surface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isSelected ? AppColors.primary : AppColors.border,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        currentFilter,
                        style: TextStyle(
                          color: isSelected ? Colors.white : AppColors.textPrimary,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // Danh sách người dùng
          Expanded(
            child: dynamicUsersList.isEmpty
                ? const Center(
                    child: Text('Không tìm thấy người dùng phù hợp'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    itemCount: dynamicUsersList.length,
                    itemBuilder: (context, index) {
                      final user = dynamicUsersList[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                        child: AdminUserCard(
                          tenNguoiDung: user.ten,
                          email: user.email,
                          role: user.vaiTro,
                          trangThai: user.trangThai,
                          onDetail: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => UserDetailScreen(user: user),
                            ),
                          ),
                          onAction: () async {
                            final storeProv = Provider.of<StoreProvider>(context, listen: false);
                            await storeProv.toggleUserBlockStatus(user.id, user.trangThai);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  user.trangThai == 'BLOCKED'
                                      ? 'Đã mở khóa tài khoản ${user.ten}'
                                      : 'Đã khóa tài khoản ${user.ten}',
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
