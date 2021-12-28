import 'package:mogawe/core/data/response/home_content/product_address_model.dart';

class ProductModel {
    ProductModel({
        required this.uuid,
        required this.uuidCategory,
        required this.uuidSupplier,
        required this.supplierStoreName,
        required this.supplierSelfPickupRadius,
        required this.uuidJob,
        required this.name,
        required this.description,
        required this.brand,
        required this.uuidSupplierAddress,
        required this.supplierAddressName,
        required this.supplierAddressAddress,
        required this.supplierAddressNotes,
        required this.productAddresses,
        required this.isDangerous,
        required this.weight,
        required this.width,
        required this.height,
        required this.length,
        required this.minimumOrder,
        required this.condition,
        required this.price,
        required this.commission,
        required this.stock,
        required this.youtubeUrl,
        required this.isPublished,
        required this.imageUrl,
        required this.commissions,
        required this.images,
        required this.isFavorite,
        required this.isFreeOngkir,
        required this.isShippingTakeaway,
        required this.isShippingOwncourier,
        required this.isShippingExpedition,
        required this.shippingExpeditionServices,
    });

    String uuid;
    String? uuidCategory;
    String? uuidSupplier;
    dynamic supplierStoreName;
    dynamic supplierSelfPickupRadius;
    dynamic uuidJob;
    String? name;
    String? description;
    String? brand;
    dynamic uuidSupplierAddress;
    dynamic supplierAddressName;
    dynamic supplierAddressAddress;
    dynamic supplierAddressNotes;
    List<ProductAddress> productAddresses;
    bool? isDangerous;
    double? weight;
    double? width;
    double? height;
    double? length;
    int? minimumOrder;
    String? condition;
    double? price;
    double? commission;
    bool? stock;
    String? youtubeUrl;
    bool? isPublished;
    String? imageUrl;
    dynamic commissions;
    dynamic images;
    bool? isFavorite;
    bool? isFreeOngkir;
    bool? isShippingTakeaway;
    bool? isShippingOwncourier;
    bool? isShippingExpedition;
    String? shippingExpeditionServices;

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        uuid: json["uuid"] == null ? null : json["uuid"],
        uuidCategory: json["uuidCategory"] == null ? null : json["uuidCategory"],
        uuidSupplier: json["uuidSupplier"] == null ? null : json["uuidSupplier"],
        supplierStoreName: json["supplierStoreName"] == null ? null : json["supplierStoreName"],
        supplierSelfPickupRadius: json["supplierSelfPickupRadius"] == null ? null : json["supplierSelfPickupRadius"],
        uuidJob: json["uuidJob"],
        name: json["name"],
        description: json["description"],
        brand: json["brand"],
        uuidSupplierAddress: json["uuidSupplierAddress"],
        supplierAddressName: json["supplierAddressName"],
        supplierAddressAddress: json["supplierAddressAddress"],
        supplierAddressNotes: json["supplierAddressNotes"],
        productAddresses: List<ProductAddress>.from(json["productAddresses"].map((x) => ProductAddress.fromJson(x))),
        isDangerous: json["isDangerous"],
        weight: json["weight"],
        width: json["width"],
        height: json["height"],
        length: json["length"],
        minimumOrder: json["minimumOrder"],
        condition: json["condition"],
        price: json["price"],
        commission: json["commission"],
        stock: json["stock"],
        youtubeUrl: json["youtubeUrl"],
        isPublished: json["isPublished"],
        imageUrl: json["imageUrl"],
        commissions: json["commissions"],
        images: json["images"],
        isFavorite: json["isFavorite"],
        isFreeOngkir: json["isFreeOngkir"],
        isShippingTakeaway: json["isShippingTakeaway"],
        isShippingOwncourier: json["isShippingOwncourier"],
        isShippingExpedition: json["isShippingExpedition"],
        shippingExpeditionServices: json["shippingExpeditionServices"],
    );

    Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "uuidCategory": uuidCategory,
        "uuidSupplier": uuidSupplier,
        "supplierStoreName": supplierStoreName,
        "supplierSelfPickupRadius": supplierSelfPickupRadius,
        "uuidJob": uuidJob,
        "name": name,
        "description": description,
        "brand": brand,
        "uuidSupplierAddress": uuidSupplierAddress,
        "supplierAddressName": supplierAddressName,
        "supplierAddressAddress": supplierAddressAddress,
        "supplierAddressNotes": supplierAddressNotes,
        "productAddresses": List<ProductAddress>.from(productAddresses.map((x) => x.toJson())),
        "isDangerous": isDangerous,
        "weight": weight,
        "width": width,
        "height": height,
        "length": length,
        "minimumOrder": minimumOrder,
        "condition": condition,
        "price": price,
        "commission": commission,
        "stock": stock,
        "youtubeUrl": youtubeUrl,
        "isPublished": isPublished,
        "imageUrl": imageUrl,
        "commissions": commissions,
        "images": images,
        "isFavorite": isFavorite,
        "isFreeOngkir": isFreeOngkir,
        "isShippingTakeaway": isShippingTakeaway,
        "isShippingOwncourier": isShippingOwncourier,
        "isShippingExpedition": isShippingExpedition,
        "shippingExpeditionServices": shippingExpeditionServices,
    };
}