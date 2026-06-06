import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/headers/custom_app_bar.dart';
import '../../../models/transaction_model.dart';
import '../../../models/order_model.dart';
import '../../../providers/store_provider.dart';

class AdminRevenueHistoryScreen extends StatelessWidget {
  const AdminRevenueHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<StoreProvider>(context);

    // Lọc các đơn hàng hoàn thành đóng góp vào doanh thu
    final completedOrders = store.danhSachDonHang
        .where((o) => o.trangThai == 'HOAN_THANH')
        .toList()
      ..sort((a, b) => b.ngayTao.compareTo(a.ngayTao));

    // Lấy toàn bộ giao dịch ví
    final listGiaoDich = List<GiaoDichModel>.from(store.danhSachGiaoDich)
      ..sort((a, b) => b.ngayTao.compareTo(a.ngayTao));

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: const CustomAppBar(
          tieuDe: 'Chi tiết doanh thu',
        ),
        body: Column(
          children: [
            Container(
              color: AppColors.surface,
              child: const TabBar(
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.textSecondary,
                indicatorColor: AppColors.primary,
                tabs: [
                  Tab(text: 'Doanh thu đơn hàng'),
                  Tab(text: 'Lịch sử giao dịch ví'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Tab 1: Doanh thu đơn hàng
                  _buildOrderRevenueTab(context, store, completedOrders),
                  
                  // Tab 2: Lịch sử giao dịch ví
                  _buildWalletTransactionsTab(context, store, listGiaoDich),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderRevenueTab(BuildContext context, StoreProvider store, List<DonHangModel> orders) {
    if (orders.isEmpty) {
      return const Center(child: Text('Chưa có doanh thu từ đơn hàng nào.'));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.lg),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        final orderItems = store.danhSachChiTietDonHang.where((d) => d.donHangId == order.id).toList();
        
        double revenueContribution = 0;
        final detailsWidgets = <Widget>[];

        for (var item in orderItems) {
          final product = store.danhSachSanPham.firstWhere(
            (p) => p.id == item.sanPhamId,
            orElse: () => store.danhSachSanPham.first,
          );
          
          double itemRevenue = 0;
          String typeLabel = '';
          if (product.nguoiBanId == 'SHOP_01') {
            itemRevenue = item.gia * item.soLuong;
            typeLabel = 'Shop tự bán (100%)';
          } else {
            final consignment = store.danhSachKyGui.firstWhere(
              (k) => k.id == product.id,
              orElse: () => store.danhSachKyGui.first,
            );
            itemRevenue = (item.gia * item.soLuong) * (consignment.phanTramHoaHong / 100);
            typeLabel = 'Hoa hồng ký gửi (${consignment.phanTramHoaHong.toStringAsFixed(0)}%)';
          }
          revenueContribution += itemRevenue;

          detailsWidgets.add(
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '• ${product.ten} x${item.soLuong}',
                      style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '+${itemRevenue.toVND()} ($typeLabel)',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.success),
                  ),
                ],
              ),
            ),
          );
        }

        final dateStr = '${order.ngayTao.day.toString().padLeft(2, '0')}/${order.ngayTao.month.toString().padLeft(2, '0')}/${order.ngayTao.year}';

        return Container(
          margin: const EdgeInsets.only(bottom: AppSpacing.md),
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Đơn hàng: #${order.id}',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Text(
                    dateStr,
                    style: const TextStyle(color: AppColors.textLight, fontSize: 12),
                  ),
                ],
              ),
              const Divider(height: AppSpacing.lg),
              ...detailsWidgets,
              const Divider(height: AppSpacing.lg),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Tổng đóng góp doanh thu:', style: TextStyle(fontWeight: FontWeight.w600)),
                  Text(
                    revenueContribution.toVND(),
                    style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary, fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWalletTransactionsTab(BuildContext context, StoreProvider store, List<GiaoDichModel> transactions) {
    if (transactions.isEmpty) {
      return const Center(child: Text('Không có lịch sử giao dịch ví nào.'));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.lg),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final tx = transactions[index];
        
        // Tìm thông tin người dùng từ ví
        final wallet = store.danhSachVi.firstWhere(
          (v) => v.id == tx.viId,
          orElse: () => store.danhSachVi.first,
        );
        final user = store.danhSachNguoiDung.firstWhere(
          (u) => u.id == wallet.nguoiDungId,
          orElse: () => store.danhSachNguoiDung.first,
        );

        final dateStr = '${tx.ngayTao.day.toString().padLeft(2, '0')}/${tx.ngayTao.month.toString().padLeft(2, '0')}/${tx.ngayTao.year}';
        final isWithdrawal = tx.loai == 'RUT_TIEN';
        final amountPrefix = isWithdrawal ? '-' : '+';
        final amountColor = isWithdrawal ? AppColors.error : AppColors.success;
        final iconData = isWithdrawal ? Icons.arrow_outward : Icons.arrow_downward;

        String statusLabel = 'Đã xử lý';
        Color statusColor = AppColors.success;
        if (tx.trangThai == 'CHO_XAC_NHAN') {
          statusLabel = 'Chờ duyệt';
          statusColor = Colors.orange;
        } else if (tx.trangThai == 'THANH_CONG') {
          statusLabel = 'Thành công';
          statusColor = AppColors.success;
        } else if (tx.trangThai == 'THAT_BAI') {
          statusLabel = 'Từ chối';
          statusColor = AppColors.error;
        }

        return Container(
          margin: const EdgeInsets.only(bottom: AppSpacing.md),
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: amountColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(iconData, color: amountColor, size: 20),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tx.loai == 'RUT_TIEN' ? 'Yêu cầu rút tiền' : 'Chi trả ký gửi',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Khách hàng: ${user.ten}',
                      style: const TextStyle(fontSize: 12, color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      tx.moTa,
                      style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      dateStr,
                      style: const TextStyle(fontSize: 11, color: AppColors.textLight),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$amountPrefix${tx.soTien.toVND()}',
                    style: TextStyle(fontWeight: FontWeight.bold, color: amountColor, fontSize: 14),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      statusLabel,
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: statusColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
