import 'package:mogawe/core/data/response/hire_me/favorite_hire_me_sales_object.dart';
import 'package:mogawe/core/data/response/hire_me/hire_me_sales_object.dart';
import 'package:mogawe/core/data/response/merchant/address_pickup.dart';
import 'package:mogawe/core/data/response/pesona/certificate_response.dart';
import 'package:mogawe/core/data/response/pesona/pesona_response.dart';
import 'package:mogawe/core/data/response/pesona/pesona_response_object.dart';
import 'package:mogawe/core/data/response/profile/profile_response.dart';

abstract class SalesState {}

class InitSalesState extends SalesState {}

class ShowLoadingSalesState extends SalesState {}

class ShowLoadingFavoriteState extends SalesState {}

class ShowListSalesState extends SalesState {
  List<HireMeSalesResponsesObject> data;

  ShowListSalesState(this.data);
}

class ShowListFavoriteState extends SalesState {
  List<FavHireMeSalesResponsesObject> data;

  ShowListFavoriteState(this.data);
}

class ShowEmptyListSalesState extends SalesState {}

class ShowEmptyListFavoriteState extends SalesState {}

class ShowErrorSalesState extends SalesState {
  String message;

  ShowErrorSalesState(this.message);
}

class ShowErrorFavoriteState extends SalesState {
  String message;

  ShowErrorFavoriteState(this.message);
}



