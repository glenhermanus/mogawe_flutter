
import 'package:mogawe/core/data/response/hire_me/image_sales_detail.dart';

class SalesDetailResponses{
  String? returnValue, message, uuid, uuidobj, uuidClient, uuidCategory, uuidJob, uuidSupplier, brand,
      name, condition, category, desc, imageUrl, youtubeUrl, shippingExpeditionServices;
  int? minimumOrder;
  bool? isDangerous, stock, isPublished, isFavorite, isFreeOngkir, isShippingTakeaway, isShippingOwncourier, isShippingExpedition;
  double? weight, width, height, length, price, commission;
  List? commissions;
  List<ImageSalesDetail> images;

  SalesDetailResponses(
      {this.returnValue,
        this.message,
        this.uuid,
        this.uuidobj,
        this.uuidCategory,
        this.uuidJob,
        this.brand,
        this.commission,
        this.commissions,
        this.condition,
        this.name,
        this.isShippingOwncourier,
        this.price,
        this.desc,
        this.shippingExpeditionServices,
        this.stock,
       required this.images,
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
        this.youtubeUrl
      });

  factory SalesDetailResponses.fromJson(Map<String, dynamic> json){
    return SalesDetailResponses(
        returnValue : json['returnValue'],
        message : json['message'],
        uuid : json['uuid'],
      uuidobj: json['object']['uuid'],
      uuidCategory: json['object']['uuidCategory'],
      uuidJob: json['object']['uuidJob'],
      stock: json['object']['stock'],
      uuidSupplier: json['object']['uuidSupplier'],
      brand: json['object']['brand'],
      isShippingTakeaway:  json['object']['isShippingTakeaway'],
      isShippingExpedition: json['object']['isShippingExpedition'],
      name: json['object']['name'],
      condition: json['object']['condition'],
      commissions: json['object']['commissions'],
      desc: json['object']['description'],
      commission: json['object']['commission'],
      imageUrl: json['object']['imageUrl'],
      isPublished: json['object']['isPublished'],
      isFreeOngkir: json['object']['isFreeOngkir'],
      isFavorite: json['object']['isFavorite'],
      images: json['object']['images'].map<ImageSalesDetail>((json)=> ImageSalesDetail.fromJson(json)).toList(),
      isDangerous: json['object']['isDangerous'],
      isShippingOwncourier: json['object']['isShippingOwncourier'],
      width: json['object']['width'],
      weight: json['object']['weight'],
      length: json['object']['length'],
      youtubeUrl: json['object']['youtubeUrl'],
      shippingExpeditionServices: json['object']['shippingExpeditionServices'],
      price: json['object']['price'],
      minimumOrder: json['object']['minimumOrder'],
      height: json['object']['height'],
    );
  }

}