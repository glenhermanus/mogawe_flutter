import 'dart:convert';
import 'dart:io';

import 'package:mogawe/constant/api_path.dart';
import 'package:mogawe/core/data/response/merchant/address_pickup_response.dart';
import 'package:mogawe/core/data/response/merchant/response_update.dart';
import 'package:mogawe/core/data/sources/network/network_service.dart';
import 'package:http/http.dart' as http;


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
    var map = await getMethod("${BASE_URL}api/mogawers/supplier/address/get", header);
    return AddressPickupResponse.fromJson(map);
  }

  Future<UpdateResponseMerchant> setAddressAsDefault({String? realToken, String? uuid}) async {
    print(realToken);
    var header = {token: realToken!};
    var map = await _putMethodAddress("${BASE_URL}api/mogawers/supplier/address/setDefault/" + uuid!, header);
    return UpdateResponseMerchant.fromJson(map);
  }

  Future<UpdateResponseMerchant> deletePickupAddress({String? realToken, String? uuid}) async {
    print(realToken);
    var header = {token: realToken!};
    var map = await _deleteMethodAddress("${BASE_URL}api/mogawers/supplier/address/delete/" + uuid!, header);
    return UpdateResponseMerchant.fromJson(map);
  }


  Future<dynamic> _putMethodAddress(String endPoint, [Map<String, String>? headers]) async {
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