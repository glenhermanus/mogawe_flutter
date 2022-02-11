class UpdatePasswordResponse{
  String returnValue, message, uuid;

  UpdatePasswordResponse.fromJson(Map<String, dynamic> json):
      returnValue = json['returnValue'],
      message = json['message'],
      uuid = json['uuid'] == null? '' : json["uuid"];
}