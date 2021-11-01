import 'package:mogawe/constant/api_path.dart';
import 'package:mogawe/core/data/response/register/email_activation_response.dart';
import 'package:mogawe/core/data/response/register/register_response.dart';
import 'package:mogawe/core/data/response/user_login_response.dart';
import 'package:mogawe/core/data/response/user_response.dart';
import 'package:mogawe/core/data/sources/network/network_service.dart';
import 'package:mogawe/core/data/sources/network/user_network_service.dart';

class AuthRepository extends NetworkService {
  AuthRepository._privateConstructor();
  static final AuthRepository _instance = AuthRepository._privateConstructor();
  static AuthRepository get instance => _instance;

  final UserNetworkService _apiService = UserNetworkService();

  Map<String, String> header = Map();
  final String contentType = "Content-Type";
  final String applicationJson = "application/json; charset=UTF-8";

  Future<UserResponse> getVersionNumber(int versionNumber) async {
    return _apiService.fetchVersion(versionNumber);
  }

  Future<UserLoginResponse> submitLogin(String email, String password) async {
    return _apiService.loginUser(email, password);
  }

  Future<RegisterResponse> submitRegister(Map<String, String> body) async {
    var header = {contentType: applicationJson};
    var map = await postMethod("$BASE_URL/api/mogawers/registration",
        body: body, headers: header);
    return RegisterResponse.fromJsonMap(map);
  }
  
  Future<EmailActivationResponse> submitActivateEmail(Map<String, String> body) async {
    var header = {contentType: applicationJson};
    var map = await postMethod("$BASE_URL/api/mogawers/activation",
        headers: header, body: body);
    return EmailActivationResponse.fromJsonMap(map);
  }

  Future<RegisterResponse> submitResendActivationEmail(Map<String, String> body) async {
    var header = {contentType: applicationJson};
    var map = await postMethod("$BASE_URL/api/mogawers/resendActivationCode",
        headers: header, body: body);
    return RegisterResponse.fromJsonMap(map);
  }

  Future<RegisterResponse> submitActivateNewPassowrd(Map<String, String> body) async {
    var header = {contentType: applicationJson};
    var map = await postMethod("$BASE_URL/api/mogawers/activateNewPassword",
        headers: header, body: body);
    return RegisterResponse.fromJsonMap(map);
  }
}
