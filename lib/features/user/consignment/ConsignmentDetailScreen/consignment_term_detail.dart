// features/user/consignment/consignment_term_detail.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../models/product_model.dart';
import '../../../../providers/store_provider.dart';

class ConsignmentTermDetail extends StatelessWidget {
  final SanPhamModel sanPham;

  const ConsignmentTermDetail({super.key, required this.sanPham});

  Widget thongTin({required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTypography.noiDung),
          Text(
            value,
            style: AppTypography.noiDung.copyWith(
              color: AppColors.primaryDark,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<StoreProvider>(context);
    final kyGui = store.danhSachKyGui.firstWhere(
      (k) => k.id == sanPham.id,
      orElse: () => store.danhSachKyGui.first,
    );

    final showPrice = kyGui.trangThai == 'CHO_DUYET' ? kyGui.giaMongMuon : kyGui.giaDuocDuyet;
    final comStr = kyGui.trangThai == 'CHO_DUYET' ? 'Chờ Admin duyệt' : '${kyGui.phanTramHoaHong.toStringAsFixed(0)}%';
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: AppShadows.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Điều khoản ký gửi', style: AppTypography.tieuDeNho),
          const SizedBox(height: AppSpacing.lg),
          thongTin(title: 'Giá mong muốn', value: '${kyGui.giaMongMuon.toStringAsFixed(0)}đ'),
          if (kyGui.trangThai != 'CHO_DUYET')
            thongTin(title: 'Giá được duyệt', value: '${kyGui.giaDuocDuyet.toStringAsFixed(0)}đ'),
          thongTin(title: 'Tỷ lệ hoa hồng', value: comStr),
          thongTin(title: 'Thời gian ký gửi', value: '30 ngày'),
        ],
      ),
    );
  }
}

