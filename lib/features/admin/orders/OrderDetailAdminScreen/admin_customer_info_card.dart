// features/admin/orders/admin_customer_info_card.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/order_model.dart';
import '../../../../models/user_model.dart';
import '../../../../models/address_model.dart';
import '../../../../providers/store_provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/badges/status_badge.dart';

class AdminCustomerInfoCard extends StatelessWidget {
  final DonHangModel donHang;

  const AdminCustomerInfoCard({super.key, required this.donHang});

  Widget thongTin({required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTypography.moTa),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: AppTypography.noiDung,
            ),
          ),
        ],
      ),
    );
  }

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
          Text('Thông tin khách hàng', style: AppTypography.tieuDeNho),
          const SizedBox(height: AppSpacing.lg),
          thongTin(title: 'Mã đơn', value: donHang.id),
          thongTin(
            title: 'Khách hàng', 
            value: user.soDienThoai.isNotEmpty 
                ? '${user.ten} (${user.soDienThoai})' 
                : user.ten
          ),
          thongTin(title: 'Địa chỉ', value: addressString),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Trạng thái', style: AppTypography.moTa),
              StatusBadge(trangThai: donHang.trangThai),
            ],
          ),
        ],
      ),
    );
  }
}
