class RegisterResponse {
  String returnValue;
  String message;

  RegisterResponse.fromJsonMap(Map<String, dynamic> map):
     returnValue = map["returnValue"],
     message = map["message"];

  Map<String, dynamic> toJson() {
    return {
      "returnValue": returnValue,
      "message": message
    };
  }
}