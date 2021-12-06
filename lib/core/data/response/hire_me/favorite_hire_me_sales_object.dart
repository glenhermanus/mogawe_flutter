class FavHireMeSalesResponsesObject{
  String? uuidobj, uuidClient, uuidCategory, uuidJob, uuidSupplier, brand,
      name, condition, category, desc, images, imageUrl, youtubeUrl, shippingExpeditionServices;
  int? minimumOrder;
  bool? isDangerous, stock, isPublished, isFavorite, isFreeOngkir, isShippingTakeaway, isShippingOwncourier, isShippingExpedition;
  double? weight, width, height, length, price, commission;
  List? commissions;

  FavHireMeSalesResponsesObject(
      {
        this.uuidobj,
        this.uuidClient,
        this.uuidCategory,
        this.uuidJob,
        this.brand,
        this.commission,
        this.commissions,
        this.condition,
        this.name,
        this.isShippingOwncourier,
        this.category,
        this.price,
        this.desc,
        this.shippingExpeditionServices,
        this.stock,
        this.images,
        this.imageUrl,
        this.isDangerous,
        this.isFavorite,
        this.isFreeOngkir,
        this.width,
        this.length,
        this.height,
        this.isPublished,
        this.isShippingExpedition,
        this.isShippingTakeaway,
        this.minimumOrder,
        this.uuidSupplier,
        this.weight,
        this.youtubeUrl});

  factory FavHireMeSalesResponsesObject.fromJson(Map<String, dynamic> json){
    return FavHireMeSalesResponsesObject(
      uuidobj: json['uuid'],
      uuidClient: json['uuidClient'],
      uuidCategory: json['uuidCategory'],
      uuidJob: json['uuidJob'],
      stock: json['stock'],
      uuidSupplier: json['uuidSupplier'],
      brand: json['brand'],
      isShippingTakeaway:  json['isShippingTakeaway'],
      isShippingExpedition: json['isShippingExpedition'],
      name: json['name'],
      condition: json['condition'],
      category: json['category'],
      commissions: json['commissions'],
      desc: json['description'],
      commission: json['commission'],
      imageUrl: json['imageUrl'],
      isPublished: json['isPublished'],
      isFreeOngkir: json['isFreeOngkir'],
      isFavorite: json['isFavorite'],
      images: json['images'],
      isDangerous: json['isDangerous'],
      isShippingOwncourier: json['isShippingOwncourier'],
      width: json['width'],
      weight: json['weight'],
      length: json['length'],
      youtubeUrl: json['youtubeUrl'],
      shippingExpeditionServices: json['shippingExpeditionServices'],
      price: json['price'],
      minimumOrder: json['minimumOrder'],
      height: json['height'],

    );
  }

}