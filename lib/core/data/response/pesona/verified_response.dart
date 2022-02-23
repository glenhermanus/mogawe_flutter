
class VerifiedStatus {

  String returnValue;
  String message;
  dynamic uuid;
  int rowCount;
  int pageCount;
  int offset;
  List<ObjectVerif> object;


  VerifiedStatus.fromJson(Map<String, dynamic> json) :
        returnValue= json["returnValue"],
        message= json["message"],
        uuid= json["uuid"],
        rowCount= json["rowCount"],
        pageCount= json["pageCount"],
        offset= json["offset"],
        object= json["object"] == null ? [] : List<ObjectVerif>.from(json["object"].map((x) => ObjectVerif.fromJson(x)));

}

class ObjectVerif {

  String uuidResult;
  String uuidJob;
  String name;
  String iconUrl;
  Status? status;
  dynamic finalScore;
  int averageScore;
  DateTime? verifiedDate;

  ObjectVerif.fromJson(Map<String, dynamic> json) :
        uuidResult= json["uuidResult"],
        uuidJob= json["uuidJob"],
        name= json["name"],
        iconUrl= json["iconUrl"],
        status= statusValues.map![json["status"]],
        finalScore= json["finalScore"],
        averageScore= json["averageScore"] == null ? 0 : json["averageScore"],
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
