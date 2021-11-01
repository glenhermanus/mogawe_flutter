class EmailActivationResponse {
  String returnValue;
  String message;
  String token;

  EmailActivationResponse.fromJsonMap(Map<String, dynamic> map):
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