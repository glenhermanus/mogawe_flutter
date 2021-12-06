import 'package:mogawe/core/data/response/hire_me/hire_me_sales_object.dart';
import 'package:mogawe/core/data/response/pesona/pesona_response_object.dart';

class HireMeSalesResponses{
  String? returnValue, message, uuid;
  int? rowCount, pageCount, offset;
  List<HireMeSalesResponsesObject> object;

  HireMeSalesResponses(
      {this.returnValue,
        this.message,
        this.uuid,
        this.offset,
        this.pageCount,
        this.rowCount,
        required this.object,
      });

  factory HireMeSalesResponses.fromJson(Map<String, dynamic> json){
    return HireMeSalesResponses(
        returnValue : json['returnValue'],
        message : json['message'],
        uuid : json['uuid'],
        rowCount: json['rowCount'],
        pageCount: json['pageCount'],
        offset: json['offset'],
        object: json['object'] != null ? json['object'].map<HireMeSalesResponsesObject>((json)=> HireMeSalesResponsesObject.fromJson(json)).toList()
            : []
    );
  }

}