import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppUtil {
  static void show(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (ctx) => Center(child: CupertinoActivityIndicator(radius: 16))
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
}