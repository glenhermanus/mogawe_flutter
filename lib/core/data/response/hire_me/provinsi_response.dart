import 'package:mogawe/core/data/response/hire_me/provinsi_object_response.dart';

class ProvinsiResponse{
  String? returnValue, message, uuid;
  List<ProvinsiObjectResponse> object;

  ProvinsiResponse({this.returnValue, this.message, this.uuid, required this.object});

  factory ProvinsiResponse.fromJson(Map<String, dynamic> json){
    return ProvinsiResponse(
      returnValue: json['returnValue'],
      message: json['message'],
      uuid: json['uuid'],
      object: json['object']!= null ? json['object'].map<ProvinsiObjectResponse>((json)=> ProvinsiObjectResponse.fromJson(json)).toList()
          : []
    );
  }

}