import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'user_login_response.g.dart';

UserLoginResponse userLoginResponseFromJson(String str) =>
    UserLoginResponse.fromJson(json.decode(str));

String userLoginResponseToJson(UserLoginResponse data) =>
    json.encode(data.toJson());


@JsonSerializable()
class UserLoginResponse {
  String returnValue;
  String message;
  dynamic uuid;
  String token;
  dynamic type;
  dynamic object;

   UserLoginResponse({
    required this.returnValue,
    required this.message,
    required this.uuid,
    required this.token,
    required this.type,
    required this.object,
  });

  factory UserLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$UserLoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginResponseToJson(this);
}
