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

  Future<dynamic> multipartPost(String endpoint, {Map<String, String>? body,
    Map<String, String>? header, Map<String, File>? files}) async {
    try {
      var uri = Uri.parse(endpoint);
      var request = http.MultipartRequest("POST", uri);

      if (files != null) {
        files.forEach((key, value) async{
          request.files.add(await http.MultipartFile.fromPath(key, value.path));
        });
      }

      request.headers.addAll(header!);
      request.fields.addAll(body!);

      var response = await request.send().then(http.Response.fromStream);
      var res = jsonDecode(response.body);
      if (res["returnValue"] == "000") return res;
      else throw Exception(res["message"]);
    } on SocketException {
      throw Exception("Connection Failed");
    }
  }

  Future<dynamic> putMethod(String endpoint, {dynamic body, Map<String, String>? header}) async {
    try {
      final response = await http.put(Uri.parse(endpoint), body: json.encode(body), headers: header);
      var res = json.decode(response.body);
      if (res["returnValue"] == "000") return res;
      else throw Exception(res["message"]);
    } on SocketException {
      throw Exception("Connection Failed");
    }
  }


}