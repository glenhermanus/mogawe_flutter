import 'dart:io';

import 'package:mogawe/constant/api_path.dart';
import 'package:mogawe/core/data/response/merchant/merchant_profile_response.dart';
import 'package:mogawe/core/data/response/merchant/response_update.dart';
import 'package:mogawe/core/data/response/merchant/selfpick_radius_response.dart';
import 'package:mogawe/core/data/response/merchant/shipment_courier.dart';
import 'package:mogawe/core/data/response/profile/profile_history_response.dart';
import 'package:mogawe/core/data/response/profile/profile_response.dart';
import 'package:mogawe/core/data/response/register/register_response.dart';
import 'package:mogawe/core/data/sources/network/network_service.dart';

class ProfileRepository extends NetworkService {
  ProfileRepository();

  ProfileRepository._privateConstructor();
  static final ProfileRepository _instance = ProfileRepository._privateConstructor();
  static ProfileRepository get instance => _instance;

  Map<String, String> header = Map();
  final String contentType = "Content-Type";
  final String applicationJson = "application/json; charset=UTF-8";
  final String token = "token";

  //Static token for testing only
  // final String userToken = "eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJNTy00MjFCM0E"
  //     "iLCJpYXQiOjE2MzQ1MjkxMzEsInN1YiI6Im1vZ2F3ZXJzIiwiaXNzIjoibW9nYXdlIn0."
  //     "6I3GpI_gB02jpicmXzotWg4webpBU_3kpwFhWAF57bU";
  //late String userToken = getToken();


  Future<ProfileResponse> getProfile({String? realToken}) async {
    print(realToken);
    var header = {token: realToken!}; //Use realToken when implement get from original token
    var map = await postMethod("${BASE_URL}api/mogawers/v2/getProfile", headers: header);
    return ProfileResponse.fromJsonMap(map);
  }

  Future<MerchantProfileResponse> getProfileMerchant({String? realToken}) async {
    print(realToken);
    var header = {token: realToken!}; //Use realToken when implement get from original token
    var map = await getMethod("${BASE_URL}api/mogawers/supplier/profile/me", header);
    return MerchantProfileResponse.fromJson(map);
  }

  Future<ShipmentCourier> getShipmentMerchant({String? realToken}) async {
    print(realToken);
    var header = {token: realToken!}; //Use realToken when implement get from original token
    var map = await getMethod("${BASE_URL}api/sales/shipment/courier", header);
    return ShipmentCourier.fromJson(map);
  }

  Future<List<ProfileHistoryData>> getProfileHistory({String? realToken,
    String? page, String? periode, String? q}) async {
    print(realToken);
    var header = { token: realToken! }; //Use realToken when implement get from original token
    var map = await getMethod("${BASE_URL}api/fieldresult/history?"
        "page=${page ?? "1"}&offset=20&periode=${periode ?? "all"}"
        "&q=${q ?? ""}", header);
    return ProfileHistoryResponse.fromJsonMap(map).object;
  }

  Future<RegisterResponse> updateProfile(Map<String, String>? body, {String? realToken}) async {
    print(realToken);
    var header = {
      token: realToken!, //Use realToken when implement get from original token
      contentType: applicationJson
    };
    var map = await postMethod("${BASE_URL}api/mogawers/updateProfile",
        headers: header, body: body);
    return RegisterResponse.fromJsonMap(map);
  }

  Future<RegisterResponse> updateTargetRevenue(Map<String, dynamic>? body, {String? realToken}) async {
    print(realToken);
    var header = {
      token: realToken!, //Use realToken when implement get from original token
      contentType: applicationJson
    };
    var map = await putMethod("${BASE_URL}api/mogawers/config/update",
        header: header, body: body);
    return RegisterResponse.fromJsonMap(map);
  }

  Future<RegisterResponse> updateSelfReminder(Map<String, dynamic>? body, {String? realToken}) async {
    print(realToken);
    var header = {
      token: realToken!, //Use realToken when implement get from original token
      contentType: applicationJson
    };
    var map = await putMethod("${BASE_URL}api/mogawers/config/update",
        header: header, body: body);
    return RegisterResponse.fromJsonMap(map);
  }

  Future<SelfpickRadiusResponse> updateShipment(Map<String, String>? body, {String? realToken}) async {
    print(realToken);
    var header = {
      token: realToken!, //Use realToken when implement get from original token
      contentType: applicationJson
    };
    var map = await putMethod("${BASE_URL}api/mogawers/supplier/profile/update",
        header: header, body: body);
    return SelfpickRadiusResponse.fromJson(map);
  }

  Future<RegisterResponse> updatePhotoProfile(Map<String, File> body, {String? realToken}) async {
    print(realToken);
    var header = { token: realToken! }; //Use realToken when implement get from original token
    var map = await multipartPost("${BASE_URL}api/mogawers/updatePhotoProfile",
      files: body, header: header);
    return RegisterResponse.fromJsonMap(map);
  }

  Future<UpdateResponseMerchant> updatePhotoMerchant(Map<String, File> body, {String? realToken}) async {
    print(realToken);
    var header = { token: realToken! }; //Use realToken when implement get from original token
    var map = await multipartUpdate("${BASE_URL}api/mogawers/supplier/profile/image/upload",
        files: body, header: header);
    return UpdateResponseMerchant.fromJson(map);
  }

  Future<UpdateResponseMerchant> addPhotoProduct(Map<String, File> body, {String? realToken}) async {
    print(realToken);
    var header = { token: realToken! }; //Use realToken when implement get from original token
    var map = await multipartUpdate("${BASE_URL}api/supplier/product/image/upload",
        files: body, header: header);
    return UpdateResponseMerchant.fromJson(map);
  }

  Future<SelfpickRadiusResponse> updateselPickup(Map<String, int> body, {String? realToken}) async {
    print(realToken);
    var header = {
      token: realToken!, //Use realToken when implement get from original token
      contentType: applicationJson
    };
    var map = await putMethod("${BASE_URL}api/mogawers/supplier/profile/update",
        header: header, body: body);
    return SelfpickRadiusResponse.fromJson(map);
  }

}