import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/headers/custom_app_bar.dart';
import '../../../../providers/store_provider.dart';
import '../../order/MyOrderScreen/my_order_screen.dart';
import '../../../../models/product_model.dart';

import 'address_card.dart';
import 'checkout_product_item.dart';
import 'payment_method_selector.dart';
import 'checkout_summary_section.dart';
import 'place_order_bottom_bar.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String selectedMethod = 'COD';

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<StoreProvider>(context);
    final cartList = store.danhSachGioHangCaNhan;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(tieuDe: 'Thanh toán'),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                children: [
                  const AddressCard(),
                  const SizedBox(height: AppSpacing.xl),
                  ...cartList.map((item) {
                    final product = store.danhSachSanPham.firstWhere(
                      (p) => p.id == item.sanPhamId,
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
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                      child: CheckoutProductItem(
                        sanPham: product,
                        size: item.kichThuocDaChon,
                        quantity: item.soLuong,
                      ),
                    );
                  }).toList(),
                  PaymentMethodSelector(
                    selectedMethod: selectedMethod,
                    onChanged: (method) {
                      setState(() {
                        selectedMethod = method;
                      });
                    },
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  const CheckoutSummarySection(),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
          PlaceOrderBottomBar(
            tongTien: store.cartTotal,
            onPlaceOrder: () {
              store.checkout(selectedMethod);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const MyOrderScreen()),
                (route) => route.isFirst,
              );
            },
          ),
        ],
      ),
    );
  }
}
