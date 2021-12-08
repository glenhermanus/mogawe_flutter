import 'package:mogawe/core/data/response/hire_me/category_list_object.dart';

class CategoryListResponse{
  String? returnValue, message, uuid, uuidcategory, name;
  List<CategoryListObject>? object;

  CategoryListResponse({
    this.returnValue,
    this.message,
    this.uuid,
    this.object});

  factory CategoryListResponse.fromJson(Map<String, dynamic> json){
    return CategoryListResponse(
      returnValue: json['returnValue'],
      message: json['message'],
      uuid: json['uuid'],
      object: json['object'] != null ? json['object'].map<CategoryListObject>((json)=> CategoryListObject.fromJson(json)).toList()
          : []
    );
  }

}