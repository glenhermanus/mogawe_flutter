class ShipmentCourier {

  String? returnValue;
  String? message;
  dynamic? uuid;
  List<ObjectShipment>? object;


  ShipmentCourier({
    this.returnValue,
    this.message,
    this.uuid,
    this.object,

  });

  factory ShipmentCourier.fromJson(Map<String, dynamic> json) => ShipmentCourier(
    returnValue: json["returnValue"],
    message: json["message"],
    uuid: json["uuid"],
    object: List<ObjectShipment>.from(json["object"].map((x) => ObjectShipment.fromJson(x))),

  );

  Map<String, dynamic> toJson() => {
    "returnValue": returnValue,
    "message": message,
    "uuid": uuid,
    "object": List<dynamic>.from(object!.map((x) => x.toJson())),
  };
}

class ObjectShipment {

  String? name;
  String? code;

  ObjectShipment({
    this.name,
    this.code,
  });

  factory ObjectShipment.fromJson(Map<String, dynamic> json) => ObjectShipment(
    name: json["name"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "code": code,
  };
}