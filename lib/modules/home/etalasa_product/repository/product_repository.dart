import 'package:mogawe/core/data/sources/network/network_service.dart';

class ProductRepository extends NetworkService {
  ProductRepository();

  ProductRepository._privateConstructor();
  static final ProductRepository _instance =
      ProductRepository._privateConstructor();
  static ProductRepository get instance => _instance;

  final String contentType = "Content-Type";
  final String applicationJson = "application/json; charset=UTF-8";
  final String token = "token";

  

}