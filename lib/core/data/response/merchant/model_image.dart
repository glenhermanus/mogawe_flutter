class ModelGambar{

  String? uuid, uuidProduct, value;
  bool? mainPicture;
  int? sequence;

  ModelGambar(
      {this.uuid,
      this.uuidProduct,
      this.value,
      this.mainPicture,
      this.sequence});

  factory ModelGambar.fromJson(Map<String, dynamic> json) => ModelGambar(
      uuid: json['uuid'],
    uuidProduct: json['uuidProduct'],
    value: json['value'],
    mainPicture: json['mainPicture'],
    sequence: json['sequence']

  );

}