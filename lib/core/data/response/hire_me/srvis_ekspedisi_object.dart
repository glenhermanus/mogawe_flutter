import 'package:mogawe/core/data/response/hire_me/servis_ekspedisi_costs.dart';

class ServisEkspedisiObject{
  String? code, name;
  List<ServisEkspedisiCosts> costs;

  ServisEkspedisiObject({this.code, this.name, required this.costs});

  factory ServisEkspedisiObject.fromJson(Map<String, dynamic> json){
    return ServisEkspedisiObject(
      code: json['code'],
      name: json['name'],
      costs: json['costs']!= null ? json['costs'].map<ServisEkspedisiCosts>((json)=> ServisEkspedisiCosts.fromJson(json)).toList()
          : [],
    );
  }
}