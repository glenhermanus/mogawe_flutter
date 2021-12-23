import 'package:intl/intl.dart';
import 'package:mogawe/core/data/response/hire_me/shipment_city_object.dart';

class ShipmentCityResponse{
  String? returnValue, message, uuid;
  List<ShipmentCityObject> object;

  ShipmentCityResponse(
      {this.returnValue, this.message, this.uuid, required this.object});

  factory ShipmentCityResponse.fromJson(Map<String, dynamic> json){
    return ShipmentCityResponse(
      returnValue: json['returnValue'],
      message: json['message'],
      uuid: json['uuid'],
      object: json['object'] != null ? json['object'].map<ShipmentCityObject>((json)=> ShipmentCityObject.fromJson(json)).toList()
          : []
    );
  }

}