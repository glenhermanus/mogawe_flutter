import 'dart:convert';

import 'package:mogawe/core/data/response/ewallet/nominal/ewallet_nominal_model.dart';
EWalletNominalResponse eWalletNominalResponseFromJson(String str) => EWalletNominalResponse.fromJson(json.decode(str));

String eWalletNominalResponseToJson(EWalletNominalResponse data) => json.encode(data.toJson());

class EWalletNominalResponse {
    EWalletNominalResponse({
        required this.returnValue,
        required this.message,
        required this.uuid,
        required this.object,
        required this.object2,
    });

    String returnValue;
    String message;
    dynamic uuid;
    List<EWalletNominalModel> object;
    dynamic object2;

    factory EWalletNominalResponse.fromJson(Map<String, dynamic> json) => EWalletNominalResponse(
        returnValue: json["returnValue"],
        message: json["message"],
        uuid: json["uuid"],
        object: List<EWalletNominalModel>.from(json["object"].map((x) => EWalletNominalModel.fromJson(x))),
        object2: json["object2"],
    );

    Map<String, dynamic> toJson() => {
        "returnValue": returnValue,
        "message": message,
        "uuid": uuid,
        "object": List<dynamic>.from(object.map((x) => x.toJson())),
        "object2": object2,
    };
}