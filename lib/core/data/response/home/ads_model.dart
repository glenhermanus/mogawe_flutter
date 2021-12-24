
import 'dart:convert';

Ads adsFromJson(String str) => Ads.fromJson(json.decode(str));

String adsToJson(Ads data) => json.encode(data.toJson());

class Ads {
  Ads({
    required this.uuid,
    required this.sequence,
    required this.pictureUrl,
    required this.actionType,
    required this.actionValue,
    required this.actionParam,
  });

  String uuid;
  int sequence;
  String pictureUrl;
  String actionType;
  String actionValue;
  String actionParam;

  factory Ads.fromJson(Map<String, dynamic> json) => Ads(
    uuid: json["uuid"] == null ? null : json["uuid"],
    sequence: json["sequence"] == null ? null : json["sequence"],
    pictureUrl: json["pictureUrl"] == null ? null : json["pictureUrl"],
    actionType: json["actionType"] == null ? null : json["actionType"],
    actionValue: json["actionValue"] == null ? null : json["actionValue"],
    actionParam: json["actionParam"] == null ? null : json["actionParam"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid == null ? null : uuid,
    "sequence": sequence == null ? null : sequence,
    "pictureUrl": pictureUrl == null ? null : pictureUrl,
    "actionType": actionType == null ? null : actionType,
    "actionValue": actionValue == null ? null : actionValue,
    "actionParam": actionParam == null ? null : actionParam,
  };
}
