import 'package:mogawe/core/data/response/hire_me/servis_ekspedisi_cost.dart';

class ServisEkspedisiCosts{
  String? service, description;
  List<ServisEkspedisCost> cost;

  ServisEkspedisiCosts({this.service, this.description, required this.cost});
  factory ServisEkspedisiCosts.fromJson(Map<String, dynamic> json){
    return ServisEkspedisiCosts(
      service: json['service'],
      description: json['description'],
      cost: json['cost']!= null ? json['cost'].map<ServisEkspedisCost>((json)=> ServisEkspedisCost.fromJson(json)).toList()
          : [],
    );
  }
}