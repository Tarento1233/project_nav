// features/user/order/shipping_info_card.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/order_model.dart';
import '../../../../models/address_model.dart';
import '../../../../models/user_model.dart';
import '../../../../providers/store_provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class ShippingInfoCard extends StatelessWidget {
  final DonHangModel donHang;

  const ShippingInfoCard({super.key, required this.donHang});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<StoreProvider>(context);
    final user = store.danhSachNguoiDung.firstWhere(
      (u) => u.id == donHang.nguoiDungId,
      orElse: () => NguoiDungModel(
        id: donHang.nguoiDungId,
        ten: 'Khách hàng ẩn danh',
        email: '',
        soDienThoai: '',
        avatar: '',
        vaiTro: 'USER',
        ngayTao: DateTime.now(),
      ),
    );

    final address = store.danhSachDiaChi.firstWhere(
      (d) => d.id == donHang.diaChiId,
      orElse: () => DiaChiModel(
        id: donHang.diaChiId,
        nguoiDungId: donHang.nguoiDungId,
        tenNguoiNhan: user.ten,
        soDienThoai: user.soDienThoai.isEmpty ? '0123456789' : user.soDienThoai,
        tinhThanh: 'TP.HCM',
        quanHuyen: '',
        phuongXa: '',
        diaChiChiTiet: 'Địa chỉ',
        macDinh: false,
      ),
    );

    final addressString = '${address.diaChiChiTiet}, ${address.phuongXa.isNotEmpty ? address.phuongXa + ", " : ""}${address.quanHuyen.isNotEmpty ? address.quanHuyen + ", " : ""}${address.tinhThanh}';

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: AppShadows.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Thông tin giao hàng', style: AppTypography.tieuDeNho),
          const SizedBox(height: AppSpacing.lg),
          Text(address.tenNguoiNhan, style: AppTypography.noiDung.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(address.soDienThoai, style: AppTypography.moTa),
          const SizedBox(height: 4),
          Text(
            addressString,
            style: AppTypography.noiDung,
          ),
        ],
      ),
    );
  }
}
