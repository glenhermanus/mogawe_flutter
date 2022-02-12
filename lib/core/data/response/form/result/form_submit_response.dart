import 'dart:convert';

FormSubmitResponse responseSubmitFormFromJson(String str) => FormSubmitResponse.fromJson(json.decode(str));

String responseSubmitFormToJson(FormSubmitResponse data) => json.encode(data.toJson());

class FormSubmitResponse {
  FormSubmitResponse({
    required this.returnValue,
    required this.message,
    required this.uuid,
  });

  String returnValue;
  String message;
  String uuid;

  factory FormSubmitResponse.fromJson(Map<String, dynamic> json) => FormSubmitResponse(
    returnValue: json["returnValue"] == "" ? null : json["returnValue"],
    message: json["message"] == null ? "" : json["message"],
    uuid: json["uuid"] == null ? "" : json["uuid"],
  );

  Map<String, dynamic> toJson() => {
    "returnValue": returnValue == null ? null : returnValue,
    "message": message == null ? null : message,
    "uuid": uuid,
  };
}
