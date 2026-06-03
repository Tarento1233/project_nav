// features/user/wallet/revenue_summary_card.dart

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
import '../../../../providers/store_provider.dart';

class RevenueSummaryCard extends StatelessWidget {
  const RevenueSummaryCard({super.key});

  Widget item({required String title, required String value}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          boxShadow: AppShadows.cardShadow,
        ),
        child: Column(
          children: [
            Text(
              value,
              style: AppTypography.gia.copyWith(fontSize: 16),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTypography.moTa.copyWith(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<StoreProvider>(context);
    final user = store.currentUser;
    final currentUserId = user?.id ?? '';

    // Lọc thỏa thuận ký gửi của user đã bán thành công
    final kyGuisDaBan = store.danhSachKyGui
        .where((k) => k.nguoiDungId == currentUserId && k.trangThai == 'DA_BAN')
        .toList();

    double tongGiaTri = 0;
    double tongHoaHong = 0;
    for (var k in kyGuisDaBan) {
      tongGiaTri += k.giaDuocDuyet;
      tongHoaHong += k.giaDuocDuyet * (k.phanTramHoaHong / 100);
    }

    // Tính tổng tiền đã rút thành công
    final rutTiens = store.giaoDichCuaToi
        .where((g) => g.loai == 'RUT_TIEN' && g.trangThai == 'THANH_CONG')
        .toList();
    double tongDaRut = 0;
    for (var g in rutTiens) {
      tongDaRut += g.soTien;
    }

    // Format rút gọn thành "k" hoặc "M"
    String formatMoney(double amount) {
      if (amount >= 1000000) {
        return '${(amount / 1000000).toStringAsFixed(1)}M';
      } else if (amount >= 1000) {
        return '${(amount / 1000).toStringAsFixed(0)}k';
      }
      return '${amount.toStringAsFixed(0)}đ';
    }

    return Row(
      children: [
        item(title: 'Doanh thu ký gửi', value: formatMoney(tongGiaTri)),
        const SizedBox(width: AppSpacing.sm),
        item(title: 'Hoa hồng shop', value: formatMoney(tongHoaHong)),
        const SizedBox(width: AppSpacing.sm),
        item(title: 'Đã rút thành công', value: formatMoney(tongDaRut)),
      ],
    );
  }
}

