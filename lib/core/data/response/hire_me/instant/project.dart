import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:mogawe/core/data/response/home_content/Certificate.dart';

Project projectFromJson(String str) => Project.fromJson(json.decode(str));

String projectToJson(Project data) => json.encode(data.toJson());

class Project {
  Project({
    required this.uuid,
    required this.name,
    required this.description,
    required this.targetParticipants,
    required this.uuidQuestionnaire,
    required this.startDate,
    required this.endDate,
    required this.iconUrl,
    required this.certificates,
  });

  String uuid;
  String name;
  String description;
  int targetParticipants;
  dynamic uuidQuestionnaire;
  DateTime startDate;
  DateTime endDate;
  String iconUrl;
  List<Certificate> certificates;

  factory Project.fromJson(Map<String, dynamic> json) => Project(
    uuid: json["uuid"] == null ? null : json["uuid"],
    name: json["name"] == null ? null : json["name"],
    description: json["description"] == null ? null : json["description"],
    targetParticipants: json["targetParticipants"] == null ? null : json["targetParticipants"],
    uuidQuestionnaire: json["uuidQuestionnaire"],
    startDate: DateTime.parse(json["startDate"]),
    endDate: DateTime.parse(json["endDate"]),
    iconUrl: json["iconUrl"] == null ? null : json["iconUrl"],
    certificates: json["certificates"] == null ? [] : List<Certificate>.from(json["certificates"].map((x) => Certificate.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid == null ? null : uuid,
    "name": name == null ? null : name,
    "description": description == null ? null : description,
    "targetParticipants": targetParticipants == null ? null : targetParticipants,
    "uuidQuestionnaire": uuidQuestionnaire,
    "startDate": startDate == null ? null : startDate.toIso8601String(),
    "endDate": endDate == null ? null : endDate.toIso8601String(),
    "iconUrl": iconUrl == null ? null : iconUrl,
    "certificates": certificates == null ? [] : List<dynamic>.from(certificates.map((x) => x.toJson())),
  };
}