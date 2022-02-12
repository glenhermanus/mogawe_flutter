import 'dart:convert';

import 'package:mogawe/core/data/response/form/task.dart';

StartEndFormResponse formResponseFromJson(String str) =>
    StartEndFormResponse.fromJson(json.decode(str));

String formResponseToJson(StartEndFormResponse data) =>
    json.encode(data.toJson());

class StartEndFormResponse {
  StartEndFormResponse({
    required this.returnValue,
    required this.message,
    required this.uuid,
    required this.object,
    required this.object2,
  });

  String returnValue;
  String message;
  dynamic uuid;
  Task? object;
  dynamic object2;

  factory StartEndFormResponse.fromJson(Map<String, dynamic> json) =>
      StartEndFormResponse(
        returnValue: json["returnValue"] == null ? null : json["returnValue"],
        message: json["message"] == null ? null : json["message"],
        uuid: json["uuid"],
        object: json["object"] == null ? null : Task.fromJson(json["object"]),
        object2: json["object2"],
      );

  Map<String, dynamic> toJson() => {
        "returnValue": returnValue == null ? null : returnValue,
        "message": message == null ? null : message,
        "uuid": uuid,
        "object": object == null ? null : object,
        "object2": object2,
      };
}
