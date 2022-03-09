import 'dart:convert';

UpdateGaweanSequenceRequest updateGaweanSequenceRequestFromJson(String str) => UpdateGaweanSequenceRequest.fromJson(json.decode(str));
String updateGaweanSequenceRequestToJson(UpdateGaweanSequenceRequest data) => json.encode(data.toJson());
class UpdateGaweanSequenceRequest {
  UpdateGaweanSequenceRequest({
    required this.fieldTasks,
  });

  List<UpdateGaweanSequenceRequestItem> fieldTasks;

  factory UpdateGaweanSequenceRequest.fromJson(Map<String, dynamic> json) => UpdateGaweanSequenceRequest(
    fieldTasks: json["fieldTasks"] == null ? "" : json["fieldTasks"],
  );

  Map<String, dynamic> toJson() => {
    "fieldTasks": fieldTasks == null ? [] : fieldTasks,
  };
}


UpdateGaweanSequenceRequestItem updateGaweanSequenceRequestItemFromJson(String str) => UpdateGaweanSequenceRequestItem.fromJson(json.decode(str));
String updateGaweanSequenceRequestItemToJson(UpdateGaweanSequenceRequestItem data) => json.encode(data.toJson());
class UpdateGaweanSequenceRequestItem {
  UpdateGaweanSequenceRequestItem({
    required this.uuid,
  });

  String uuid;

  factory UpdateGaweanSequenceRequestItem.fromJson(Map<String, dynamic> json) => UpdateGaweanSequenceRequestItem(
    uuid: json["uuid"] == null ? "" : json["uuid"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid == "" ? null : uuid,
  };
}





