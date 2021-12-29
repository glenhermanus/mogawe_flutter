class SelfpickRadiusResponse {
  String returnValue;
  String message;
  dynamic uuid;

  SelfpickRadiusResponse.fromJson(Map<String, dynamic> json):
        returnValue= json["returnValue"],
        message= json["message"],
        uuid= json["uuid"];

  Map<String, dynamic> toJson() => {
    "returnValue": returnValue,
    "message": message,
    "uuid": uuid,
  };
}
