import 'package:intl/intl.dart';

String stringtoRupiah(int nominal) {
  final formatCurrency = NumberFormat.currency(locale: "id-ID");
  String formattedCurrency = "Rp " + formatCurrency.format(nominal).substring(3);

  return formattedCurrency.substring(0, formattedCurrency.indexOf(','));
}