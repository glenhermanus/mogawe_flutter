import 'package:meta/meta.dart';
import 'dart:convert';

Certificate gaweanFromJson(String str) => Certificate.fromJson(json.decode(str));

String? gaweanToJson(Certificate data) => json.encode(data.toJson());

class Certificate {
  Certificate({
    required this.uuid,
    required this.uuidClient,
    required this.uuidCategory,
    required this.uuidJob,
    required this.uuidQuestionnaire,
    required this.questionnaireName,
    required this.howTo,
    required this.tutorial,
    required this.jobPicture,
    required this.name,
    required this.code,
    required this.category,
    required this.categoryName,
    required this.description,
    required this.instruction,
    required this.iconUrl,
    required this.status,
    required this.potentialJob,
    required this.minimumJobFee,
  });

  String? uuid;
  dynamic uuidClient;
  String? uuidCategory;
  String? uuidJob;
  dynamic uuidQuestionnaire;
  dynamic questionnaireName;
  String? howTo;
  dynamic tutorial;
  String? jobPicture;
  String? name;
  dynamic code;
  String? category;
  dynamic categoryName;
  String? description;
  String? instruction;
  String? iconUrl;
  String? status;
  int potentialJob;
  double minimumJobFee;

  factory Certificate.fromJson(Map<String?, dynamic> json) => Certificate(
    uuid: json["uuid"] == null ? null : json["uuid"],
    uuidClient: json["uuidClient"],
    uuidCategory: json["uuidCategory"] == null ? null : json["uuidCategory"],
    uuidJob: json["uuidJob"] == null ? null : json["uuidJob"],
    uuidQuestionnaire: json["uuidQuestionnaire"],
    questionnaireName: json["questionnaireName"],
    howTo: json["howTo"] == null ? null : json["howTo"],
    tutorial: json["tutorial"],
    jobPicture: json["jobPicture"] == null ? null : json["jobPicture"],
    name: json["name"] == null ? "" : json["name"],
    code: json["code"],
    category: json["category"] == "" ? null : json["category"],
    categoryName: json["categoryName"],
    description: json["description"] == "" ? null : json["description"],
    instruction: json["instruction"] == "" ? null : json["instruction"],
    iconUrl: json["iconUrl"] == null ? null : json["iconUrl"],
    status: json["status"] == null ? "" : json["status"],
    potentialJob: json["potentialJob"] == null ? null : json["potentialJob"],
    minimumJobFee: json["minimumJobFee"] == null ? null : json["minimumJobFee"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid == null ? null : uuid,
    "uuidClient": uuidClient,
    "uuidCategory": uuidCategory == null ? null : uuidCategory,
    "uuidJob": uuidJob == null ? null : uuidJob,
    "uuidQuestionnaire": uuidQuestionnaire,
    "questionnaireName": questionnaireName,
    "howTo": howTo == null ? null : howTo,
    "tutorial": tutorial,
    "jobPicture": jobPicture == null ? null : jobPicture,
    "name": name == null ? null : name,
    "code": code,
    "category": category == null ? null : category,
    "categoryName": categoryName,
    "description": description == null ? null : description,
    "instruction": instruction == null ? null : instruction,
    "iconUrl": iconUrl == null ? null : iconUrl,
    "status": status == null ? null : status,
    "potentialJob": potentialJob == null ? null : potentialJob,
    "minimumJobFee": minimumJobFee == null ? null : minimumJobFee,
  };
}
