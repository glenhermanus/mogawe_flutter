import 'dart:convert';

import 'package:mogawe/core/data/response/ewallet/ewallet_model.dart';

EWalletResponse eWalletResponseFromJson(String str) => EWalletResponse.fromJson(json.decode(str));

String eWalletResponseToJson(EWalletResponse data) => json.encode(data.toJson());

class EWalletResponse {
    EWalletResponse({
        required this.returnValue,
        required this.message,
        required this.uuid,
        required this.rowCount,
        required this.pageCount,
        required this.offset,
        required this.object,
        required this.object2,
        required this.res,
    });

    String returnValue;
    String message;
    dynamic uuid;
    int rowCount;
    int pageCount;
    int offset;
    List<EWalletModel> object;
    dynamic object2;
    dynamic res;

    factory EWalletResponse.fromJson(Map<String, dynamic> json) => EWalletResponse(
        returnValue: json["returnValue"],
        message: json["message"],
        uuid: json["uuid"],
        rowCount: json["rowCount"],
        pageCount: json["pageCount"],
        offset: json["offset"],
        object: List<EWalletModel>.from(json["object"].map((x) => EWalletModel.fromJson(x))),
        object2: json["object2"],
        res: json["res"],
    );

    Map<String, dynamic> toJson() => {
        "returnValue": returnValue,
        "message": message,
        "uuid": uuid,
        "rowCount": rowCount,
        "pageCount": pageCount,
        "offset": offset,
        "object": List<dynamic>.from(object.map((x) => x.toJson())),
        "object2": object2,
        "res": res,
    };
}