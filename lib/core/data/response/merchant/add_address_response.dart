import 'dart:convert';

import 'address_pickup.dart';

AddAddressResponse addressPickupResponseFromJson(String str) => AddAddressResponse.fromJson(json.decode(str));

String addressPickupResponseToJson(AddAddressResponse data) => json.encode(data.toJson());

class AddAddressResponse {
  AddAddressResponse({
    required this.returnValue,
    required this.message,
    required this.uuid,
    required this.object,
  });

  String? returnValue;
  String message;
  dynamic uuid;
  AddressPickup object;

  factory AddAddressResponse.fromJson(Map<String, dynamic> json) => AddAddressResponse(
    returnValue: json["returnValue"] == null ? "" : json["returnValue"],
    message: json["message"] == null ? "" : json["message"],
    uuid: json["uuid"] == null ? "" : json["uuid"],
    object: AddressPickup.fromJson(json["object"]),
  );

  Map<String, dynamic> toJson() => {
    "returnValue": returnValue,
    "message": message,
    "uuid": uuid,
    "object": object == null ? null : object.toJson(),
  };
}