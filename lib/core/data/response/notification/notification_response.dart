class NotificationResponse {

  String returnValue;
  String message;
  dynamic uuid;
  int rowCount;
  int pageCount;
  int offset;
  List<Object> object;

  NotificationResponse.fromJson(Map<String, dynamic> json) :
    returnValue= json["returnValue"],
    message= json["message"],
    uuid= json["uuid"],
    rowCount= json["rowCount"],
    pageCount= json["pageCount"],
    offset= json["offset"],
    object= List<Object>.from(json["object"].map((x) => Object.fromJson(x)));


  Map<String, dynamic> toJson() => {
    "returnValue": returnValue,
    "message": message,
    "uuid": uuid,
    "rowCount": rowCount,
    "pageCount": pageCount,
    "offset": offset,
    "object": List<dynamic>.from(object.map((x) => x.toJson())),

  };
}

class Object {

  String uuid;
  String sessionUuid;
  String title;
  String message;
  String type;
  String idMogawers;
  dynamic references;
  String createdDate;
  String createdBy;
  dynamic updatedDate;
  dynamic updatedBy;

  Object.fromJson(Map<String, dynamic> json) :
    uuid= json["uuid"],
    sessionUuid= json["sessionUuid"],
    title= json["title"],
    message=json["message"],
    type= json["type"] == null ? '' : json["type"],
    idMogawers= json["idMogawers"],
    references= json["references"],
    createdDate=  json["createdDate"],
    createdBy= json["createdBy"],
    updatedDate= json["updatedDate"],
    updatedBy= json["updatedBy"];

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "sessionUuid": sessionUuid,
    "title": title,
    "message": message,
    "type": type == null ? '': type,
    "idMogawers": idMogawers,
    "references": references,
    "createdDate": createdDate,
    "createdBy": createdBy,
    "updatedDate": updatedDate,
    "updatedBy": updatedBy,
  };
}



