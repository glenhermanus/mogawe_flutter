import 'dart:convert';

import 'package:mogawe/core/data/response/ewallet/ewallet_model.dart';
import 'package:mogawe/core/data/response/merchant/address_pickup.dart';

AddressPickupResponse addressPickupResponseFromJson(String str) => AddressPickupResponse.fromJson(json.decode(str));

String addressPickupResponseToJson(AddressPickupResponse data) => json.encode(data.toJson());

class AddressPickupResponse {
  AddressPickupResponse({
    required this.returnValue,
    required this.message,
    required this.uuid,
    required this.object,
  });

  String returnValue;
  String message;
  dynamic uuid;
  List<AddressPickup> object;

  factory AddressPickupResponse.fromJson(Map<String, dynamic> json) => AddressPickupResponse(
    returnValue: json["returnValue"],
    message: json["message"],
    uuid: json["uuid"],
    object: List<AddressPickup>.from(json["object"].map((x) => AddressPickup.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "returnValue": returnValue,
    "message": message,
    "uuid": uuid,
    "object": List<dynamic>.from(object.map((x) => x.toJson())),
  };
}