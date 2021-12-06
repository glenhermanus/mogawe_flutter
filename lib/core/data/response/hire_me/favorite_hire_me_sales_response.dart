import 'package:mogawe/core/data/response/hire_me/favorite_hire_me_sales_object.dart';
import 'package:mogawe/core/data/response/hire_me/hire_me_sales_object.dart';
import 'package:mogawe/core/data/response/pesona/pesona_response_object.dart';

class FavHireMeSalesResponses{
  String? returnValue, message, uuid;
  int? rowCount, pageCount, offset;
  List<FavHireMeSalesResponsesObject> object;

  FavHireMeSalesResponses(
      {this.returnValue,
        this.message,
        this.uuid,
        this.offset,
        this.pageCount,
        this.rowCount,
        required this.object,
      });

  factory FavHireMeSalesResponses.fromJson(Map<String, dynamic> json){
    return FavHireMeSalesResponses(
        returnValue : json['returnValue'],
        message : json['message'],
        uuid : json['uuid'],
        rowCount: json['rowCount'],
        pageCount: json['pageCount'],
        offset: json['offset'],
        object: json['object'] != null ? json['object'].map<FavHireMeSalesResponsesObject>((json)=> FavHireMeSalesResponsesObject.fromJson(json)).toList()
            : []
    );
  }

}