
class CertificateResponse {

  String returnValue;
  String message;
  dynamic uuid;
  int rowCount;
  int pageCount;
  int offset;
  List<Object> object;
  dynamic object2;
  dynamic res;

  CertificateResponse.fromJson(Map<String, dynamic> json) :
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
  Status? status;
  dynamic finalScore;
  int averageScore;
  DateTime? verifiedDate;

  Object.fromJson(Map<String, dynamic> json) :
    uuidResult= json["uuidResult"],
    uuidJob= json["uuidJob"],
    name= json["name"],
    iconUrl= json["iconUrl"],
    status= statusValues.map![json["status"]],
    finalScore= json["finalScore"],
    averageScore= json["averageScore"] == null ? null : json["averageScore"],
    verifiedDate= json["verifiedDate"] == null ? null : DateTime.parse(json["verifiedDate"]);

  Map<String, dynamic> toJson() => {
    "uuidResult": uuidResult,
    "uuidJob": uuidJob,
    "name": name,
    "iconUrl": iconUrl,
    "status": statusValues.reverse![status],
    "finalScore": finalScore,
    "averageScore": averageScore == null ? null : averageScore,
    "verifiedDate": verifiedDate == null ? null : verifiedDate!.toIso8601String(),
  };
}

enum Status { VERIFIED, PENDING }

final statusValues = EnumValues({
  "pending": Status.PENDING,
  "verified": Status.VERIFIED
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
