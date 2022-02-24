import 'package:mogawe/constant/api_path.dart';
import 'package:mogawe/core/data/response/pesona/certificate_response.dart';
import 'package:mogawe/core/data/response/pesona/count_status.dart';
import 'package:mogawe/core/data/response/pesona/expired_response.dart';
import 'package:mogawe/core/data/response/pesona/pending_response.dart';
import 'package:mogawe/core/data/response/pesona/pesona_response.dart';
import 'package:mogawe/core/data/response/pesona/pesona_response_object.dart';
import 'package:mogawe/core/data/response/pesona/verified_response.dart';
import 'package:mogawe/core/data/sources/network/network_service.dart';
import 'package:mogawe/core/data/sources/network/user_network_service.dart';

class PesonaRepository extends NetworkService {
  PesonaRepository();
  final String token = "token";

  PesonaRepository._privateConstructor();
  static final PesonaRepository _instance = PesonaRepository._privateConstructor();
  static PesonaRepository get instance => _instance;

  final UserNetworkService _apiService = UserNetworkService();


  Future<List<PesonaResponsesObject>> getCertification(
      {required String realToken}) async {
    var header = {
      token: realToken
    }; //Use realToken when implement get from original token
    var map = await getMethod(
        "${BASE_URL}api/mogawers/certificate/mine", header);
    return PesonaResponses.fromJson(map).object;
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