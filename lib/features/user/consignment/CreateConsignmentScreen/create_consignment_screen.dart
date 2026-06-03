// features/user/consignment/create_consignment_screen.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

import '../../../../core/widgets/headers/custom_app_bar.dart';
import '../../../../core/widgets/buttons/primary_button.dart';

import 'upload_image_box.dart';
import 'consignment_form.dart';
import 'condition_selector.dart';
import 'consignment_term_card.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/headers/custom_app_bar.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../providers/store_provider.dart';

import 'upload_image_box.dart';
import 'consignment_form.dart';
import 'condition_selector.dart';
import 'consignment_term_card.dart';

class CreateConsignmentScreen extends StatefulWidget {
  const CreateConsignmentScreen({super.key});

  @override
  State<CreateConsignmentScreen> createState() => _CreateConsignmentScreenState();
}

class _CreateConsignmentScreenState extends State<CreateConsignmentScreen> {
  final _tenController = TextEditingController();
  final _moTaController = TextEditingController();
  final _danhMucController = TextEditingController();
  final _thuongHieuController = TextEditingController();
  final _kichThuocController = TextEditingController();
  final _giaController = TextEditingController();
  
  String _selectedCondition = '99%';
  String? _selectedImageUrl;

  @override
  void dispose() {
    _tenController.dispose();
    _moTaController.dispose();
    _danhMucController.dispose();
    _thuongHieuController.dispose();
    _kichThuocController.dispose();
    _giaController.dispose();
    super.dispose();
  }

  void _guiYeuCau() {
    final ten = _tenController.text.trim();
    final moTa = _moTaController.text.trim();
    final danhMuc = _danhMucController.text.trim();
    final thuongHieu = _thuongHieuController.text.trim();
    final kichThuoc = _kichThuocController.text.trim();
    final giaText = _giaController.text.trim();

    if (_selectedImageUrl == null || _selectedImageUrl!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng tải lên/chọn ảnh minh họa sản phẩm ký gửi!'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    if (ten.isEmpty || moTa.isEmpty || danhMuc.isEmpty || thuongHieu.isEmpty || kichThuoc.isEmpty || giaText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng nhập đầy đủ thông tin sản phẩm ký gửi!'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final gia = double.tryParse(giaText);
    if (gia == null || gia <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Giá mong muốn không hợp lệ!'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    // Thực hiện lưu yêu cầu ký gửi thông qua Provider
    final store = Provider.of<StoreProvider>(context, listen: false);
    store.createConsignmentRequest(
      ten: ten,
      moTa: moTa,
      giaMongMuon: gia,
      brand: thuongHieu,
      category: danhMuc,
      size: kichThuoc,
      condition: _selectedCondition,
      images: [_selectedImageUrl!],
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đã gửi yêu cầu ký gửi thành công! Chờ Admin phê duyệt.'),
        backgroundColor: AppColors.success,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(tieuDe: 'Tạo yêu cầu ký gửi'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            UploadImageBox(
              selectedImageUrl: _selectedImageUrl,
              onImageSelected: (url) {
                setState(() {
                  _selectedImageUrl = url;
                });
              },
            ),
            const SizedBox(height: AppSpacing.xl),
            ConsignmentForm(
              tenController: _tenController,
              moTaController: _moTaController,
              danhMucController: _danhMucController,
              thuongHieuController: _thuongHieuController,
              kichThuocController: _kichThuocController,
              giaController: _giaController,
            ),
            const SizedBox(height: AppSpacing.xl),
            ConditionSelector(
              selectedCondition: _selectedCondition,
              onConditionChanged: (condition) {
                setState(() {
                  _selectedCondition = condition;
                });
              },
            ),
            const SizedBox(height: AppSpacing.xl),
            const ConsignmentTermCard(),
            const SizedBox(height: AppSpacing.xl),
            PrimaryButton(
              tieuDe: 'Gửi yêu cầu ký gửi',
              onPressed: _guiYeuCau,
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}


