import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mogawe/constant/api_path.dart';
import 'package:mogawe/core/data/response/merchant/add_address_response.dart';
import 'package:mogawe/core/data/response/merchant/address_pickup_response.dart';
import 'package:mogawe/core/data/response/merchant/response_update.dart';
import 'package:mogawe/core/data/sources/network/network_service.dart';


class AddressRepository extends NetworkService {
  AddressRepository();

  AddressRepository._privateConstructor();

  static final AddressRepository _instance = AddressRepository
      ._privateConstructor();

  static AddressRepository get instance => _instance;

  Map<String, String> header = Map();
  final String contentType = "Content-Type";
  final String applicationJson = "application/json; charset=UTF-8";
  final String token = "token";

  Future<AddressPickupResponse> getListPickupAddress({String? realToken}) async {
    print(realToken);
    var header = {token: realToken!};
    var map =
        await getMethod("${BASE_URL}api/mogawers/supplier/address/get", header);
    return AddressPickupResponse.fromJson(map);
  }

  Future<UpdateResponseMerchant> setAddressAsDefault(
      {String? realToken, String? uuid}) async {
    print(realToken);
    var header = {token: realToken!};
    var map = await _putMethodAddress(
        "${BASE_URL}api/mogawers/supplier/address/setDefault/" + uuid!, header);
    return UpdateResponseMerchant.fromJson(map);
  }

  Future<AddAddressResponse> addAddress(
      String? realToken,
      String name,
      String address,
      double latitude,
      double longitude,
      int shipmentProvinceId,
      String shipmentProvinceName,
      int shipmentCityId,
      String shipmentCityName) async {
    var body = {
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'notes': "",
      'shipmentProvinceId': shipmentProvinceId,
      'shipmentProvinceName': shipmentProvinceName,
      'shipmentCityId': shipmentCityId,
      'shipmentCityName': shipmentCityName,
    };
    var header = {
      token: realToken!,
      contentType: applicationJson
    };

    var map = await postMethod("${BASE_URL}api/mogawers/supplier/address/create",
        body: body, headers: header);

    return AddAddressResponse.fromJson(map);
  }

  Future<AddAddressResponse> updateAddress(
      String? realToken,
      bool isdefault,
      String name,
      String address,
      double latitude,
      double longitude,
      int shipmentProvinceId,
      String shipmentProvinceName,
      int shipmentCityId,
      String shipmentCityName,
      String suppName, String uuid,
      String uuidSup,
      String note
      ) async {
    var body = {
      'isDefault': isdefault,
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'notes': note,
      'shipmentProvinceId': shipmentProvinceId,
      'shipmentProvinceName': shipmentProvinceName,
      'shipmentCityId': shipmentCityId,
      'shipmentCityName': shipmentCityName,
      "supplierName": suppName,
      "uuid": uuid,
      "uuidSupplier": uuidSup
    };
    var header = {
      token: realToken!,
      contentType: applicationJson
    };

    var map = await putMethod("${BASE_URL}api/mogawers/supplier/address/update",
        body: body, header: header);

    return AddAddressResponse.fromJson(map);
  }

  Future<UpdateResponseMerchant> deletePickupAddress(
      {String? realToken, String? uuid}) async {
    print(realToken);
    var header = {token: realToken!};
    var map = await _deleteMethodAddress(
        "${BASE_URL}api/mogawers/supplier/address/delete/" + uuid!, header);
    return UpdateResponseMerchant.fromJson(map);
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