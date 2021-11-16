class ProfileHistoryResponse {
  String? returnValue;
  String? message;
  String? uuid;
  int? rowCount;
  int? pageCount;
  int? offset;
  List<ProfileHistoryData> object;

  ProfileHistoryResponse.fromJsonMap(Map<String, dynamic> map):
    returnValue = map["returnValue"],
    message = map["message"],
    uuid = map["uuid"],
    rowCount = map["rowCount"],
    pageCount = map["pageCount"],
    offset = map["offset"],
    object = map["object"] == null? []: List.from(
      map["object"].map((it) => ProfileHistoryData.fromJsonMap(it)));

  Map<String, dynamic> toJson() {
    return {
      "returnValue": returnValue,
      "message": message,
      "uuid": uuid,
      "rowCount": rowCount,
      "pageCount": pageCount,
      "offset": offset,
      "object": object.map((e) => e.toJson()).toList()
    };
  }
}

class ProfileHistoryData {
  String? uuidTask;
  String? uuidResult;
  String? notes;
  int? createdDate;
  String? jobName;
  String? jobDescription;
  int? fee;
  int? points;
  String? status;
  String? statusQc;
  String? jobTypeName;
  String? uuidJobType;
  String? idMogawers;
  String? jobPicture;
  String? jobBanner;
  String? jobColor;
  String? jobTextColor;
  bool? isDisplayable;

  ProfileHistoryData.fromJsonMap(Map<String, dynamic> map):
        uuidTask = map["uuidTask"],
        uuidResult = map["uuidResult"],
      notes = map["notes"],
      createdDate = map["createdDate"],
      jobName = map["jobName"],
      jobDescription = map["jobDescription"],
      fee = map["fee"],
      points = map["points"],
      status = map["status"],
      statusQc = map["statusQc"],
      jobTypeName = map["jobTypeName"],
      uuidJobType = map["uuidJobType"],
      idMogawers = map["idMogawers"],
      jobPicture = map["jobPicture"],
      jobBanner = map["jobBanner"],
      jobColor = map["jobColor"],
      jobTextColor = map["jobTextColor"],
      isDisplayable = map["isDisplayable"];

  Map<String, dynamic> toJson() {
    return {
      "uuidTask": uuidTask,
      "uuidResult": uuidResult,
      "notes": notes,
      "createdDate": createdDate,
      "jobName": jobName,
      "jobDescription": jobDescription,
      "fee": fee,
      "points": points,
      "status": status,
      "statusQc": statusQc,
      "jobTypeName": jobTypeName,
      "uuidJobType": uuidJobType,
      "idMogawers": idMogawers,
      "jobPicture": jobPicture,
      "jobBanner": jobBanner,
      "jobColor": jobColor,
      "jobTextColor": jobTextColor,
      "isDisplayable": isDisplayable,
    };
  }
}