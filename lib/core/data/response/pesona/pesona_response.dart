import 'package:mogawe/core/data/response/pesona/pesona_response_object.dart';

class PesonaResponses{
  String? returnValue, message, uuid, uuidobj, uuidClient, uuidCategory, uuidJob, questName, howto, tutorial, jobpic,
      name, code, category, categroyname, desc, instruction, iconUrl, status, uuidquest;
  int? potentialJob;
  double? minimumjob;
  List<PesonaResponsesObject> object;

  PesonaResponses(
      {this.returnValue,
        this.message,
        this.uuid,
        this.uuidobj,
        this.uuidClient,
        this.uuidCategory,
        this.uuidJob,
        this.questName,
        this.howto,
        this.tutorial,
        this.jobpic,
        this.name,
        this.code,
        this.category,
        this.categroyname,
        this.desc,
        this.instruction,
        this.iconUrl,
        this.status,
        this.uuidquest,
        this.potentialJob,
        required this.object,
        this.minimumjob});

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