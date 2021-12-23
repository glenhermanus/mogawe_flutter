class ProvinsiObjectResponse{
  String? province_id, province;

  ProvinsiObjectResponse({this.province_id, this.province});

  factory ProvinsiObjectResponse.fromJson(Map<String, dynamic> json){
    return ProvinsiObjectResponse(
      province: json['province'],
      province_id: json['province_id']
    );
  }

}