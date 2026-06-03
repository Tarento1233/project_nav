// features/admin/consignments/consignment_action_section.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';

import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/buttons/secondary_button.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/buttons/secondary_button.dart';
import '../../../../models/product_model.dart';
import '../../../../providers/store_provider.dart';

class ConsignmentActionSection extends StatelessWidget {
  final SanPhamModel sanPham;

  const ConsignmentActionSection({super.key, required this.sanPham});

  void _hienThiDialogDuyet(BuildContext context, StoreProvider store) {
    final giaMongMuon = store.danhSachKyGui.firstWhere((k) => k.id == sanPham.id).giaMongMuon;
    final giaController = TextEditingController(text: giaMongMuon.toStringAsFixed(0));
    final hoaHongController = TextEditingController(text: '30');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Duyệt Yêu Cầu Ký Gửi'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: giaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Giá bán được duyệt (đđ)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                controller: hoaHongController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Tỷ lệ hoa hồng của Shop (%)',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Hủy'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.success),
              onPressed: () {
                final giaDuyet = double.tryParse(giaController.text.trim());
                final hoaHong = double.tryParse(hoaHongController.text.trim());

                if (giaDuyet == null || giaDuyet <= 0 || hoaHong == null || hoaHong < 0 || hoaHong > 100) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Vui lòng nhập giá trị hợp lệ!')),
                  );
                  return;
                }

                store.approveConsignment(sanPham.id, giaDuyet, hoaHong);
                Navigator.pop(context); // Đóng Dialog
                Navigator.pop(context); // Quay về danh sách
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Đã duyệt và đăng bán sản phẩm: ${sanPham.ten}')),
                );
              },
              child: const Text('Duyệt & Đăng bán', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _hienThiDialogTuChoi(BuildContext context, StoreProvider store) {
    final lyDoController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Từ Chối Ký Gửi'),
          content: TextField(
            controller: lyDoController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Lý do từ chối',
              hintText: 'Nhập ghi chú cho người ký gửi...',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Hủy'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
              onPressed: () {
                final lyDo = lyDoController.text.trim();
                if (lyDo.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Vui lòng nhập lý do từ chối!')),
                  );
                  return;
                }

                store.rejectConsignment(sanPham.id, lyDo);
                Navigator.pop(context);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Đã từ chối ký gửi sản phẩm: ${sanPham.ten}')),
                );
              },
              child: const Text('Xác nhận từ chối', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<StoreProvider>(context);
    final kyGui = store.danhSachKyGui.firstWhere(
      (k) => k.id == sanPham.id,
      orElse: () => store.danhSachKyGui.first,
    );

    if (kyGui.trangThai != 'CHO_DUYET') {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: AppColors.border),
        ),
        child: Center(
          child: Text(
            kyGui.trangThai == 'DA_BAN'
                ? 'Sản phẩm đã bán thành công'
                : kyGui.trangThai == 'DA_DUYET'
                    ? 'Yêu cầu đã được duyệt và đang bán'
                    : 'Yêu cầu ký gửi này đã bị từ chối',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      );
    }

    return Column(
      children: [
        PrimaryButton(
          tieuDe: 'Duyệt ký gửi & Đăng bán',
          onPressed: () => _hienThiDialogDuyet(context, store),
        ),
        const SizedBox(height: AppSpacing.lg),
        SecondaryButton(
          tieuDe: 'Từ chối ký gửi',
          onPressed: () => _hienThiDialogTuChoi(context, store),
        ),
      ],
    );
  }
}

