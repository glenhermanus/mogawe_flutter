class ProductAddress {
    ProductAddress({
        required this.uuidProduct,
        required this.uuidSupplierAddress,
        required this.supplierAddressName,
        required this.supplierAddressAddress,
        required this.supplierAddressNotes,
        required this.supplierAddressShipmentProvinceId,
        required this.supplierAddressShipmentProvinceName,
        required this.supplierAddressShipmentCityId,
        required this.supplierAddressShipmentCityName,
    });

    String uuidProduct;
    String uuidSupplierAddress;
    String supplierAddressName;
    String supplierAddressAddress;
    dynamic supplierAddressNotes;
    int supplierAddressShipmentProvinceId;
    String supplierAddressShipmentProvinceName;
    int supplierAddressShipmentCityId;
    String supplierAddressShipmentCityName;

    factory ProductAddress.fromJson(Map<String, dynamic> json) => ProductAddress(
        uuidProduct: json["uuidProduct"],
        uuidSupplierAddress: json["uuidSupplierAddress"],
        supplierAddressName: json["supplierAddressName"],
        supplierAddressAddress: json["supplierAddressAddress"],
        supplierAddressNotes: json["supplierAddressNotes"],
        supplierAddressShipmentProvinceId: json["supplierAddressShipmentProvinceId"],
        supplierAddressShipmentProvinceName: json["supplierAddressShipmentProvinceName"],
        supplierAddressShipmentCityId: json["supplierAddressShipmentCityId"],
        supplierAddressShipmentCityName: json["supplierAddressShipmentCityName"],
    );

    Map<String, dynamic> toJson() => {
        "uuidProduct": uuidProduct,
        "uuidSupplierAddress": uuidSupplierAddress,
        "supplierAddressName": supplierAddressName,
        "supplierAddressAddress": supplierAddressAddress,
        "supplierAddressNotes": supplierAddressNotes,
        "supplierAddressShipmentProvinceId": supplierAddressShipmentProvinceId,
        "supplierAddressShipmentProvinceName": supplierAddressShipmentProvinceName,
        "supplierAddressShipmentCityId": supplierAddressShipmentCityId,
        "supplierAddressShipmentCityName": supplierAddressShipmentCityName,
    };
}