// To parse this JSON data, do
//
//     final taskInstant = taskInstantFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

TaskInstant taskInstantFromJson(String str) => TaskInstant.fromJson(json.decode(str));

String taskInstantToJson(TaskInstant data) => json.encode(data.toJson());

class TaskInstant {
  TaskInstant({
    required this.id,
    required this.uuid,
    required this.uuidMogawers,
    required this.idMogawers,
    required this.uuidQueue,
    required this.statusTask,
    required this.statusNotes,
    required this.groupTask,
    required this.sequence,
    required this.limit,
    required this.isPinned,
    required this.isStarting,
    required this.startDate,
    required this.receivedDate,
    required this.expiredDate,
    required this.assignmentType,
    required this.uuidJob,
    required this.jobName,
    required this.jobDescription,
    required this.uuidJobType,
    required this.uuidLocationType,
    required this.uuidLocation,
    required this.uuidLocationLevel,
    required this.uuidProject,
    required this.projectName,
    required this.projectDescription,
    required this.uuidBatch,
    required this.batchName,
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.locationName,
    required this.locationAddress,
    required this.locationLevel,
    required this.jobTypeName,
    required this.tutorial,
    required this.code,
    required this.description,
    required this.brief,
    required this.howTo,
    required this.minimumLevel,
    required this.jobLimit,
    required this.fee,
    required this.type,
    required this.isScreening,
    required this.isDirect,
    required this.target,
    required this.points,
    required this.duration,
    required this.schedule,
    required this.isPublished,
    required this.isAutoApproved,
    required this.locationDescription,
    required this.isQcNeeded,
    required this.isHaveArea,
    required this.jobPicture,
    required this.jobBanner,
    required this.jobColor,
    required this.jobTextColor,
    required this.radius,
    required this.defaulLimit,
    required this.postMessage,
    required this.resultCount,
    required this.mogawersCode,
    required this.fullName,
    required this.email,
    required this.jobId,
    required this.category,
    required this.isDisplayable,
    required this.isAssigned,
    required this.jobActions,
    required this.certificates,
    required this.jobTimes,
    required this.endDate,
    required this.uuidOrder,
    required this.uuidTaskOrder,
    required this.uuidTaskOrderJob,
    required this.idTask,
  });

  int id;
  String uuid;
  dynamic uuidMogawers;
  dynamic idMogawers;
  String uuidQueue;
  dynamic statusTask;
  dynamic statusNotes;
  dynamic groupTask;
  dynamic sequence;
  dynamic limit;
  dynamic isPinned;
  dynamic isStarting;
  dynamic startDate;
  dynamic receivedDate;
  dynamic expiredDate;
  dynamic assignmentType;
  String uuidJob;
  String jobName;
  dynamic jobDescription;
  String uuidJobType;
  String uuidLocationType;
  String uuidLocation;
  dynamic uuidLocationLevel;
  String uuidProject;
  dynamic projectName;
  dynamic projectDescription;
  dynamic uuidBatch;
  dynamic batchName;
  String latitude;
  String longitude;
  String name;
  String locationName;
  String locationAddress;
  String locationLevel;
  String jobTypeName;
  String tutorial;
  dynamic code;
  String description;
  dynamic brief;
  dynamic howTo;
  int minimumLevel;
  dynamic jobLimit;
  int fee;
  dynamic type;
  dynamic isScreening;
  bool isDirect;
  int target;
  int points;
  String duration;
  dynamic schedule;
  bool isPublished;
  bool isAutoApproved;
  String locationDescription;
  bool isQcNeeded;
  dynamic isHaveArea;
  String? jobPicture;
  dynamic jobBanner;
  dynamic jobColor;
  dynamic jobTextColor;
  int radius;
  dynamic defaulLimit;
  dynamic postMessage;
  dynamic resultCount;
  dynamic mogawersCode;
  dynamic fullName;
  dynamic email;
  String jobId;
  dynamic category;
  bool isDisplayable;
  bool isAssigned;
  dynamic jobActions;
  dynamic certificates;
  dynamic jobTimes;
  dynamic endDate;
  dynamic uuidOrder;
  dynamic uuidTaskOrder;
  dynamic uuidTaskOrderJob;
  String idTask;

  factory TaskInstant.fromJson(Map<String, dynamic> json) => TaskInstant(
    id: json["id"] == null ? null : json["id"],
    uuid: json["uuid"] == null ? null : json["uuid"],
    uuidMogawers: json["uuidMogawers"],
    idMogawers: json["idMogawers"],
    uuidQueue: json["uuidQueue"] == null ? null : json["uuidQueue"],
    statusTask: json["statusTask"],
    statusNotes: json["statusNotes"],
    groupTask: json["groupTask"],
    sequence: json["sequence"],
    limit: json["limit"],
    isPinned: json["isPinned"],
    isStarting: json["isStarting"],
    startDate: json["startDate"],
    receivedDate: json["receivedDate"],
    expiredDate: json["expiredDate"],
    assignmentType: json["assignmentType"],
    uuidJob: json["uuidJob"] == null ? null : json["uuidJob"],
    jobName: json["jobName"] == null ? null : json["jobName"],
    jobDescription: json["jobDescription"],
    uuidJobType: json["uuidJobType"] == null ? null : json["uuidJobType"],
    uuidLocationType: json["uuidLocationType"] == null ? null : json["uuidLocationType"],
    uuidLocation: json["uuidLocation"] == null ? null : json["uuidLocation"],
    uuidLocationLevel: json["uuidLocationLevel"],
    uuidProject: json["uuidProject"] == null ? null : json["uuidProject"],
    projectName: json["projectName"],
    projectDescription: json["projectDescription"],
    uuidBatch: json["uuidBatch"],
    batchName: json["batchName"],
    latitude: json["latitude"] == null ? null : json["latitude"],
    longitude: json["longitude"] == null ? null : json["longitude"],
    name: json["name"] == null ? null : json["name"],
    locationName: json["locationName"] == null ? null : json["locationName"],
    locationAddress: json["locationAddress"] == null ? null : json["locationAddress"],
    locationLevel: json["locationLevel"] == null ? null : json["locationLevel"],
    jobTypeName: json["jobTypeName"] == null ? null : json["jobTypeName"],
    tutorial: json["tutorial"] == null ? null : json["tutorial"],
    code: json["code"],
    description: json["description"] == null ? null : json["description"],
    brief: json["brief"],
    howTo: json["howTo"],
    minimumLevel: json["minimumLevel"] == null ? null : json["minimumLevel"],
    jobLimit: json["jobLimit"],
    fee: json["fee"] == null ? null : json["fee"],
    type: json["type"],
    isScreening: json["isScreening"],
    isDirect: json["isDirect"] == null ? null : json["isDirect"],
    target: json["target"] == null ? null : json["target"],
    points: json["points"] == null ? null : json["points"],
    duration: json["duration"] == null ? null : json["duration"],
    schedule: json["schedule"],
    isPublished: json["isPublished"] == null ? null : json["isPublished"],
    isAutoApproved: json["isAutoApproved"] == null ? null : json["isAutoApproved"],
    locationDescription: json["locationDescription"] == null ? null : json["locationDescription"],
    isQcNeeded: json["isQcNeeded"] == null ? null : json["isQcNeeded"],
    isHaveArea: json["isHaveArea"],
    jobPicture: json["jobPicture"],
    jobBanner: json["jobBanner"],
    jobColor: json["jobColor"],
    jobTextColor: json["jobTextColor"],
    radius: json["radius"] == null ? null : json["radius"],
    defaulLimit: json["defaulLimit"],
    postMessage: json["postMessage"],
    resultCount: json["resultCount"],
    mogawersCode: json["mogawersCode"],
    fullName: json["fullName"],
    email: json["email"],
    jobId: json["jobId"] == null ? null : json["jobId"],
    category: json["category"],
    isDisplayable: json["isDisplayable"] == null ? null : json["isDisplayable"],
    isAssigned: json["isAssigned"] == null ? null : json["isAssigned"],
    jobActions: json["jobActions"],
    certificates: json["certificates"],
    jobTimes: json["jobTimes"],
    endDate: json["endDate"],
    uuidOrder: json["uuidOrder"],
    uuidTaskOrder: json["uuidTaskOrder"],
    uuidTaskOrderJob: json["uuidTaskOrderJob"],
    idTask: json["idTask"] == null ? null : json["idTask"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "uuid": uuid == null ? null : uuid,
    "uuidMogawers": uuidMogawers,
    "idMogawers": idMogawers,
    "uuidQueue": uuidQueue == null ? null : uuidQueue,
    "statusTask": statusTask,
    "statusNotes": statusNotes,
    "groupTask": groupTask,
    "sequence": sequence,
    "limit": limit,
    "isPinned": isPinned,
    "isStarting": isStarting,
    "startDate": startDate,
    "receivedDate": receivedDate,
    "expiredDate": expiredDate,
    "assignmentType": assignmentType,
    "uuidJob": uuidJob == null ? null : uuidJob,
    "jobName": jobName == null ? null : jobName,
    "jobDescription": jobDescription,
    "uuidJobType": uuidJobType == null ? null : uuidJobType,
    "uuidLocationType": uuidLocationType == null ? null : uuidLocationType,
    "uuidLocation": uuidLocation == null ? null : uuidLocation,
    "uuidLocationLevel": uuidLocationLevel,
    "uuidProject": uuidProject == null ? null : uuidProject,
    "projectName": projectName,
    "projectDescription": projectDescription,
    "uuidBatch": uuidBatch,
    "batchName": batchName,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "name": name == null ? null : name,
    "locationName": locationName == null ? null : locationName,
    "locationAddress": locationAddress == null ? null : locationAddress,
    "locationLevel": locationLevel == null ? null : locationLevel,
    "jobTypeName": jobTypeName == null ? null : jobTypeName,
    "tutorial": tutorial == null ? null : tutorial,
    "code": code,
    "description": description == null ? null : description,
    "brief": brief,
    "howTo": howTo,
    "minimumLevel": minimumLevel == null ? null : minimumLevel,
    "jobLimit": jobLimit,
    "fee": fee == null ? null : fee,
    "type": type,
    "isScreening": isScreening,
    "isDirect": isDirect == null ? null : isDirect,
    "target": target == null ? null : target,
    "points": points == null ? null : points,
    "duration": duration == null ? null : duration,
    "schedule": schedule,
    "isPublished": isPublished == null ? null : isPublished,
    "isAutoApproved": isAutoApproved == null ? null : isAutoApproved,
    "locationDescription": locationDescription == null ? null : locationDescription,
    "isQcNeeded": isQcNeeded == null ? null : isQcNeeded,
    "isHaveArea": isHaveArea,
    "jobPicture": jobPicture,
    "jobBanner": jobBanner,
    "jobColor": jobColor,
    "jobTextColor": jobTextColor,
    "radius": radius == null ? null : radius,
    "defaulLimit": defaulLimit,
    "postMessage": postMessage,
    "resultCount": resultCount,
    "mogawersCode": mogawersCode,
    "fullName": fullName,
    "email": email,
    "jobId": jobId == null ? null : jobId,
    "category": category,
    "isDisplayable": isDisplayable == null ? null : isDisplayable,
    "isAssigned": isAssigned == null ? null : isAssigned,
    "jobActions": jobActions,
    "certificates": certificates,
    "jobTimes": jobTimes,
    "endDate": endDate,
    "uuidOrder": uuidOrder,
    "uuidTaskOrder": uuidTaskOrder,
    "uuidTaskOrderJob": uuidTaskOrderJob,
    "idTask": idTask == null ? null : idTask,
  };
}
