import 'dart:convert';

UserLoginResponse userLoginResponseFromJson(String str) =>
    UserLoginResponse.fromJson(json.decode(str));

String userLoginResponseToJson(UserLoginResponse data) =>
    json.encode(data.toJson());

class UserLoginResponse {
  UserLoginResponse({
    required this.returnValue,
    required this.message,
    required this.uuid,
    required this.token,
    required this.type,
    required this.object,
  });

  String returnValue;
  String message;
  dynamic uuid;
  String token;
  dynamic type;
  dynamic object;

  factory UserLoginResponse.fromJson(Map<String, dynamic> json) =>
      UserLoginResponse(
        returnValue: json["returnValue"],
        message: json["message"],
        uuid: json["uuid"],
        token: json["token"],
        type: json["type"],
        object: json["object"],
      );

  Map<String, dynamic> toJson() => {
        "returnValue": returnValue,
        "message": message,
        "uuid": uuid,
        "token": token,
        "type": type,
        "object": object,
      };
}
