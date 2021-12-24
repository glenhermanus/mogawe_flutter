import 'package:mogawe/constant/api_path.dart';
import 'package:mogawe/core/data/response/home/ads_model.dart';
import 'package:mogawe/core/data/response/home/ads_response.dart';
import 'package:mogawe/core/data/sources/network/network_service.dart';
import 'package:mogawe/core/data/sources/network/user_network_service.dart';

class HomeRepository extends NetworkService {
  HomeRepository();
  final String token = "token";

  HomeRepository._privateConstructor();
  static final HomeRepository _instance = HomeRepository._privateConstructor();
  static HomeRepository get instance => _instance;

  Future<List<Ads>> getHomeAds(
      {required String realToken}) async {
    var header = {
      token: realToken
    }; //Use realToken when implement get from original token
    var map = await getMethod(
        "${BASE_URL}api/fieldads/home/get?page=1&offset=10", header);
    return AdsResponse.fromJson(map).object;
  }

}