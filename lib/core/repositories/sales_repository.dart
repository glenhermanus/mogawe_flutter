import 'package:mogawe/constant/api_path.dart';
import 'package:mogawe/core/data/response/hire_me/favorite_hire_me_sales_object.dart';
import 'package:mogawe/core/data/response/hire_me/favorite_hire_me_sales_response.dart';
import 'package:mogawe/core/data/response/hire_me/hire_me_sales_object.dart';
import 'package:mogawe/core/data/response/hire_me/hire_me_sales_response.dart';
import 'package:mogawe/core/data/response/pesona/certificate_response.dart';
import 'package:mogawe/core/data/response/pesona/count_status.dart';
import 'package:mogawe/core/data/response/pesona/expired_response.dart';
import 'package:mogawe/core/data/response/pesona/pending_response.dart';
import 'package:mogawe/core/data/response/pesona/pesona_response.dart';
import 'package:mogawe/core/data/response/pesona/pesona_response_object.dart';
import 'package:mogawe/core/data/response/pesona/verified_response.dart';
import 'package:mogawe/core/data/sources/network/network_service.dart';

class SalesRepository extends NetworkService {
  SalesRepository();
  final String token = "token";

  SalesRepository._privateConstructor();
  static final SalesRepository _instance = SalesRepository._privateConstructor();
  static SalesRepository get instance => _instance;

  Future<List<HireMeSalesResponsesObject>> hiremeSalesresponse( {required String realToken}) async {
    var header = {
      token: realToken
    };
    var map = await getMethod(
        "${BASE_URL}/api/sales/product/get?page=1&offset=30", header);

    return HireMeSalesResponses.fromJson(map).object;
  }

  Future<List<FavHireMeSalesResponsesObject>> favSalesResponse( {required String realToken}) async {
    var header = {
      token: realToken
    };
    var map = await getMethod(
        "${BASE_URL}/api/sales/product/favorite/get?q=&page=1&offset=20", header);

    return FavHireMeSalesResponses.fromJson(map).object;
  }

  Future<List<Object>> getCertificationList(
      {required String realToken}) async {
    var header = {
      token: realToken
    }; //Use realToken when implement get from original token
    var map = await getMethod(
        "${BASE_URL}api/fieldmogawers/certificate/get", header);
    return CertificateResponse.fromJson(map).object;
  }

  Future<CountStatusResponse> getCountStatus(
      {required String realToken}) async {
    var header = {
      token: realToken
    }; //Use realToken when implement get from original token
    var map = await getMethod(
        "${BASE_URL}api/fieldmogawers/certificate/status/get", header);
    return CountStatusResponse.fromJson(map);
  }

  Future<List<ObjectPending>> getStatusPending(
      {required String realToken}) async {
    var header = {
      token: realToken
    }; //Use realToken when implement get from original token
    var map = await  getMethod(
        "${BASE_URL}api/fieldmogawers/certificate/get?status=pending", header);
    print('ini yaaaaaaa ${map[0]}');
    return PendingStatus.fromJson(map).object;

  }

  Future<List<ObjectVerif>> getStatusVerif(
      {required String realToken}) async {
    var header = {
      token: realToken
    }; //Use realToken when implement get from original token
    var map = await  getMethod(
        "${BASE_URL}api/fieldmogawers/certificate/get?status=verified", header);
    print('ini yaaaaaaa ${map[0]}');
    return VerifiedStatus.fromJson(map).object;

  }

  Future<List<ObjectExpired>> getStatusExpired(
      {required String realToken}) async {
    var header = {
      token: realToken
    }; //Use realToken when implement get from original token
    var map = await  getMethod(
        "${BASE_URL}api/fieldmogawers/certificate/get?status=expired", header);
    print('ini yaaaaaaa ${map[0]}');
    return ExpiredStatus.fromJson(map).object;

  }

}