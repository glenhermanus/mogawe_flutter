import 'package:mogawe/core/data/response/merchant/model_image.dart';

class SupplierProductDetail{
  String? returnValue;
  String? message;
  dynamic? uuid;
  String? uuidobj;
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
  List<ModelGambar>? images;
  bool? isFavorite;
  bool? isFreeOngkir;
  bool? isShippingTakeaway;
  bool? isShippingOwncourier;
  bool? isShippingExpedition;
  String? shippingExpeditionServices;

  SupplierProductDetail(
      {this.returnValue,
      this.message,
      this.uuid,
      this.uuidobj,
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
      this.shippingExpeditionServices});

  factory SupplierProductDetail.fromJson(Map<String, dynamic> json) => SupplierProductDetail(
    message: json["message"],
    returnValue: json["returnValue"],
    uuid: json["uuid"],
    uuidobj: json["object"]["uuid"],
    uuidCategory: json["object"]["uuidCategory"],
    uuidSupplier: json["object"]["uuidSupplier"],
    supplierStoreName: json["object"]["supplierStoreName"],
    supplierSelfPickupRadius: json["object"]["supplierSelfPickupRadius"],
    uuidJob: json["object"]["uuidJob"],
    name: json["object"]["name"],
    description: json["object"]["description"],
    brand: json["object"]["brand"],
    uuidSupplierAddress: json["object"]["uuidSupplierAddress"],
    supplierAddressName: json["object"]["supplierAddressName"],
    supplierAddressAddress: json["object"]["supplierAddressAddress"],
    supplierAddressNotes: json["object"]["supplierAddressNotes"],
    productAddresses: List<dynamic>.from(json["object"]["productAddresses"].map((x) => x)),
    isDangerous: json["object"]["isDangerous"],
    weight: json["object"]["weight"],
    width: json["object"]["width"],
    height: json["object"]["height"],
    length: json["object"]["length"],
    minimumOrder: json["object"]["minimumOrder"],
    condition: json["object"]["condition"],
    price: json["object"]["price"],
    commission: json["object"]["commission"],
    stock: json["object"]["stock"],
    youtubeUrl: json["object"]["youtubeUrl"],
    isPublished: json["object"]["isPublished"],
    imageUrl: json["object"]["imageUrl"],
    commissions: List<dynamic>.from(json["object"]["commissions"].map((x) => x)),
    images: json["object"]["images"] != null ? json["object"]["images"].map<ModelGambar>((json)=> ModelGambar.fromJson(json)).toList()
        : [],
    isFavorite: json["object"]["isFavorite"],
    isFreeOngkir: json["object"]["isFreeOngkir"],
    isShippingTakeaway: json["object"]["isShippingTakeaway"],
    isShippingOwncourier: json["object"]["isShippingOwncourier"],
    isShippingExpedition: json["object"]["isShippingExpedition"],
    shippingExpeditionServices: json["object"]["shippingExpeditionServices"],
  );


}