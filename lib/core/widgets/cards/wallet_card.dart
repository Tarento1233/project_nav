import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';
import '../../theme/app_shadows.dart';

class WalletCard extends StatelessWidget {
  final double soDu;

  final double soDuDangCho;

  final double soDuCoTheRut;

  const WalletCard({
    super.key,
    required this.soDu,
    required this.soDuDangCho,
    required this.soDuCoTheRut,
  });

  String dinhDangTien(double soTien) {
    return '${soTien.toStringAsFixed(0)}đ';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(AppSpacing.xl),

      decoration: BoxDecoration(
        color: AppColors.primary,

        borderRadius: BorderRadius.circular(AppRadius.lg),

        boxShadow: AppShadows.cardShadow,
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    'Ví của tôi',

                    style: AppTypography.noiDung.copyWith(
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.sm),

                  Text(
                    dinhDangTien(soDu),

                    style: AppTypography.tieuDeLon.copyWith(
                      color: Colors.white,

                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),

              Container(
                padding: const EdgeInsets.all(AppSpacing.md),

                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),

                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),

                child: const Icon(
                  Icons.account_balance_wallet_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.xl),

          Row(
            children: [
              Expanded(
                child: thongTinSoDu(
                  tieuDe: 'Đang chờ',

                  giaTri: dinhDangTien(soDuDangCho),
                ),
              ),

              const SizedBox(width: AppSpacing.lg),

              Expanded(
                child: thongTinSoDu(
                  tieuDe: 'Có thể rút',

                  giaTri: dinhDangTien(soDuCoTheRut),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget thongTinSoDu({required String tieuDe, required String giaTri}) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),

      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),

        borderRadius: BorderRadius.circular(AppRadius.md),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            tieuDe,

            style: AppTypography.moTa.copyWith(color: Colors.white70),
          ),

          const SizedBox(height: AppSpacing.sm),

          Text(
            giaTri,

            style: AppTypography.noiDung.copyWith(
              color: Colors.white,

              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
