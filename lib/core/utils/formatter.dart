// core/utils/formatter.dart

class KeepCodeClean {
  // Placeholder class
}

String formatTien(dynamic amount) {
  if (amount == null) return '0đ';
  
  double val = 0;
  if (amount is double) {
    val = amount;
  } else if (amount is int) {
    val = amount.toDouble();
  } else if (amount is String) {
    val = double.tryParse(amount) ?? 0;
  }
  
  String str = val.toStringAsFixed(0);
  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  String formatted = str.replaceAllMapped(reg, (Match m) => '${m[1]}.');
  return '${formatted}đ';
}
