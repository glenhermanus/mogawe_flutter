import 'dart:convert';

import 'package:mogawe/core/data/response/form/fact.dart';

FormModel formFromJson(String str) => FormModel.fromJson(json.decode(str));

String formToJson(FormModel data) => json.encode(data.toJson());

class FormModel {
  FormModel({
    required this.id,
    required this.uuid,
    required this.uuidQuestionnaire,
    required this.uuidQuestionnaireTemplate,
    required this.questionnaireTemplateName,
    required this.idDisplay,
    required this.idSectionDisplay,
    required this.name,
    required this.actionRules,
    required this.sort,
    required this.hintName,
    required this.versionNumber,
    required this.isActive,
    required this.facts,
    required this.idOldQuestionnaire,
    required this.idItemDisplay,
    required this.uuidItem,
    required this.itemName,
    required this.idMetaDisplay,
    required this.uuidMeta,
    required this.metaName,
  });

  dynamic id;
  String uuid;
  dynamic uuidQuestionnaire;
  String uuidQuestionnaireTemplate;
  String questionnaireTemplateName;
  String idDisplay;
  String idSectionDisplay;
  String name;
  String actionRules;
  int sort;
  dynamic hintName;
  int versionNumber;
  dynamic isActive;
  List<Fact> facts;
  dynamic idOldQuestionnaire;
  dynamic idItemDisplay;
  dynamic uuidItem;
  dynamic itemName;
  dynamic idMetaDisplay;
  dynamic uuidMeta;
  dynamic metaName;

  factory FormModel.fromJson(Map<String, dynamic> json) => FormModel(
    id: json["id"] == null ? 0 : json["id"],
    uuid: json["uuid"] == null ? null : json["uuid"],
    uuidQuestionnaire: json["uuidQuestionnaire"],
    uuidQuestionnaireTemplate: json["uuidQuestionnaireTemplate"] == null ? "" : json["uuidQuestionnaireTemplate"],
    questionnaireTemplateName: json["questionnaireTemplateName"] == null ? "" : json["questionnaireTemplateName"],
    idDisplay: json["idDisplay"] == null ? null : json["idDisplay"],
    idSectionDisplay: json["idSectionDisplay"] == null ? null : json["idSectionDisplay"],
    name: json["name"] == null ? null : json["name"],
    actionRules: json["actionRules"] == null ? null : json["actionRules"],
    sort: json["sort"] == null ? null : json["sort"],
    hintName: json["hintName"],
    versionNumber: json["versionNumber"] == null ? 0 : json["versionNumber"],
    isActive: json["isActive"],
    facts: json['facts'] != null ? json['facts'].map<Fact>((json) => Fact.fromJson(json)).toList() : [],
    idOldQuestionnaire: json["idOldQuestionnaire"] == "" ? "" : json["idOldQuestionnaire"],
    idItemDisplay: json["idItemDisplay"] == "" ? 0 : json["idItemDisplay"],
    uuidItem: json["uuidItem"] == "" ? null : json["uuidItem"],
    itemName: json["itemName"] == "" ? null : json["itemName"],
    idMetaDisplay: json["idMetaDisplay"] == "" ? null : json["idMetaDisplay"],
    uuidMeta: json["uuidMeta"] == "" ? null : json["uuidMeta"],
    metaName: json["metaName"] == "" ? null : json["metaName"],
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid == null ? null : uuid,
    "uuidQuestionnaire": uuidQuestionnaire,
    "uuidQuestionnaireTemplate": uuidQuestionnaireTemplate == null ? null : uuidQuestionnaireTemplate,
    "questionnaireTemplateName": questionnaireTemplateName == null ? null : questionnaireTemplateName,
    "idDisplay": idDisplay == null ? null : idDisplay,
    "idSectionDisplay": idSectionDisplay == null ? null : idSectionDisplay,
    "name": name == null ? null : name,
    "actionRules": actionRules == null ? null : actionRules,
    "sort": sort == null ? null : sort,
    "hintName": hintName,
    "versionNumber": versionNumber == null ? null : versionNumber,
    "isActive": isActive,
    // "facts": List<Fact>.from(facts.map((x) => x)),
    "facts": facts.map((x) => x.toJson()).toList(),
    "idOldQuestionnaire": idOldQuestionnaire,
    "idItemDisplay": idItemDisplay,
    "uuidItem": uuidItem,
    "itemName": itemName,
    "idMetaDisplay": idMetaDisplay,
    "uuidMeta": uuidMeta,
    "metaName": metaName,
  };
}
