class ShipmentCityObject{
  String? city_id, province_id, province, type, city_name, postal_code;

  ShipmentCityObject(
      {this.city_id,
      this.province_id,
      this.province,
      this.type,
      this.city_name,
      this.postal_code});

  factory ShipmentCityObject.fromJson(Map<String, dynamic> json){
    return ShipmentCityObject(
      city_id: json['city_id'],
      province_id: json['province_id'],
      province: json['province'],
      type: json['type'],
      city_name: json['city_name'],
      postal_code: json['postal_code']
    );
  }
}