class SellerAddress{
  String? returnValue, message, uuid, uuidobj, uuidSupplier, supplierName, name, address, shipmentProvinceId, shipmentProvinceName,
  shipmentCityId, shipmentCityName;

  SellerAddress(
      {this.returnValue,
      this.message,
      this.uuid,
      this.uuidobj,
      this.uuidSupplier,
      this.supplierName,
      this.name,
      this.address,
      this.shipmentProvinceId,
      this.shipmentProvinceName,
      this.shipmentCityId,
      this.shipmentCityName});

  factory SellerAddress.fromJson(Map<String, dynamic> json){
    return SellerAddress(
         returnValue: json['returnValue'],
         message: json['message'],
         uuid: json['uuid'],
         uuidobj: json['object']['uuid'],
         uuidSupplier: json['object']['uuidSupplier'],
         supplierName: json['object']['supplierName'],
         name: json['object']['name'],
         address: json['object']['address'],
         shipmentProvinceId: json['object']['shipmentProvinceId'],
         shipmentProvinceName: json['object']['shipmentProvinceName'],
         shipmentCityId: json['object']['shipmentCityId'],
         shipmentCityName: json['object']['shipmentCityName'],
    );
  }

}