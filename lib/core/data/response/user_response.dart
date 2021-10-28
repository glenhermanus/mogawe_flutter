import 'dart:convert';

UserResponse userResponseFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  UserResponse({
    required this.returnValue,
    required this.message,
    required this.uuid,
  });

  String returnValue;
  String message;
  dynamic uuid;

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        returnValue: json["returnValue"],
        message: json["message"],
        uuid: json["uuid"],
      );

  Map<String, dynamic> toJson() => {
        "returnValue": returnValue,
        "message": message,
        "uuid": uuid,
      };
}
