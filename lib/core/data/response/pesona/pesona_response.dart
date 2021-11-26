import 'package:mogawe/core/data/response/pesona/pesona_response_object.dart';

class PesonaResponses{
  String? returnValue, message, uuid;
  List<PesonaResponsesObject> object;

  PesonaResponses(
      {this.returnValue,
        this.message,
        this.uuid,
        required this.object,
        });

  factory PesonaResponses.fromJson(Map<String, dynamic> json){
    return PesonaResponses(
        returnValue : json['returnValue'],
        message : json['message'],
        uuid : json['uuid'],
      object: json["object"] != null ? json["object"].map<PesonaResponsesObject>((json)=> PesonaResponsesObject.fromJson(json)).toList()
          : []
    );
  }

}