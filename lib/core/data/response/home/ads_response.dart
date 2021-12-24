
import 'dart:convert';

import 'package:mogawe/core/data/response/home/ads_model.dart';

AdsResponse AdsResponseFromJson(String str) =>
    AdsResponse.fromJson(json.decode(str));

String AdsResponseToJson(AdsResponse data) =>
    json.encode(data.toJson());

class AdsResponse {
  AdsResponse({
    required this.returnValue,
    required this.message,
    required this.uuid,
    required this.rowCount,
    required this.pageCount,
    required this.offset,
    required this.object,
  });

  String? returnValue;
  String? message;
  String? uuid;
  int? rowCount;
  int? pageCount;
  int? offset;
  List<Ads> object;

  factory AdsResponse.fromJson(Map<String, dynamic> json) =>
      AdsResponse(
          returnValue: json["returnValue"],
          message: json["message"],
          uuid: json["uuid"],
          rowCount: json["rowCount"],
          pageCount: json["pageCount"],
          offset: json["offset"],
          object: json['object'] != null
              ? json['object']
              .map<Ads>(
                  (json) => Ads.fromJson(json))
              .toList()
              : []);

  Map<String, dynamic> toJson() => {
    "returnValue": returnValue,
    "message": message,
    "uuid": uuid,
    "rowCount": rowCount,
    "pageCount": pageCount,
    "offset": offset,
  };
}