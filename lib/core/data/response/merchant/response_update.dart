class UpdateResponseMerchant {
  String returnValue;
  String message;
  dynamic uuid;
  String object;

  UpdateResponseMerchant.fromJson(Map<String, dynamic> json):
    returnValue= json["returnValue"],
    message= json["message"],
    uuid= json["uuid"],
    object= json["object"];

  Map<String, dynamic> toJson() => {
    "returnValue": returnValue,
    "message": message,
    "uuid": uuid,
    "object": object,
  };
}
