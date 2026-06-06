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

class ConsignmentManagementScreen extends StatefulWidget {
  const ConsignmentManagementScreen({super.key});

  @override
  State<ConsignmentManagementScreen> createState() => _ConsignmentManagementScreenState();
}

class _ConsignmentManagementScreenState extends State<ConsignmentManagementScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedStatus = 'Tất cả';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<StoreProvider>(context);
    
    // Admin duyệt các yêu cầu ký gửi (sản phẩm do user đăng kí gửi, nguoiBanId != SHOP_01)
    final danhSachSanPham = store.danhSachSanPham.where((p) {
      if (p.nguoiBanId == 'SHOP_01') return false;
      
      // 1. Search Query
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        final matchTen = p.ten.toLowerCase().contains(q);
        final matchId = p.id.toLowerCase().contains(q);
        if (!matchTen && !matchId) return false;
      }
      
      // 2. Status Filter
      if (_selectedStatus != 'Tất cả') {
        final String statusDbValue;
        switch (_selectedStatus) {
          case 'Chờ duyệt':
            statusDbValue = 'CHO_DUYET';
            break;
          case 'Đã duyệt':
            statusDbValue = 'DA_DUYET';
            break;
          case 'Đang bán':
            statusDbValue = 'DANG_BAN';
            break;
          case 'Từ chối':
            statusDbValue = 'BI_TU_CHOI';
            break;
          default:
            statusDbValue = _selectedStatus;
        }
        if (p.trangThai != statusDbValue) return false;
      }
      return true;
    }).toList()
      ..sort((a, b) => b.ngayTao.compareTo(a.ngayTao));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(tieuDe: 'Quản lý ký gửi', hienThiNutBack: false),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
            child: ConsignmentSearchBar(controller: _searchController),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
            child: ConsignmentFilterSection(
              selectedStatus: _selectedStatus,
              onStatusChanged: (status) {
                setState(() {
                  _selectedStatus = status;
                });
              },
            ),
          ),
          Expanded(
            child: danhSachSanPham.isEmpty
                ? const Center(
                    child: Text('Không tìm thấy yêu cầu ký gửi nào'),
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

