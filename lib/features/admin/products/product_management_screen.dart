// features/admin/products/product_management_screen.dart

import 'package:flutter/material.dart';

import '../../../core/constants/mock_data.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/headers/custom_app_bar.dart';
import 'CreateProductScreen/create_product_screen.dart';
import 'EditProductScreen/edit_product_screen.dart';

import 'admin_product_card.dart';
import 'product_search_bar.dart';
import 'product_filter_section.dart';
import 'add_product_button.dart';

import 'package:provider/provider.dart';
import '../../../providers/store_provider.dart';

class ProductManagementScreen extends StatefulWidget {
  const ProductManagementScreen({super.key});

  @override
  State<ProductManagementScreen> createState() => _ProductManagementScreenState();
}

class _ProductManagementScreenState extends State<ProductManagementScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'Tất cả';
  String _selectedBrand = 'Tất cả';
  String _selectedStatus = 'Tất cả';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<StoreProvider>(context);
    
    // Lọc danh sách sản phẩm thực tế từ Firestore
    final danhSachSanPham = store.danhSachSanPham.where((p) {
      if (_selectedCategory != 'Tất cả') {
        if (_selectedCategory == 'Khác') {
          final standardCategories = List<String>.from(DuLieuMau.danhMuc)..remove('Khác');
          if (standardCategories.contains(p.danhMucId)) {
            return false;
          }
        } else if (p.danhMucId != _selectedCategory) {
          return false;
        }
      }
      if (_selectedBrand != 'Tất cả' && p.thuongHieuId != _selectedBrand) {
        return false;
      }
      if (_selectedStatus != 'Tất cả') {
        final String statusDbValue;
        switch (_selectedStatus) {
          case 'Đang bán':
            statusDbValue = 'DANG_BAN';
            break;
          case 'Chờ duyệt':
            statusDbValue = 'CHO_DUYET';
            break;
          case 'Bị từ chối':
            statusDbValue = 'BI_TU_CHOI';
            break;
          case 'Đã bán':
            statusDbValue = 'DA_BAN';
            break;
          default:
            statusDbValue = _selectedStatus;
        }
        if (p.trangThai != statusDbValue) {
          return false;
        }
      }
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        final matchTen = p.ten.toLowerCase().contains(q);
        final matchMoTa = p.moTa.toLowerCase().contains(q);
        if (!matchTen && !matchMoTa) return false;
      }
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(tieuDe: 'Quản lý sản phẩm', hienThiNutBack: false),
      // FAB → CreateProductScreen
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CreateProductScreen()),
        ),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
            child: ProductSearchBar(controller: _searchController),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
            child: ProductFilterSection(
              selectedCategory: _selectedCategory,
              selectedBrand: _selectedBrand,
              selectedStatus: _selectedStatus,
              onCategoryChanged: (cat) => setState(() => _selectedCategory = cat),
              onBrandChanged: (brand) => setState(() => _selectedBrand = brand),
              onStatusChanged: (status) => setState(() => _selectedStatus = status),
            ),
          ),
          Expanded(
            child: danhSachSanPham.isEmpty
                ? const Center(child: Text('Không tìm thấy sản phẩm nào'))
                : ListView.separated(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    itemCount: danhSachSanPham.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final sanPham = danhSachSanPham[index];
                      final isShopProduct = sanPham.nguoiBanId == 'SHOP_01';

                      return AdminProductCard(
                        sanPham: sanPham,
                        onEdit: isShopProduct
                            ? () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => EditProductScreen(sanPham: sanPham),
                                  ),
                                )
                            : null,
                        onToggleFeatured: () {
                          store.toggleProductFeaturedStatus(sanPham.id, sanPham.noiBat);
                        },
                        onDelete: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Xác nhận xóa'),
                              content: const Text('Bạn có chắc chắn muốn xóa sản phẩm này?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Hủy'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    store.deleteProduct(sanPham.id);
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Đã xóa sản phẩm thành công!')),
                                    );
                                  },
                                  child: const Text('Xóa', style: TextStyle(color: Colors.red)),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
