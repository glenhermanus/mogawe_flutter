class ServisEkspedisCost{
  String? etd, note;
  double? value;

  ServisEkspedisCost({this.etd, this.note, this.value});

  factory ServisEkspedisCost.fromJson(Map<String, dynamic> json){
    return ServisEkspedisCost(
        etd: json[' etd'],
        note: json['note'],
        value: json['value']
    );
  }

}