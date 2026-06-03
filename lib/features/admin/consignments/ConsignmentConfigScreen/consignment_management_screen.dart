// features/admin/consignments/ConsignmentConfigScreen/consignment_management_screen.dart

import 'package:flutter/material.dart';

import '../../../../core/constants/mock_data.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/headers/custom_app_bar.dart';
import '../AdminConsignmentDetailScreen/admin_consignment_detail_screen.dart';

import 'admin_consignment_card.dart';
import 'consignment_search_bar.dart';
import 'consignment_filter_section.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/headers/custom_app_bar.dart';
import '../../../../providers/store_provider.dart';
import '../AdminConsignmentDetailScreen/admin_consignment_detail_screen.dart';

import 'admin_consignment_card.dart';
import 'consignment_search_bar.dart';
import 'consignment_filter_section.dart';

class ConsignmentManagementScreen extends StatelessWidget {
  const ConsignmentManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<StoreProvider>(context);
    
    // Admin duyệt các yêu cầu đang chờ duyệt (CHO_DUYET) hoặc có thể hiện tất cả ký gửi
    final danhSachSanPham = store.danhSachSanPham.where((p) => p.trangThai == 'CHO_DUYET').toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(tieuDe: 'Quản lý ký gửi', hienThiNutBack: false),
      body: Column(
        children: [
          const ConsignmentSearchBar(),
          const ConsignmentFilterSection(),
          Expanded(
            child: danhSachSanPham.isEmpty
                ? const Center(
                    child: Text('Không có yêu cầu ký gửi nào cần duyệt'),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    itemCount: danhSachSanPham.length,
                    separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.lg),
                    itemBuilder: (context, index) {
                      final sanPham = danhSachSanPham[index];
                      return AdminConsignmentCard(
                        sanPham: sanPham,
                        onDetail: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AdminConsignmentDetailScreen(sanPham: sanPham),
                          ),
                        ),
                        onApprove: () {
                          // Xem chi tiết để duyệt với giá và tỷ lệ hoa hồng
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AdminConsignmentDetailScreen(sanPham: sanPham),
                            ),
                          );
                        },
                        onReject: () {
                          // Xem chi tiết để từ chối và ghi lý do
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AdminConsignmentDetailScreen(sanPham: sanPham),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

