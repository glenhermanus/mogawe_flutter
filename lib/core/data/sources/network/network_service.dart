import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

abstract class NetworkService {

  Future<dynamic> getMethod(String endPoint, [Map<String, String>? headers]) async {
    try {
      print("Endpoint : $endPoint");
      final response = await http.get(Uri.parse(endPoint), headers: headers);
      var res = json.decode(response.body);
      if (res["returnValue"] == "000") return res;
      else throw Exception(res["message"]);
    } on SocketException {
      throw Exception("Connection Failed");
    }
  }

  Future<dynamic> postMethod(String endpoint, {dynamic body, Map<String, String>? headers}) async {
    try {
      final response = await http.post(Uri.parse(endpoint), body: json.encode(body),
          headers: headers);
      var res = json.decode(response.body);
      if (res["returnValue"] == "000") return res;
      else throw Exception(res["message"]);
    } on SocketException {
      throw Exception("Connection Failed");
    }
  }
}