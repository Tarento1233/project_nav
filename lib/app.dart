import 'package:flutter/material.dart';
import 'package:nhom10_ung_dung_ban_do_thoi_trang_outlet/core/constants/mock_data.dart';
import 'package:nhom10_ung_dung_ban_do_thoi_trang_outlet/features/admin/consignments/AdminConsignmentDetailScreen/admin_consignment_detail_screen.dart';
import 'package:nhom10_ung_dung_ban_do_thoi_trang_outlet/features/admin/consignments/ConsignmentConfigScreen/consignment_management_screen.dart';
import 'package:nhom10_ung_dung_ban_do_thoi_trang_outlet/features/admin/dashboard/DashboardScreen/dashboard_screen.dart';
import 'package:nhom10_ung_dung_ban_do_thoi_trang_outlet/features/admin/orders/OrderDetailAdminScreen/admin_order_detail_screen.dart';
import 'package:nhom10_ung_dung_ban_do_thoi_trang_outlet/features/admin/orders/OrderManagementScreen/order_management_screen.dart';
import 'package:nhom10_ung_dung_ban_do_thoi_trang_outlet/features/admin/products/CreateProductScreen/create_product_screen.dart';
import 'package:nhom10_ung_dung_ban_do_thoi_trang_outlet/features/admin/products/EditProductScreen/edit_product_screen.dart';
import 'package:nhom10_ung_dung_ban_do_thoi_trang_outlet/features/admin/products/product_management_screen.dart';
import 'package:nhom10_ung_dung_ban_do_thoi_trang_outlet/features/admin/reports/report_screen.dart';
import 'package:nhom10_ung_dung_ban_do_thoi_trang_outlet/features/admin/users/UserDetailScreen/user_detail_screen.dart';
import 'package:nhom10_ung_dung_ban_do_thoi_trang_outlet/features/admin/users/UserManagementScreen/user_management_screen.dart';
import 'package:nhom10_ung_dung_ban_do_thoi_trang_outlet/features/user/auth/screens/ForgotPassWordScreen/forgot_password_screen.dart';
import 'package:nhom10_ung_dung_ban_do_thoi_trang_outlet/features/user/auth/screens/LoginScreen/login_screen.dart';
import 'package:nhom10_ung_dung_ban_do_thoi_trang_outlet/features/user/auth/screens/RegisterScreen/register_screen.dart';
import 'package:nhom10_ung_dung_ban_do_thoi_trang_outlet/features/user/auth/screens/onboarding_screen.dart';
import 'package:nhom10_ung_dung_ban_do_thoi_trang_outlet/features/user/auth/screens/splash_screen.dart';
import 'package:nhom10_ung_dung_ban_do_thoi_trang_outlet/features/user/cart/CartScreen/cart_screen.dart';
import 'package:nhom10_ung_dung_ban_do_thoi_trang_outlet/features/user/cart/CheckoutScreen/checkout_screen.dart';
import 'package:nhom10_ung_dung_ban_do_thoi_trang_outlet/features/user/consignment/ConsignmentDetailScreen/consignment_detail_screen.dart';
import 'package:nhom10_ung_dung_ban_do_thoi_trang_outlet/features/user/consignment/CreateConsignmentScreen/create_consignment_screen.dart';
import 'package:nhom10_ung_dung_ban_do_thoi_trang_outlet/features/user/consignment/MyConsignmentScreen/my_consignment_screen.dart';
import 'package:nhom10_ung_dung_ban_do_thoi_trang_outlet/features/user/order/MyOrderScreen/my_order_screen.dart';
import 'package:nhom10_ung_dung_ban_do_thoi_trang_outlet/features/user/order/OrderDetailScreen/order_detail_screen.dart';
import 'package:nhom10_ung_dung_ban_do_thoi_trang_outlet/features/user/product/product_detail_screen.dart';
import 'package:nhom10_ung_dung_ban_do_thoi_trang_outlet/features/user/profile/profile_screen.dart';
import 'package:nhom10_ung_dung_ban_do_thoi_trang_outlet/features/user/wallet/WalletScreen/wallet_screen.dart';
import 'package:nhom10_ung_dung_ban_do_thoi_trang_outlet/features/user/wallet/WithdrawScreen/withdraw_screen.dart';

import 'core/theme/app_theme.dart';

import 'features/user/home/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Outlet Fashion',

      theme: AppTheme.lightTheme,

      //AUTH
      //home: LoginScreen(),
      //home: RegisterScreen(),
      //home: ForgotPasswordScreen(),
      //home: SplashScreen(),
      home: OnboardingScreen(),

      //USER
      //home: HomeScreen(),
      //home: ProductDetailScreen(sanPham: DuLieuMau.danhSachSanPham.first),
      //home: CartScreen(),
      //home: CheckoutScreen(),
      //home: MyOrderScreen(),
      //home: OrderDetailScreen(donHang: DuLieuMau.danhSachDonHang.first),
      //home: ProfileScreen(),
      //home: WalletScreen(),
      //home: WithdrawScreen(),
      //home: CreateConsignmentScreen(),
      //home: MyConsignmentScreen(),
      //home: ConsignmentDetailScreen(sanPham: DuLieuMau.danhSachSanPham.first),

      //ADMIN
      //home: DashboardScreen(),
      //home: ProductManagementScreen(),
      //home: CreateProductScreen(),
      //home: EditProductScreen(sanPham: DuLieuMau.danhSachSanPham.first),
      //home: OrderManagementScreen(),
      //home: AdminOrderDetailScreen(donHang: DuLieuMau.danhSachDonHang.first),
      //home: ConsignmentManagementScreen(),
      //home: AdminConsignmentDetailScreen(sanPham: DuLieuMau.danhSachSanPham.first,),
      //home: UserManagementScreen(),
      //home: UserDetailScreen(),
      //home: ReportScreen(),
    );
  }
}
