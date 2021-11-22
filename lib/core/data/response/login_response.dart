class LoginResponse {
  String returnValue;
  String message;
  String token;

  LoginResponse.fromJsonMap(Map<String, dynamic> map):
    returnValue = map["returnValue"],
    message = map["message"],
    token = map["token"];

  Map<String, dynamic> toJson() {
    return {
      "returnValue": returnValue,
      "message": message,
      "token": token
    };
  }
}