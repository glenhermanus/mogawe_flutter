import 'package:intl/intl.dart';

String stringtoRupiah(int nominal) {
  final formatCurrency = NumberFormat.currency(locale: "id-ID", decimalDigits: 0);
  return "Rp " + formatCurrency.format(nominal).substring(3);
}