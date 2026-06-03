// features/user/wallet/wallet_balance_card.dart

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

class WalletBalanceCard extends StatelessWidget {
  const WalletBalanceCard({super.key});

  Widget thongTin({required String tieuDe, required String giaTri}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(tieuDe, style: AppTypography.moTa.copyWith(color: Colors.white70)),
        const SizedBox(height: 4),
        Text(
          giaTri,
          style: AppTypography.noiDung.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<StoreProvider>(context);
    final wallet = store.viCuaToi;

    final soDuInt = wallet?.soDuCoTheRut ?? 0;
    
    // Tính tổng thu nhập nhận được từ ký gửi
    final thuNhaps = store.giaoDichCuaToi
        .where((g) => g.loai == 'NHAN_TIEN_KY_GUI' && g.trangThai == 'THANH_CONG')
        .toList();
    double tongNhan = 0;
    for (var g in thuNhaps) {
      tongNhan += g.soTien;
    }

    // Tính tổng tiền rút thành công
    final rutTiens = store.giaoDichCuaToi
        .where((g) => g.loai == 'RUT_TIEN' && g.trangThai == 'THANH_CONG')
        .toList();
    double tongRut = 0;
    for (var g in rutTiens) {
      tongRut += g.soTien;
    }

    String formatMoney(double amount) {
      if (amount >= 1000000) {
        return '${(amount / 1000000).toStringAsFixed(1)} triệu';
      }
      return '${amount.toStringAsFixed(0)}đ';
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.primaryDark, // Sử dụng màu xanh đậm để trông cao cấp hơn
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: AppShadows.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Số dư khả dụng để rút',
            style: AppTypography.noiDung.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            '${soDuInt.toStringAsFixed(0)}đ',
            style: AppTypography.gia.copyWith(
              color: Colors.white,
              fontSize: 32,
            ),
          ),
          if ((wallet?.soDuDangCho ?? 0) > 0) ...[
            const SizedBox(height: 8),
            Text(
              'Đang chờ xử lý: ${wallet!.soDuDangCho.toStringAsFixed(0)}đ',
              style: AppTypography.moTa.copyWith(color: Colors.white60),
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              thongTin(tieuDe: 'Đã nhận', giaTri: formatMoney(tongNhan)),
              thongTin(tieuDe: 'Đã rút thành công', giaTri: formatMoney(tongRut)),
            ],
          ),
        ],
      ),
    );
  }
}

