
class CountStatusResponse {

  String returnValue;
  String message;
  dynamic uuid;
  List<ObjectC> object;
  dynamic object2;

  CountStatusResponse.fromJson(Map<String, dynamic> json) :
    returnValue= json["returnValue"],
    message= json["message"],
    uuid= json["uuid"],
    object= List<ObjectC>.from(json["object"].map((x) => ObjectC.fromJson(x))),
    object2= json["object2"];

    Map<String, dynamic> toJson() => {
    "returnValue": returnValue,
    "message": message,
    "uuid": uuid,
    "object": List<dynamic>.from(object.map((x) => x.toJson())),
    "object2": object2,
  };
}

class ObjectC {

  String name;
  int count;
  String value;

  ObjectC.fromJson(Map<String, dynamic> json) :
    name= json["name"],
    count= json["count"],
    value= json["value"] == null ? null : json["value"];

  Map<String, dynamic> toJson() => {
    "name": name,
    "count": count,
    "value": value == null ? null : value,
  };
}
