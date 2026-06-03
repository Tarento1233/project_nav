// features/user/cart/cart_item_card.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/cart_model.dart';
import '../../../../models/product_model.dart';
import '../../../../providers/store_provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

import '../../../../core/widgets/common/network_image_widget.dart';

import 'quantity_selector.dart';

class CartItemCard extends StatelessWidget {
  final GioHangModel cartItem;

  const CartItemCard({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<StoreProvider>(context);
    final sanPham = store.danhSachSanPham.firstWhere(
      (p) => p.id == cartItem.sanPhamId,
      orElse: () => SanPhamModel(
        id: '',
        ten: 'Sản phẩm đã xóa',
        moTa: '',
        gia: 0,
        giaGoc: 0,
        phanTramGiamGia: 0,
        hinhAnh: ['https://images.unsplash.com/photo-1595777457583-95e059d581b8'],
        thuongHieuId: '',
        danhMucId: '',
        kichThuoc: '',
        tinhTrang: '',
        trangThai: '',
        tonKho: 0,
        noiBat: false,
        nguoiBanId: '',
        ngayTao: DateTime.now(),
      ),
    );

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),

      decoration: BoxDecoration(
        color: AppColors.surface,

        borderRadius: BorderRadius.circular(AppRadius.lg),

        boxShadow: AppShadows.cardShadow,
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          NetworkImageWidget(
            imageUrl: sanPham.hinhAnh.first,

            width: 100,

            height: 100,
          ),

          const SizedBox(width: AppSpacing.md),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  sanPham.ten,

                  maxLines: 2,

                  overflow: TextOverflow.ellipsis,

                  style: AppTypography.tieuDeNho,
                ),

                const SizedBox(height: AppSpacing.sm),

                Text('Size: ${cartItem.kichThuocDaChon}', style: AppTypography.moTa),

                const SizedBox(height: AppSpacing.md),

                Text(
                  '${sanPham.gia.toStringAsFixed(0)}đ',

                  style: AppTypography.gia,
                ),

                const SizedBox(height: AppSpacing.md),

                QuantitySelector(
                  quantity: cartItem.soLuong,
                  onIncrement: () => store.updateCartQuantity(cartItem.id, 1),
                  onDecrement: () => store.updateCartQuantity(cartItem.id, -1),
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: () => store.removeFromCart(cartItem.id),

            icon: const Icon(
              Icons.delete_outline_rounded,
              color: AppColors.error,
            ),
          ),
        ],
      ),
    );
  }
}
