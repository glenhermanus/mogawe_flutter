import 'dart:convert';

import 'dart:io';


Fact factFromJson(String str) => Fact.fromJson(json.decode(str));

String factToJson(Fact data) => json.encode(data.toJson());

class Fact {
  Fact({
    required this.uuid,
    required this.uuidQuestionnaire,
    required this.questionnaireName,
    required this.idFactDisplay,
    required this.idSectionDisplay,
    required this.idFactRef,
    required this.uuidSection,
    required this.uuidFactType,
    required this.factTypeDescription,
    required this.idDisplay,
    required this.factName,
    required this.reference,
    required this.hintName,
    required this.actionRules,
    required this.allowNoResponse,
    required this.label,
    required this.value,
    required this.valueScore,
    required this.itemValue,
    required this.minValue,
    required this.maxValue,
    required this.selectionValidate,
    required this.stepValue,
    required this.sequence,
    required this.videoUrl,
    required this.pictureUrl,
    required this.stampPhoto,
    required this.minDate,
    required this.maxDate,
    required this.idFact,
    required this.pollings,
    required this.isActive,
    required this.sectionName,
    required this.actionRuleSection,
    required this.sort,
    required this.idItemDisplay,
    required this.uuidItem,
    required this.itemName,
    required this.factType,
    required this.isVisible,
    required this.isMandatory,
    required this.isCommaAllowed,
    required this.hintNameItem,
    // required this.items,
    required this.itemPlanograms,
    required this.idQuestionnaire,
    required this.oldIdQuestionnaire,
    required this.factPlanos,
    required this.batchMetas,
    required this.factPlanoCount,
    required this.defaultValue,
    required this.input,
    required this.finalScore,
    required this.files
  });

  String uuid;
  dynamic uuidQuestionnaire;
  dynamic questionnaireName;
  String idFactDisplay;
  String idSectionDisplay;
  dynamic idFactRef;
  String uuidSection;
  String uuidFactType;
  String? factTypeDescription;
  String? idDisplay;
  String factName;
  String? reference;
  String hintName;
  String actionRules;
  String? allowNoResponse;
  String label;
  String value;
  String? valueScore;
  String? itemValue;
  dynamic minValue;
  dynamic maxValue;
  dynamic selectionValidate;
  String? stepValue;
  int sequence;
  String? videoUrl;
  String? pictureUrl;
  String? stampPhoto;
  dynamic minDate;
  dynamic maxDate;
  dynamic idFact;
  dynamic pollings;
  dynamic isActive;
  dynamic sectionName;
  dynamic actionRuleSection;
  dynamic sort;
  int? idItemDisplay;
  String? uuidItem;
  String? itemName;
  dynamic factType;
  bool isVisible;
  bool isMandatory;
  dynamic isCommaAllowed;
  dynamic hintNameItem;
  // List<dynamic>? items;
  dynamic itemPlanograms;
  dynamic idQuestionnaire;
  dynamic oldIdQuestionnaire;
  dynamic factPlanos;
  dynamic batchMetas;
  dynamic factPlanoCount;
  dynamic defaultValue;
  String? input;
  String? finalScore;
  List<Map<String, File>> files;

  factory Fact.fromJson(Map<String, dynamic> json) => Fact(
    uuid: json["uuid"] == null ? null : json["uuid"],
    uuidQuestionnaire: json["uuidQuestionnaire"],
    questionnaireName: json["questionnaireName"],
    idFactDisplay: json["idFactDisplay"] == null ? null : json["idFactDisplay"],
    idSectionDisplay: json["idSectionDisplay"] == null ? null : json["idSectionDisplay"],
    idFactRef: json["idFactRef"],
    uuidSection: json["uuidSection"] == null ? "" : json["uuidSection"],
    uuidFactType: json["uuidFactType"] == null ? "" : json["uuidFactType"],
    factTypeDescription: json["factTypeDescription"],
    idDisplay: json["idDisplay"],
    factName: json["factName"] == null ? "" : json["factName"],
    reference: json["reference"],
    hintName: json["hintName"] == null ? "" : json["hintName"],
    actionRules: json["actionRules"] == null ? null : json["actionRules"],
    allowNoResponse: json["allowNoResponse"],
    label: json["label"] == null ? "" : json["label"],
    value: json["value"] == null ? "" : json["value"],
    valueScore: json["valueScore"],
    itemValue: json["itemValue"],
    minValue: json["minValue"],
    maxValue: json["maxValue"],
    selectionValidate: json["selectionValidate"],
    stepValue: json["stepValue"],
    sequence: json["sequence"] == null ? 0 : json["sequence"],
    videoUrl: json["videoUrl"],
    pictureUrl: json["pictureUrl"],
    stampPhoto: json["stampPhoto"],
    minDate: json["minDate"],
    maxDate: json["maxDate"],
    idFact: json["idFact"],
    pollings: json["pollings"],
    isActive: json["isActive"],
    sectionName: json["sectionName"],
    actionRuleSection: json["actionRuleSection"],
    sort: json["sort"],
    idItemDisplay: json["idItemDisplay"],
    uuidItem: json["uuidItem"],
    itemName: json["itemName"],
    factType: json["factType"],
    isVisible: json["isVisible"] == 1 ? true : false,
    isMandatory: json["isMandatory"] == 1 ? true : false,
    isCommaAllowed: json["isCommaAllowed"],
    hintNameItem: json["hintNameItem"],
    // items: json["items"] == null ? null : List<dynamic>.from(json["items"].map((x) => x)),
    itemPlanograms: json["itemPlanograms"],
    idQuestionnaire: json["idQuestionnaire"],
    oldIdQuestionnaire: json["oldIdQuestionnaire"],
    factPlanos: json["factPlanos"],
    batchMetas: json["batchMetas"],
    factPlanoCount: json["factPlanoCount"],
    defaultValue: json["defaultValue"],
    input: json["input"] == null ? "" : json["input"],
    finalScore: json["finalScore"] == null ? "" : json["finalScore"],
    files: json['files'] != null ? json['files'] : [],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid == null ? null : uuid,
    "uuidQuestionnaire": uuidQuestionnaire,
    "questionnaireName": questionnaireName,
    "idFactDisplay": idFactDisplay == null ? null : idFactDisplay,
    "idSectionDisplay": idSectionDisplay == null ? null : idSectionDisplay,
    "idFactRef": idFactRef,
    "uuidSection": uuidSection == null ? null : uuidSection,
    "uuidFactType": uuidFactType == null ? null : uuidFactType,
    "factTypeDescription": factTypeDescription,
    "idDisplay": idDisplay,
    "factName": factName == null ? null : factName,
    "reference": reference,
    "hintName": hintName == null ? null : hintName,
    "actionRules": actionRules == null ? null : actionRules,
    "allowNoResponse": allowNoResponse,
    "label": label == null ? null : label,
    "value": value == null ? null : value,
    "valueScore": valueScore,
    "itemValue": itemValue,
    "minValue": minValue,
    "maxValue": maxValue,
    "selectionValidate": selectionValidate,
    "stepValue": stepValue,
    "sequence": sequence == null ? null : sequence,
    "videoUrl": videoUrl,
    "pictureUrl": pictureUrl,
    "stampPhoto": stampPhoto,
    "minDate": minDate,
    "maxDate": maxDate,
    "idFact": idFact,
    "pollings": pollings,
    "isActive": isActive,
    "sectionName": sectionName,
    "actionRuleSection": actionRuleSection,
    "sort": sort,
    "idItemDisplay": idItemDisplay,
    "uuidItem": uuidItem,
    "itemName": itemName,
    "factType": factType,
    "isVisible": isVisible == null ? null : isVisible,
    "isMandatory": isMandatory == null ? null : isMandatory,
    "isCommaAllowed": isCommaAllowed,
    "hintNameItem": hintNameItem,
    // "items": items == null ? null : List<dynamic>.from(items!.map((x) => x)),
    "itemPlanograms": itemPlanograms,
    "idQuestionnaire": idQuestionnaire,
    "oldIdQuestionnaire": oldIdQuestionnaire,
    "factPlanos": factPlanos,
    "batchMetas": batchMetas,
    "factPlanoCount": factPlanoCount,
    "defaultValue": defaultValue,
    "input": input,
    "finalScore": finalScore,
    "files": files
  };


}
