import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppUtil {
  static void show(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => Center(child: Theme(
          data: ThemeData(cupertinoOverrideTheme: CupertinoThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.white
          )),
          child: CupertinoActivityIndicator(radius: 12),
        ))
    );
  }

  static bool isEmailValidated(String value) {
    RegExp regex = new RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
    r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
    r"{0,253}[a-zA-Z0-9])?)*$");
    if (regex.hasMatch(value)) return true;
    else return false;
  }

  static String hashedPassword(String value) {
    List<int> bytes = utf8.encode(value);
    String hash = sha256.convert(bytes).toString();
    return hash;
  }

  static String toIDR(double money){
    var formatCurrency = NumberFormat.currency(
        locale: 'in_ID',
        symbol: 'Rp ',
        decimalDigits: 0
    );
    return formatCurrency.format(money);
  }

  static String formatDateTime({
    String dateFormat = "yyyy-MM-dd kk:mm",
    DateTime? dateTime,
  }) {
    return DateFormat(dateFormat).format(dateTime!);
  }
}