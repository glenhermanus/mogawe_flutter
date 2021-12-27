class ProductAddressResponse{
  String? uuid, uuidSupplierAddress, supplierAddressName, supplierAddressAddress, supplierAddressNotes, supplierAddressShipmentProvinceName,supplierAddressShipmentCityName;
  int? supplierAddressShipmentCityId, supplierAddressShipmentProvinceId;

  ProductAddressResponse(
      {this.uuid,
      this.uuidSupplierAddress,
      this.supplierAddressName,
      this.supplierAddressAddress,
      this.supplierAddressNotes,
      this.supplierAddressShipmentProvinceName,
      this.supplierAddressShipmentCityName,
      this.supplierAddressShipmentCityId,
      this.supplierAddressShipmentProvinceId});

  factory ProductAddressResponse.fromJson(Map<String, dynamic> json){
    return ProductAddressResponse(
      supplierAddressName: json['supplierAddressName'],
      supplierAddressAddress: json['supplierAddressAddress'],
      supplierAddressNotes: json['supplierAddressNotes'],
      supplierAddressShipmentCityId: json['supplierAddressShipmentCityId'],
      supplierAddressShipmentCityName: json['supplierAddressShipmentCityName'],
      supplierAddressShipmentProvinceId: json['supplierAddressShipmentProvinceId'],
      supplierAddressShipmentProvinceName: json['supplierAddressShipmentProvinceName'],
    );
  }

}