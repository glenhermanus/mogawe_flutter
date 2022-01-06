import 'dart:convert';

AddressPickup addressPickupFromJson(String str) => AddressPickup.fromJson(json.decode(str));

String? addressPickupToJson(AddressPickup data) => json.encode(data.toJson());

class AddressPickup {
  AddressPickup({
    required this.uuid,
    required this.uuidSupplier,
    required this.supplierName,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.isDefault,
    required this.notes,
    required this.shipmentProvinceId,
    required this.shipmentProvinceName,
    required this.shipmentCityId,
    required this.shipmentCityName,
  });

  String? uuid;
  String? uuidSupplier;
  String? supplierName;
  String? name;
  String? address;
  double latitude;
  double longitude;
  bool isDefault;
  String? notes;
  String? shipmentProvinceId;
  String? shipmentProvinceName;
  String? shipmentCityId;
  String? shipmentCityName;

  factory AddressPickup.fromJson(Map<String, dynamic> json) => AddressPickup(
    uuid: json["uuid"] == null ? null : json["uuid"],
    uuidSupplier: json["uuidSupplier"] == null ? null : json["uuidSupplier"],
    supplierName: json["supplierName"] == null ? null : json["supplierName"],
    name: json["name"] == null ? null : json["name"],
    address: json["address"] == null ? null : json["address"],
    latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
    longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
    isDefault: json["isDefault"] == null ? null : json["isDefault"],
    notes: json["notes"] == null ? null : json["notes"],
    shipmentProvinceId: json["shipmentProvinceId"] == null ? null : json["shipmentProvinceId"],
    shipmentProvinceName: json["shipmentProvinceName"] == null ? null : json["shipmentProvinceName"],
    shipmentCityId: json["shipmentCityId"] == null ? null : json["shipmentCityId"],
    shipmentCityName: json["shipmentCityName"] == null ? null : json["shipmentCityName"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid == null ? null : uuid,
    "uuidSupplier": uuidSupplier == null ? null : uuidSupplier,
    "supplierName": supplierName == null ? null : supplierName,
    "name": name == null ? null : name,
    "address": address == null ? null : address,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "isDefault": isDefault == null ? null : isDefault,
    "notes": notes == null ? null : notes,
    "shipmentProvinceId": shipmentProvinceId == null ? null : shipmentProvinceId,
    "shipmentProvinceName": shipmentProvinceName == null ? null : shipmentProvinceName,
    "shipmentCityId": shipmentCityId == null ? null : shipmentCityId,
    "shipmentCityName": shipmentCityName == null ? null : shipmentCityName,
  };
}
