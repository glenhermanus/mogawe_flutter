import 'package:mogawe/constant/api_path.dart';
import 'package:mogawe/core/data/response/ewallet/ewallet_model.dart';
import 'package:mogawe/core/data/response/ewallet/ewallet_response.dart';
import 'package:mogawe/core/data/response/ewallet/nominal/ewallet_nominal_model.dart';
import 'package:mogawe/core/data/response/ewallet/nominal/ewallet_nominal_response.dart';
import 'package:mogawe/core/data/response/wallet/wallet_history_model.dart';
import 'package:mogawe/core/data/response/wallet/wallet_history_response.dart';
import 'package:mogawe/core/data/sources/network/network_service.dart';

class WalletRepository extends NetworkService {
  WalletRepository();

  WalletRepository._privateConstructor();
  static final WalletRepository _instance =
      WalletRepository._privateConstructor();
  static WalletRepository get instance => _instance;

  Map<String, String> header = Map();
  final String contentType = "Content-Type";
  final String applicationJson = "application/json; charset=UTF-8";
  final String token = "token";

  Future<List<WalletHistoryModel>> getProfileHistory(
      {String? realToken,
      String? page,
      String? dateFrom,
      String? dateTo}) async {
    print(realToken);
    var header = {
      token: realToken!
    }; //Use realToken when implement get from original token
    var map = await getMethod(
        "${BASE_URL}api/mogawers/transaction/history?"
        "page=${page ?? "1"}&offset=20&dateFrom=${dateFrom ?? "2018-01-01"}&dateFrom=${dateTo ?? "2021-12-12"}",
        header);
    return WalletHistoryResponse.fromJson(map).object;
  }

  Future<List<EWalletNominalModel>> getEWalletNominal(
      {required String realToken}) async {
    print("$realToken ASEKKKKKKK");
    var header = {
      token: realToken
    }; //Use realToken when implement get from original token
    var map = await getMethod(
        "${BASE_URL}api/fieldtransfer/order/mp/linkaja/get", header);
    return EWalletNominalResponse.fromJson(map).object;
  }

  Future<List<EWalletModel>> getEWalletList({
    String? page,
    required String realToken,
  }) async {
    print("$realToken BABABABABA");
    var header = {token: realToken};
    var map = await getMethod(
        "${BASE_URL}api/fieldtransfer/account/get?type=ewallet&page=${page ?? "1"}&offset=10",
        header);
    return EWalletResponse.fromJson(map).object;
  }
}
