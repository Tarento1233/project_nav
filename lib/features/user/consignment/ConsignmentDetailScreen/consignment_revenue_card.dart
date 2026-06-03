// features/user/consignment/consignment_revenue_card.dart

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

class ConsignmentRevenueCard extends StatelessWidget {
  final SanPhamModel sanPham;

  const ConsignmentRevenueCard({super.key, required this.sanPham});

  Widget thongTin({required String title, required String value, Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTypography.noiDung),
          Text(
            value,
            style: AppTypography.noiDung.copyWith(
              color: valueColor ?? AppColors.textPrimary,
              fontWeight: FontWeight.bold,
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

    double doanhThu = kyGui.giaDuocDuyet;
    if (kyGui.trangThai == 'CHO_DUYET') {
      doanhThu = kyGui.giaMongMuon;
    }

    final double phanTramUser = 100 - kyGui.phanTramHoaHong;
    final double banNhanDuoc = doanhThu * (phanTramUser / 100);

    String trangThaiThanhToan = 'Chưa thanh toán';
    Color textCol = AppColors.textSecondary;

    if (kyGui.trangThai == 'DA_BAN') {
      trangThaiThanhToan = 'Đã thanh toán (Ví online)';
      textCol = AppColors.success;
    } else if (kyGui.trangThai == 'DA_DUYET') {
      trangThaiThanhToan = 'Đang bán (Chờ mua)';
      textCol = AppColors.primaryDark;
    } else if (kyGui.trangThai == 'BI_TU_CHOI') {
      trangThaiThanhToan = 'Từ chối ký gửi';
      textCol = AppColors.error;
    } else if (kyGui.trangThai == 'CHO_DUYET') {
      trangThaiThanhToan = 'Chờ duyệt điều khoản';
      textCol = AppColors.warning;
    }

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
          Text('Doanh thu & thanh toán', style: AppTypography.tieuDeNho),
          const SizedBox(height: AppSpacing.lg),
          thongTin(title: 'Tổng giá trị hàng', value: '${doanhThu.toStringAsFixed(0)}đ'),
          if (kyGui.trangThai != 'CHO_DUYET') ...[
            thongTin(title: 'Bạn nhận được ($phanTramUser%)', value: '${banNhanDuoc.toStringAsFixed(0)}đ'),
            thongTin(title: 'Hoa hồng Shop (${kyGui.phanTramHoaHong.toStringAsFixed(0)}%)', value: '${(doanhThu * kyGui.phanTramHoaHong / 100).toStringAsFixed(0)}đ'),
          ],
          thongTin(
            title: 'Trạng thái thanh toán',
            value: trangThaiThanhToan,
            valueColor: textCol,
          ),
        ],
      ),
    );
  }
}

