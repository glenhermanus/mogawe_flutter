class AddressPickupMerchant {

  String returnValue;
  String message;
  dynamic uuid;
  List<ObjectDataAddress> object;

   AddressPickupMerchant.fromJson(Map<String, dynamic> json) :
    returnValue= json["returnValue"],
    message= json["message"],
    uuid= json["uuid"],
    object= List<ObjectDataAddress>.from(json["object"].map((x) => ObjectDataAddress.fromJson(x)));

  Map<String, dynamic> toJson() => {
    "returnValue": returnValue,
    "message": message,
    "uuid": uuid,
    "object": List<dynamic>.from(object.map((x) => x.toJson())),
  };
}

class ObjectDataAddress {

  String uuid;
  String uuidSupplier;
  String supplierName;
  String name;
  String address;
  double latitude;
  double longitude;
  bool isDefault;
  dynamic notes;
  String shipmentProvinceId;
  String shipmentProvinceName;
  String shipmentCityId;
  String shipmentCityName;

   ObjectDataAddress.fromJson(Map<String, dynamic> json) :
    uuid= json["uuid"],
    uuidSupplier= json["uuidSupplier"],
    supplierName= json["supplierName"],
    name= json["name"],
    address= json["address"],
    latitude= json["latitude"].toDouble(),
    longitude= json["longitude"].toDouble(),
    isDefault= json["isDefault"],
    notes= json["notes"],
    shipmentProvinceId= json["shipmentProvinceId"],
    shipmentProvinceName= json["shipmentProvinceName"],
    shipmentCityId= json["shipmentCityId"],
    shipmentCityName= json["shipmentCityName"];

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "uuidSupplier": uuidSupplier,
    "supplierName": supplierName,
    "name": name,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "isDefault": isDefault,
    "notes": notes,
    "shipmentProvinceId": shipmentProvinceId,
    "shipmentProvinceName": shipmentProvinceName,
    "shipmentCityId": shipmentCityId,
    "shipmentCityName": shipmentCityName,
  };
}
