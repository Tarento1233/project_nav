// features/user/consignment/MyConsignmentScreen/my_consignment_screen.dart

import 'package:flutter/material.dart';

import '../../../../core/constants/mock_data.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/headers/custom_app_bar.dart';
import '../ConsignmentDetailScreen/consignment_detail_screen.dart';
import '../CreateConsignmentScreen/create_consignment_screen.dart';

import 'consignment_card.dart';
import 'consignment_status_tab.dart';
import 'create_consignment_button.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/headers/custom_app_bar.dart';
import '../../../../providers/store_provider.dart';
import '../ConsignmentDetailScreen/consignment_detail_screen.dart';
import '../CreateConsignmentScreen/create_consignment_screen.dart';

import 'consignment_card.dart';
import 'consignment_status_tab.dart';

class MyConsignmentScreen extends StatefulWidget {
  const MyConsignmentScreen({super.key});

  @override
  State<MyConsignmentScreen> createState() => _MyConsignmentScreenState();
}

class _MyConsignmentScreenState extends State<MyConsignmentScreen> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<StoreProvider>(context);
    final currentUserId = store.currentUser?.id ?? 'USER01';
    
    // Lấy tất cả sản phẩm của user hiện tại
    final tatCaKyGui = store.danhSachSanPham.where((p) => p.nguoiBanId == currentUserId).toList();
    
    // Lọc theo tab
    final danhSachSanPham = tatCaKyGui.where((p) {
      if (_tabIndex == 0) return true; // Tất cả
      if (_tabIndex == 1) return p.trangThai == 'CHO_DUYET';
      if (_tabIndex == 2) return p.trangThai == 'DANG_BAN' || p.trangThai == 'DA_DUYET';
      if (_tabIndex == 3) return p.trangThai == 'DA_BAN';
      if (_tabIndex == 4) return p.trangThai == 'BI_TU_CHOI';
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(tieuDe: 'Sản phẩm ký gửi', hienThiNutBack: false),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CreateConsignmentScreen()),
        ),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        children: [
          ConsignmentStatusTab(
            selectedIndex: _tabIndex,
            onTabSelected: (index) {
              setState(() {
                _tabIndex = index;
              });
            },
          ),
          Expanded(
            child: danhSachSanPham.isEmpty
                ? const Center(
                    child: Text('Không có sản phẩm nào trong mục này'),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    itemCount: danhSachSanPham.length,
                    separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.lg),
                    itemBuilder: (context, index) {
                      final sanPham = danhSachSanPham[index];
                      return ConsignmentCard(
                        sanPham: sanPham,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ConsignmentDetailScreen(sanPham: sanPham),
                          ),
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

