import 'dart:convert';

import 'package:crypto/crypto.dart';

class PasswordHasher {
  String convertToSha256(String value) {
    List<int> bytes = utf8.encode(value);
    String hash = sha256.convert(bytes).toString();
    return hash;
  }
}
