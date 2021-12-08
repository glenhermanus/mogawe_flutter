class CategoryListObject{
  String? uuid, name;

  CategoryListObject({this.uuid, this.name});
  factory CategoryListObject.fromJson(Map<String, dynamic> json){
    return CategoryListObject(
       uuid: json['uuid'],
      name: json['name']
    );
  }

}