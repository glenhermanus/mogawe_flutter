class ImageSalesDetail{
  String? uuid, uuidProduct, value;
  int? sequence;
  bool? mainPicture;

  ImageSalesDetail(
      {this.uuid,
      this.uuidProduct,
      this.value,
      this.sequence,
      this.mainPicture});

  factory ImageSalesDetail.fromJson(Map<String, dynamic> json){
    return ImageSalesDetail(
      uuid: json['uuid'],
      uuidProduct: json['uuidProduct'],
      value: json['value'],
      sequence: json['sequence'],
      mainPicture: json['mainPicture']
    );
  }
}