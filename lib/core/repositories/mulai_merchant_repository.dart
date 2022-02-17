import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mogawe/constant/api_path.dart';
import 'package:mogawe/core/data/response/merchant/add_address_response.dart';
import 'package:mogawe/core/data/response/merchant/address_pickup_response.dart';
import 'package:mogawe/core/data/response/merchant/response_update.dart';
import 'package:mogawe/core/data/response/qiscus/upload_file.dart';
import 'package:mogawe/core/data/response/register/register_response.dart';
import 'package:mogawe/core/data/sources/network/network_service.dart';


class MulaiMerchantRepository extends NetworkService {
  MulaiMerchantRepository();

  MulaiMerchantRepository._privateConstructor();

  static final MulaiMerchantRepository _instance = MulaiMerchantRepository
      ._privateConstructor();

  static MulaiMerchantRepository get instance => _instance;

  Map<String, String> header = Map();
  final String contentType = "Content-Type";
  final String applicationJson = "application/json; charset=UTF-8";
  final String token = "token";

  Future<UploadFotoQiscus> updatePhotoProfileToko(Map<String, File> body, {String? realToken}) async {
    print(realToken);
    var header = { token: realToken! }; //Use realToken when implement get from original token
    var map = await multipartUpdate("${BASE_URL}api/project/v2/iconUrl/upload/mogawers",
        files: body, header: header);
    return UploadFotoQiscus.fromJson(map);
  }

  Future registMerchant(
      String? realToken,
      String storename,
      String address,
      double latitude,
      double longitude,
      int shipmentProvinceId,
      String shipmentProvinceName,
      int shipmentCityId,
      String shipmentCityName,
      String urlPhoto,
      String uuid) async {
    var body = {
      "isActive": true,
      "shipmentCityId": shipmentCityId,
      "shipmentCityName": shipmentCityName,
      "shipmentProvinceId": shipmentProvinceId,
      "shipmentProvinceName": shipmentProvinceName,
      "storeAddress": address,
      "storeLat": latitude,
      "storeLng": longitude,
      "storeName": storename,
      "storePicture": urlPhoto,
      "uuidMogawers": uuid,
    };
    var header = {
      token: realToken!,
      contentType: applicationJson
    };

    var map = await postMethod("${BASE_URL}api/mogawers/supplier/registration",
        body: body, headers: header);

   print(map);
  }


  Future<dynamic> _putMethodAddress(String endPoint,
      [Map<String, String>? headers]) async {
    try {
      print("Endpoint : $endPoint");
      final response = await http.put(Uri.parse(endPoint), headers: headers);
      var res = json.decode(response.body);
      print(res);
      if (res["returnValue"] == "000") return res;
      else throw Exception(res["message"]);
    } on SocketException {
      throw Exception("Connection Failed");
    }
  }

  Future<dynamic> _deleteMethodAddress(String endPoint, [Map<String, String>? headers]) async {
    try {
      print("Endpoint : $endPoint");
      final response = await http.delete(Uri.parse(endPoint), headers: headers);
      var res = json.decode(response.body);
      print(res);
      if (res["returnValue"] == "000") return res;
      else throw Exception(res["message"]);
    } on SocketException {
      throw Exception("Connection Failed");
    }
  }


}