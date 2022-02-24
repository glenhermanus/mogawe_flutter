import 'package:mogawe/constant/api_path.dart';
import 'package:mogawe/core/data/response/pesona/detail_pesona_response.dart';
import 'package:mogawe/core/data/response/pesona/pesona_response.dart';
import 'package:mogawe/core/data/response/pesona/pesona_response_object.dart';
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

  Future<DetailPesonaResponses> getDetailPersona(String realToken, String uuidJob) async {
    var header = {token: realToken};
    var map = await getMethod(
      "${BASE_URL}api/fieldtask/job/get/$uuidJob",
      header,
    );
    return DetailPesonaResponses.fromJson(map);
  }

}