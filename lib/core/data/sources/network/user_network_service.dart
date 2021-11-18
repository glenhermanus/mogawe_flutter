import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mogawe/constant/api_path.dart';
import 'package:mogawe/core/data/request/reset_password_request.dart';
import 'package:mogawe/core/data/response/reset_password_response.dart';
import 'package:mogawe/core/data/response/user_login_response.dart';
import 'package:mogawe/core/data/response/user_profile_response.dart';
import 'package:mogawe/core/data/response/user_response.dart';

class UserNetworkService {
  Future<UserResponse> fetchVersion(int versionNumber) async {
    final response = await http.get(Uri.parse(
        "$BASE_URL/api/mogawers/versionCheckerV2?versionNumber=$versionNumber"));
    if (response.statusCode == 200) {
      return UserResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Terjadi kegagalan');
    }
  }

  Future<UserLoginResponse> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse("$BASE_URL/api/mogawers/logIn/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );
    return UserLoginResponse.fromJson(json.decode(response.body));
  }

  Future<UserLoginResponse> loginUserFacebook(String email, String id, String nama) async {
    final response = await http.post(
      Uri.parse("$BASE_URL/api/mogawers/logInSocMed"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'fullName': nama, 'email': email, 'idFacebook': id}),
    );
    return UserLoginResponse.fromJson(json.decode(response.body));
  }

  Future<UserLoginResponse> loginUserTwitter(String email, String id, String nama) async {
    final response = await http.post(
      Uri.parse("$BASE_URL/api/mogawers/logInSocMed"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'fullName': nama, 'email': email, 'idTwitter': id}),
    );
    return UserLoginResponse.fromJson(json.decode(response.body));
  }

  Future<UserProfileResponse> profileUser(String token) async {
    print('kucing');
    print(token);
    final response = await http.post(
      Uri.parse("$BASE_URL/api/mogawers/v2/getProfile"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8','token': '$token'
      },
      body: jsonEncode(<String, String>{'token': token}),
    );
    return UserProfileResponse.fromJson(json.decode(response.body));
  }

  Future<ResetPasswordResponse> resetPassword(
      ResetPasswordRequest request) async {
    final response = await http.post(
      Uri.parse("$BASE_URL/api/mogawers/forgotPassword/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(request.toJson()),
    );
    return ResetPasswordResponse.fromJson(json.decode(response.body));
  }
}
