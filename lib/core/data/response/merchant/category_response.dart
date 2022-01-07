class CategoryResponse{
  String? returnValue, message, uuid, uuidObj, name;

  CategoryResponse(
      {this.returnValue, this.message, this.uuid, this.uuidObj, this.name});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) => CategoryResponse(
  message: json["message"],
  returnValue: json["returnValue"],
  uuid: json["uuid"],
  uuidObj: json["object"]["uuid"],
    name: json["object"]["name"]

  );

}