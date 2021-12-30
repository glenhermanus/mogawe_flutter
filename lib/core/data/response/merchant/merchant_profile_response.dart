
class MerchantProfileResponse {
  String? returnValue;
  String  message;
  dynamic? uuid;
  Object? object;


   MerchantProfileResponse.fromJson(Map<String, dynamic> json):
    returnValue= json["returnValue"],
    message= json["message"],
    uuid= json["uuid"],
    object= json["object"] == null? null: Object.fromJson(json["object"]);


  Map<String, dynamic> toJson() => {
    "returnValue": returnValue,
    "message": message,
    "uuid": uuid,
    "object": object!.toJson(),
  };
}

class Object {

  String? uuid;
  dynamic? uuidUser;
  String? uuidMogawers;
  dynamic? uuidClient;
  String? storeName;
  String? storeAddress;
  String? storePicture;
  double? storeLat;
  double? storeLng;
  dynamic? status;
  String? shipmentProvinceId;
  String? shipmentProvinceName;
  String? shipmentCityId;
  String? shipmentCityName;
  String? shippingExpeditionServices;
  int? selfPickupRadius;
  dynamic? fullName;
  dynamic? phone;
  dynamic? email;
  dynamic? password;
  bool? isActive;

  Object({
    this.uuid,
    this.uuidUser,
    this.uuidMogawers,
    this.uuidClient,
    this.storeName,
    this.storeAddress,
    this.storePicture,
    this.storeLat,
    this.storeLng,
    this.status,
    this.shipmentProvinceId,
    this.shipmentProvinceName,
    this.shipmentCityId,
    this.shipmentCityName,
    this.shippingExpeditionServices,
    this.selfPickupRadius,
    this.fullName,
    this.phone,
    this.email,
    this.password,
    this.isActive,
  });



  factory Object.fromJson(Map<String, dynamic> json) => Object(
    uuid: json["uuid"],
    uuidUser: json["uuidUser"],
    uuidMogawers: json["uuidMogawers"],
    uuidClient: json["uuidClient"],
    storeName: json["storeName"],
    storeAddress: json["storeAddress"],
    storePicture: json["storePicture"]== null ? '' : json["storePicture"],
    storeLat: json["storeLat"].toDouble(),
    storeLng: json["storeLng"].toDouble(),
    status: json["status"],
    shipmentProvinceId: json["shipmentProvinceId"],
    shipmentProvinceName: json["shipmentProvinceName"],
    shipmentCityId: json["shipmentCityId"],
    shipmentCityName: json["shipmentCityName"],
    shippingExpeditionServices: json["shippingExpeditionServices"],
    selfPickupRadius: json["selfPickupRadius"],
    fullName: json["fullName"],
    phone: json["phone"],
    email: json["email"],
    password: json["password"],
    isActive: json["isActive"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "uuidUser": uuidUser,
    "uuidMogawers": uuidMogawers,
    "uuidClient": uuidClient,
    "storeName": storeName,
    "storeAddress": storeAddress,
    "storePicture": storePicture,
    "storeLat": storeLat,
    "storeLng": storeLng,
    "status": status,
    "shipmentProvinceId": shipmentProvinceId,
    "shipmentProvinceName": shipmentProvinceName,
    "shipmentCityId": shipmentCityId,
    "shipmentCityName": shipmentCityName,
    "shippingExpeditionServices": shippingExpeditionServices,
    "selfPickupRadius": selfPickupRadius,
    "fullName": fullName,
    "phone": phone,
    "email": email,
    "password": password,
    "isActive": isActive,
  };
}
