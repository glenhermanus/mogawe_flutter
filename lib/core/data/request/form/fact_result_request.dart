import 'dart:convert';
import 'dart:io';

FactResultRequest factResultRequestFromJson(String str) =>
    FactResultRequest.fromJson(json.decode(str));

String factResultRequestToJson(FactResultRequest data) =>
    json.encode(data.toJson());

class FactResultRequest {
  FactResultRequest({
    required this.factName,
    required this.factSequence,
    required this.files,
    required this.id,
    required this.idFactDisplay,
    required this.idItemDisplay,
    required this.resultId,
    required this.sectionIsEdited,
    required this.sectionName,
    required this.sectionSequence,
    required this.uuidFactType,
    required this.value,
    required this.finalScore,
  });

  String? factName;
  int? factSequence;
  List<Map<String, File>> files;
  int? id;
  String? idFactDisplay;
  int? idItemDisplay;
  int? resultId;
  bool? sectionIsEdited;
  String? sectionName;
  int? sectionSequence;
  String? uuidFactType;
  String? value;
  String? finalScore;

  factory FactResultRequest.fromJson(Map<String, dynamic> json) =>
      FactResultRequest(
        factName: json["factName"] == null ? null : json["factName"],
        factSequence:
            json["factSequence"] == null ? null : json["factSequence"],
        files: json['files'] != null ? json['files'] : [],
        finalScore: json["finalScore"] == null ? null : json["finalScore"],
        idFactDisplay:
            json["idFactDisplay"] == null ? null : json["idFactDisplay"],
        idItemDisplay:
            json["idItemDisplay"] == null ? null : json["idItemDisplay"],
        uuidFactType:
            json["uuidFactType"] == null ? null : json["uuidFactType"],
        value: json["value"] == null ? null : json["value"],
        sectionName: json["sectionName"] == null ? null : json["sectionName"],
        id: json["id"] == null ? null : json["id"],
        sectionSequence:
            json["sectionSequence"] == null ? null : json["sectionSequence"],
        resultId: json["result_id"] == null ? null : json["result_id"],
        sectionIsEdited:
            json["sectionIsEdited"] == null ? null : json["sectionIsEdited"],
      );

  Map<String, dynamic> toJson() => {
        "factName": factName == null ? null : factName,
        "factSequence": factSequence == null ? 0 : factSequence,
        "files": files == null ? null : files.map((e){
          print("FactResultRequest ${e.values.toString()}");
          var map = {
            "path": e.values.toString()
          };
          return map;
        }).toList(),
        "id": id == null ? null : id,
        "idFactDisplay": idFactDisplay == null ? null : idFactDisplay,
        "idItemDisplay": idItemDisplay == null ? null : idItemDisplay,
        "result_id": resultId == null ? null : resultId,
        "sectionIsEdited": sectionIsEdited == null ? null : sectionIsEdited,
        "sectionName": sectionName == null ? null : sectionName,
        "sectionSequence": sectionSequence == null ? null : sectionSequence,
        "uuidFactType": uuidFactType == null ? null : uuidFactType,
        "value": value == null ? null : value,
        "finalScore": finalScore == null ? null : finalScore,
      };
}
