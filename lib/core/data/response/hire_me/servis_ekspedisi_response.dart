import 'package:mogawe/core/data/response/hire_me/srvis_ekspedisi_object.dart';

class ServisEkspedisiResponse{
  String? returnValue, message, uuid;
  List<ServisEkspedisiObject> object;

  ServisEkspedisiResponse(
      {this.returnValue, this.message, this.uuid, required this.object});

  factory ServisEkspedisiResponse.fromJson(Map<String, dynamic> json){
    return ServisEkspedisiResponse(
        uuid: json['uuid'],
        returnValue: json['returnValue'],
        message: json['message'],
        object: json['object']!= null ? json['object'].map<ServisEkspedisiObject>((json)=> ServisEkspedisiObject.fromJson(json)).toList()
            : [],
    );
  }

}