import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mogawe/constant/api_path.dart';
import 'package:mogawe/core/data/response/user_login_response.dart';
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
}
