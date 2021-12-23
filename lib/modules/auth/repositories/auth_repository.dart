import 'package:mogawe/core/data/request/reset_password_request.dart';
import 'package:mogawe/core/data/response/hire_me/category_list_response.dart';
import 'package:mogawe/core/data/response/hire_me/favorite_hire_me_sales_response.dart';
import 'package:mogawe/core/data/response/hire_me/hire_me_sales_response.dart';
import 'package:mogawe/core/data/response/hire_me/sales_detail_response.dart';
import 'package:mogawe/core/data/response/pesona/detail_pesona_response.dart';
import 'package:mogawe/core/data/response/pesona/pesona_response.dart';
import 'package:mogawe/core/data/response/reset_password_response.dart';
import 'package:mogawe/constant/api_path.dart';
import 'package:mogawe/core/data/response/register/email_activation_response.dart';
import 'package:mogawe/core/data/response/register/register_response.dart';
import 'package:mogawe/core/data/response/user_login_response.dart';
import 'package:mogawe/core/data/response/user_profile_response.dart';
import 'package:mogawe/core/data/response/user_response.dart';
import 'package:mogawe/core/data/sources/network/network_service.dart';
import 'package:mogawe/core/data/sources/network/user_network_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository extends NetworkService {
  AuthRepository();

  AuthRepository._privateConstructor();
  static final AuthRepository _instance = AuthRepository._privateConstructor();
  static AuthRepository get instance => _instance;

  final UserNetworkService _apiService = UserNetworkService();

  Map<String, String> header = Map();
  final String contentType = "Content-Type";
  final String applicationJson = "application/json; charset=UTF-8";
  final storage = FlutterSecureStorage();

  Future<UserResponse> getVersionNumber(int versionNumber) async {
    return _apiService.fetchVersion(versionNumber);
  }

  Future<UserLoginResponse> submitLogin(String email, String password) async {
    return _apiService.loginUser(email, password);
  }

  Future<ResetPasswordResponse> resetPassword(ResetPasswordRequest request) {
    return _apiService.resetPassword(request);
  }

  Future<RegisterResponse> submitRegister(Map<String, String> body) async {
    var header = {contentType: applicationJson};
    var map = await postMethod("$BASE_URL/api/mogawers/registration",
        body: body, headers: header);
    return RegisterResponse.fromJsonMap(map);
  }

  Future<EmailActivationResponse> submitActivateEmail(
      Map<String, String> body) async {
    var header = {contentType: applicationJson};
    var map = await postMethod("$BASE_URL/api/mogawers/activation",
        headers: header, body: body);
    return EmailActivationResponse.fromJsonMap(map);
  }

  Future<RegisterResponse> submitResendActivationEmail(
      Map<String, String> body) async {
    var header = {contentType: applicationJson};
    var map = await postMethod("$BASE_URL/api/mogawers/resendActivationCode",
        headers: header, body: body);
    return RegisterResponse.fromJsonMap(map);
  }

  Future<RegisterResponse> submitActivateNewPassowrd(
      Map<String, String> body) async {
    var header = {contentType: applicationJson};
    var map = await postMethod("$BASE_URL/api/mogawers/activateNewPassword",
        headers: header, body: body);
    return RegisterResponse.fromJsonMap(map);
  }

  Future<PesonaResponses> pesonadata(token) async {
    return _apiService.pesonaresponse(token);
  }

  Future<HireMeSalesResponses> hiremeSalesdata(token) async {
    return _apiService.hiremeSalesresponse(token);
  }

  Future<HireMeSalesResponses> CategoryhiremeSalesdata(token, uuid) async {
    return _apiService.CategoryhiremeSalesresponse(token, uuid);
  }

  Future<CategoryListResponse> getCategorydata(token) async {
    return _apiService.getCategory(token);
  }

  Future<HireMeSalesResponses> SearchCategorydata(token, string) async {
    return _apiService.SearchhiremeSalesresponse(token, string);
  }

  Future<FavHireMeSalesResponses> favhiremeSalesdata(token) async {
    return _apiService.favhiremeSalesresponse(token);
  }

  Future<HireMeSalesResponses> postfavhiremeSalesdata(fav, token, uuid) async {
    return _apiService.postFavHireMeSales(fav, token, uuid);
  }

  Future<HireMeSalesResponses> deletefavhiremeSalesdata(
      fav, token, uuid) async {
    return _apiService.deleteFavHireMeSales(fav, token, uuid);
  }

  Future<SalesDetailResponses> getDetailsales(token, uuid) async {
    return _apiService.getSalesDetailresponse(token, uuid);
  }

  Future<DetailPesonaResponses> detailpesonadata(token, uuidjob) async {
    return _apiService.detailpesonaresponse(token, uuidjob);
  }

  Future<UserLoginResponse> LoginFacebook(nama, email, id) async {
    return _apiService.loginUserFacebook(nama, email, id);
  }

  Future<UserProfileResponse> getProfile(token) async {
    return _apiService.profileUser(token);
  }

  Future<UserLoginResponse> LoginTwitter(nama, email, id) async {
    return _apiService.loginUserTwitter(nama, email, id);
  }

  Object writeSecureData(String key, String value) {
    var writeData = storage.write(key: key, value: value);
    return writeData;
  }

  Object readSecureData(String key) {
    var readData = storage.read(key: key);

    return readData;
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  void saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  void deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }

  Object deleteSecureData(String key) {
    var deleteData = storage.delete(key: key);

    return deleteData;
  }
}
