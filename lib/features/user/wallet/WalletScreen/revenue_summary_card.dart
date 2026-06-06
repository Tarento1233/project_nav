// features/user/wallet/revenue_summary_card.dart

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

    final isVang = user?.email == 'vanga@gmail.com';

    // 1. Tính Doanh thu ký gửi = Tổng tiền nhận từ các giao dịch bán ký gửi thành công
    final thuNhaps = store.giaoDichCuaToi
        .where((g) => g.loai == 'NHAN_TIEN_KY_GUI' && g.trangThai == 'THANH_CONG')
        .toList();
    double tongGiaTri = 0;
    for (var g in thuNhaps) {
      tongGiaTri += g.soTien;
    }

    // 2. Tính Hoa hồng shop = Theo logic đối soát đơn hàng hoàn thành ban đầu
    final completedOrderIds = store.danhSachDonHang
        .where((o) => o.trangThai == 'HOAN_THANH')
        .map((o) => o.id)
        .toSet();

    final completedOrderDetails = store.danhSachChiTietDonHang
        .where((d) => completedOrderIds.contains(d.donHangId))
        .toList();

    double tongHoaHong = 0;

    for (var k in store.danhSachKyGui) {
      final matchesUser = k.nguoiDungId == currentUserId || (isVang && k.nguoiDungId == 'USER01');
      if (matchesUser) {
        final soldDetails = completedOrderDetails.where((d) => d.sanPhamId == k.id).toList();
        if (soldDetails.isNotEmpty) {
          final int qty = soldDetails.fold(0, (sum, d) => sum + d.soLuong);
          tongHoaHong += (k.giaDuocDuyet * qty) * (k.phanTramHoaHong / 100);
        }
      }
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
      return amount.toVND();
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

