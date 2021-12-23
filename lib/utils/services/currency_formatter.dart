import 'package:intl/intl.dart';

String stringtoRupiah(int nominal) {
  final formatCurrency = NumberFormat.currency(locale: "id-ID");
  return "Rp " + formatCurrency.format(nominal).substring(3);
}