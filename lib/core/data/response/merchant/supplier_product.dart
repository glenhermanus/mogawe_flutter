class SupplierProduct {


  String? returnValue;
  String? message;
  dynamic? uuid;
  int? rowCount;
  int? pageCount;
  int? offset;
  List<ObjectDatas>? objectDatas;
  dynamic? objectDatas2;
  dynamic? res;

  SupplierProduct({
    this.returnValue,
    this.message,
    this.uuid,
    this.rowCount,
    this.pageCount,
    this.offset,
    this.objectDatas,
    this.objectDatas2,
    this.res,
  });

  factory SupplierProduct.fromJson(Map<String, dynamic> json) => SupplierProduct(
    returnValue: json["returnValue"],
    message: json["message"],
    uuid: json["uuid"],
    rowCount: json["rowCount"],
    pageCount: json["pageCount"],
    offset: json["offset"],
    objectDatas: json["object"] == null? null: List<ObjectDatas>.from(json["object"].map((x) => ObjectDatas.fromJson(x))),
    res: json["res"],
  );

  Map<String, dynamic> toJson() => {
    "returnValue": returnValue,
    "message": message,
    "uuid": uuid,
    "rowCount": rowCount,
    "pageCount": pageCount,
    "offset": offset,
    "object": List<dynamic>.from(objectDatas!.map((x) => x.toJson())),
    "res": res,
  };
}

class ObjectDatas {


  String? uuid;
  String? uuidCategory;
  String? uuidSupplier;
  String? supplierStoreName;
  int? supplierSelfPickupRadius;
  dynamic? uuidJob;
  String? name;
  String? description;
  String? brand;
  String? uuidSupplierAddress;
  String? supplierAddressName;
  String? supplierAddressAddress;
  dynamic? supplierAddressNotes;
  List<dynamic>? productAddresses;
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
  List<dynamic>? commissions;
  dynamic? images;
  bool? isFavorite;
  bool? isFreeOngkir;
  bool? isShippingTakeaway;
  bool? isShippingOwncourier;
  bool? isShippingExpedition;
  String? shippingExpeditionServices;

  ObjectDatas({
    this.uuid,
    this.uuidCategory,
    this.uuidSupplier,
    this.supplierStoreName,
    this.supplierSelfPickupRadius,
    this.uuidJob,
    this.name,
    this.description,
    this.brand,
    this.uuidSupplierAddress,
    this.supplierAddressName,
    this.supplierAddressAddress,
    this.supplierAddressNotes,
    this.productAddresses,
    this.isDangerous,
    this.weight,
    this.width,
    this.height,
    this.length,
    this.minimumOrder,
    this.condition,
    this.price,
    this.commission,
    this.stock,
    this.youtubeUrl,
    this.isPublished,
    this.imageUrl,
    this.commissions,
    this.images,
    this.isFavorite,
    this.isFreeOngkir,
    this.isShippingTakeaway,
    this.isShippingOwncourier,
    this.isShippingExpedition,
    this.shippingExpeditionServices,
  });

  factory ObjectDatas.fromJson(Map<String, dynamic> json) => ObjectDatas(
    uuid: json["uuid"],
    uuidCategory: json["uuidCategory"],
    uuidSupplier: json["uuidSupplier"],
    supplierStoreName: json["supplierStoreName"],
    supplierSelfPickupRadius: json["supplierSelfPickupRadius"],
    uuidJob: json["uuidJob"],
    name: json["name"],
    description: json["description"],
    brand: json["brand"],
    uuidSupplierAddress: json["uuidSupplierAddress"],
    supplierAddressName: json["supplierAddressName"],
    supplierAddressAddress: json["supplierAddressAddress"],
    supplierAddressNotes: json["supplierAddressNotes"],
    productAddresses: List<dynamic>.from(json["productAddresses"].map((x) => x)),
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
    commissions: List<dynamic>.from(json["commissions"].map((x) => x)),
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
    "productAddresses": List<dynamic>.from(productAddresses!.map((x) => x)),
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
    "commissions": List<dynamic>.from(commissions!.map((x) => x)),
    "images": images,
    "isFavorite": isFavorite,
    "isFreeOngkir": isFreeOngkir,
    "isShippingTakeaway": isShippingTakeaway,
    "isShippingOwncourier": isShippingOwncourier,
    "isShippingExpedition": isShippingExpedition,
    "shippingExpeditionServices": shippingExpeditionServices,
  };
}
