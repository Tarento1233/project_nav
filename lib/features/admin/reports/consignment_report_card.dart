import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../providers/store_provider.dart';

class ConsignmentReportCard extends StatelessWidget {
  const ConsignmentReportCard({super.key});

  Widget thongTin({required String title, required String value, Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text(title, style: AppTypography.noiDung),

          Text(
            value,

            style: AppTypography.noiDung.copyWith(
              color: color ?? AppColors.primary,

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
    final listKyGui = store.danhSachKyGui;

    final pending = listKyGui.where((k) => k.trangThai == 'CHO_DUYET').length;
    final active = listKyGui.where((k) => k.trangThai == 'DA_DUYET').length;
    final sold = listKyGui.where((k) => k.trangThai == 'DA_BAN').length;
    final rejected = listKyGui.where((k) => k.trangThai == 'BI_TU_CHOI').length;

    final soldList = listKyGui.where((k) => k.trangThai == 'DA_BAN').toList();

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
          Text('Báo cáo ký gửi & Hoa hồng', style: AppTypography.tieuDeNho),

          const SizedBox(height: AppSpacing.lg),

          thongTin(title: 'Ký gửi chờ duyệt', value: '$pending'),

          thongTin(title: 'Ký gửi đang bán (Active)', value: '$active', color: Colors.blue),

          thongTin(title: 'Ký gửi đã bán thành công', value: '$sold', color: Colors.green),

          thongTin(title: 'Ký gửi bị từ chối', value: '$rejected', color: Colors.red),

          const Divider(height: AppSpacing.lg),

          thongTin(
            title: 'Tổng hoa hồng thu được',
            value: store.adminTotalCommissionEarned.toVND(),
            color: Colors.orange,
          ),

          const SizedBox(height: AppSpacing.lg),

          Text(
            'Lịch sử phân chia tiền ký gửi:',
            style: AppTypography.noiDung.copyWith(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: AppSpacing.md),

          if (soldList.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'Chưa có sản phẩm ký gửi nào được bán thành công.',
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 13),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: soldList.length,
              separatorBuilder: (_, __) => const Divider(height: 12),
              itemBuilder: (context, index) {
                final k = soldList[index];
                
                // Lấy số lượng đã bán thực tế trong các đơn hàng hoàn tất
                final completedOrderIds = store.danhSachDonHang
                    .where((o) => o.trangThai == 'HOAN_THANH')
                    .map((o) => o.id)
                    .toSet();
                final details = store.danhSachChiTietDonHang
                    .where((d) => d.sanPhamId == k.id && completedOrderIds.contains(d.donHangId))
                    .toList();
                int totalQuantitySold = 0;
                for (var d in details) {
                  totalQuantitySold += d.soLuong;
                }
                if (totalQuantitySold == 0) {
                  totalQuantitySold = 1;
                }

                final totalSales = k.giaDuocDuyet * totalQuantitySold;
                final commission = totalSales * (k.phanTramHoaHong / 100);
                final consignorPayout = totalSales - commission;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      k.tenSanPham,
                      style: AppTypography.noiDung.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            totalQuantitySold > 1 
                                ? 'Giá bán: ${k.giaDuocDuyet.toVND()} x$totalQuantitySold'
                                : 'Giá bán: ${k.giaDuocDuyet.toVND()}', 
                            style: AppTypography.moTa,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Text('Mức hoa hồng: ${k.phanTramHoaHong.toStringAsFixed(0)}%', style: AppTypography.moTa),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Shop thu (+): ${commission.toVND()}',
                            style: AppTypography.moTa.copyWith(color: Colors.orange, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            'Trả ví khách (+): ${consignorPayout.toVND()}',
                            textAlign: TextAlign.end,
                            style: AppTypography.moTa.copyWith(color: Colors.green, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }
}
