class ModelGetUuid{
  List<ObjectUuid> object;
  String uuid;

  ModelGetUuid.fromJson(Map<String, dynamic> json) :
        uuid = json['uuid']== null ? '' : json["uuid"],
        object= List<ObjectUuid>.from(json["object"].map((x) => ObjectUuid.fromJson(x)));

}

class ObjectUuid {

  String uuid;

  ObjectUuid.fromJson(Map<String, dynamic> json) :
        uuid= json["uuid"] == null ? '' : json["uuid"];

}