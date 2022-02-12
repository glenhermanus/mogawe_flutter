import 'dart:convert';

import 'package:mogawe/core/data/response/form/form_model.dart';

FormResponse formResponseFromJson(String str) => FormResponse.fromJson(json.decode(str));

String formResponseToJson(FormResponse data) => json.encode(data.toJson());

class FormResponse {
  FormResponse({
    required this.returnValue,
    required this.message,
    required this.uuid,
    required this.object,
    required this.object2,
  });

  String returnValue;
  String message;
  dynamic uuid;
  List<FormModel> object;
  dynamic object2;

  factory FormResponse.fromJson(Map<String, dynamic> json) => FormResponse(
    returnValue: json["returnValue"] == null ? null : json["returnValue"],
    message: json["message"] == null ? null : json["message"],
    uuid: json["uuid"] == null ? "" : json["uuid"],
      object: json['object'] != null ? json['object'].map<FormModel>((json) => FormModel.fromJson(json)).toList() : [],
  object2: json["object2"] == null ? "" : json["object2"],
  );

  Map<String, dynamic> toJson() => {
    "returnValue": returnValue == null ? null : returnValue,
    "message": message == null ? null : message,
    "uuid": uuid,
    "object": List<FormModel>.from(object.map((x) => x)),
    "object2": object2,
  };
}
