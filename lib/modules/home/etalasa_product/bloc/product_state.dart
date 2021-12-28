import 'package:mogawe/core/data/response/home_content/product_etalasa_model.dart';

abstract class ProductState {}

class InitProductState extends ProductState{}

class ShowLoadingProductState extends ProductState{}

class ShowEmptyListState extends ProductState{}

class ShowListProductState extends ProductState {
  List<ProductModel> list;

  ShowListProductState(this.list);
}

class ShowErrorProductListState extends ProductState {
  String message;

  ShowErrorProductListState(this.message);
}