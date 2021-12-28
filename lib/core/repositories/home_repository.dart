import 'package:mogawe/constant/api_path.dart';
import 'package:mogawe/core/data/response/gawean/update_reminder_gawean_response.dart';
import 'package:mogawe/core/data/response/home/ads_model.dart';
import 'package:mogawe/core/data/response/home/ads_response.dart';
import 'package:mogawe/core/data/response/home_content/gawean_row_model.dart';
import 'package:mogawe/core/data/response/home_content/widget_row_response.dart';
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

  final String contentType = "Content-Type";
  final String applicationJson = "application/json; charset=UTF-8";

  Future<List<GaweanRowModel>> getHomeContenetRowList(
      {required String realToken,
        String? page,
        String? offset,
        String? latitude,
        String? longitude,}
      ) async {
    var header = {token: realToken};
    var map = await getMethod(
      "${BASE_URL}api/fieldtask/v3/widgetrow/get?page=1&offset=10&lat=-6.44046987091469&lng=106.8603937882579",
      header,
    );
    return WidgetRowResponse.fromJson(map).object;
  }

  Future<UpdateReminderGaweanResponse> updateGaweanReminder(
      String realToken,
      Map<String, String?> body
      ) async {
    var header = {token: realToken, contentType: applicationJson};
    var map = await putMethod(
        "${BASE_URL}api/fieldtask/myTask/updateReminder",
        header: header,
        body: body
    );
    return UpdateReminderGaweanResponse.fromJson(map);
  }

}