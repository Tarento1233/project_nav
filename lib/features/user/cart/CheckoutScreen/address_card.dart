// features/user/checkout/address_card.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../providers/store_provider.dart';
import '../../../../models/address_model.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({super.key});

  void _showEditAddressDialog(BuildContext context, StoreProvider store, DiaChiModel currentAddress) {
    final tenController = TextEditingController(text: currentAddress.tenNguoiNhan);
    final phoneController = TextEditingController(text: currentAddress.soDienThoai);
    final detailController = TextEditingController(text: currentAddress.diaChiChiTiet);
    final phuongController = TextEditingController(text: currentAddress.phuongXa);
    final quanController = TextEditingController(text: currentAddress.quanHuyen);
    final tinhController = TextEditingController(text: currentAddress.tinhThanh);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Thay đổi địa chỉ giao hàng'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: tenController,
                decoration: const InputDecoration(labelText: 'Tên người nhận'),
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Số điện thoại'),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: detailController,
                decoration: const InputDecoration(labelText: 'Địa chỉ chi tiết'),
              ),
              TextField(
                controller: phuongController,
                decoration: const InputDecoration(labelText: 'Phường/Xã'),
              ),
              TextField(
                controller: quanController,
                decoration: const InputDecoration(labelText: 'Quận/Huyện'),
              ),
              TextField(
                controller: tinhController,
                decoration: const InputDecoration(labelText: 'Tỉnh/Thành phố'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              final updated = DiaChiModel(
                id: currentAddress.id,
                nguoiDungId: currentAddress.nguoiDungId,
                tenNguoiNhan: tenController.text.trim(),
                soDienThoai: phoneController.text.trim(),
                tinhThanh: tinhController.text.trim(),
                quanHuyen: quanController.text.trim(),
                phuongXa: phuongController.text.trim(),
                diaChiChiTiet: detailController.text.trim(),
                macDinh: currentAddress.macDinh,
              );
              store.updateAddress(updated);
              Navigator.pop(context);
            },
            child: const Text('Cập nhật'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<StoreProvider>(context);
    final diaChi = store.diaChiMacDinh;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: AppShadows.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Địa chỉ giao hàng', style: AppTypography.tieuDeNho),
              GestureDetector(
                onTap: () => _showEditAddressDialog(context, store, diaChi),
                child: Text(
                  'Thay đổi',
                  style: AppTypography.noiDung.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            diaChi.tenNguoiNhan,
            style: AppTypography.noiDung.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(diaChi.soDienThoai, style: AppTypography.moTa),
          const SizedBox(height: 4),
          Text(
            '${diaChi.diaChiChiTiet}, ${diaChi.phuongXa}, ${diaChi.quanHuyen}, ${diaChi.tinhThanh}',
            style: AppTypography.noiDung,
          ),
        ],
      ),
    );
  }
}
