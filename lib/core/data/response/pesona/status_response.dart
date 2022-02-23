
class StatusCertificateResponse {

  String returnValue;
  String message;
  dynamic uuid;
  int rowCount;
  int pageCount;
  int offset;
  List<Object> object;
  dynamic object2;
  dynamic res;

  StatusCertificateResponse.fromJson(Map<String, dynamic> json) :
    returnValue= json["returnValue"],
    message= json["message"],
    uuid= json["uuid"],
    rowCount= json["rowCount"],
    pageCount= json["pageCount"],
    offset= json["offset"],
    object= List<Object>.from(json["object"].map((x) => Object.fromJson(x))),
    object2= json["object2"],
    res= json["res"];

  Map<String, dynamic> toJson() => {
    "returnValue": returnValue,
    "message": message,
    "uuid": uuid,
    "rowCount": rowCount,
    "pageCount": pageCount,
    "offset": offset,
    "object": List<dynamic>.from(object.map((x) => x.toJson())),
    "object2": object2,
    "res": res,
  };
}

class Object {

  String uuidResult;
  String uuidJob;
  String name;
  String iconUrl;
  String status;
  dynamic finalScore;
  int averageScore;
  dynamic verifiedDate;

  Object.fromJson(Map<String, dynamic> json) :
    uuidResult= json["uuidResult"],
    uuidJob= json["uuidJob"],
    name= json["name"],
    iconUrl= json["iconUrl"],
    status= json["status"],
    finalScore= json["finalScore"],
    averageScore= json["averageScore"] == null ? null : json["averageScore"],
    verifiedDate= json["verifiedDate"];

  Map<String, dynamic> toJson() => {
    "uuidResult": uuidResult,
    "uuidJob": uuidJob,
    "name": name,
    "iconUrl": iconUrl,
    "status": status,
    "finalScore": finalScore,
    "averageScore": averageScore == null ? null : averageScore,
    "verifiedDate": verifiedDate,
  };
}
