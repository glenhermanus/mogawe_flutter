import 'dart:convert';

import 'package:mogawe/core/data/response/wallet/wallet_history_model.dart';

WalletHistoryResponse WalletHistoryResponseFromJson(String str) =>
    WalletHistoryResponse.fromJson(json.decode(str));

String WalletHistoryResponseToJson(WalletHistoryResponse data) =>
    json.encode(data.toJson());

class WalletHistoryResponse {
  WalletHistoryResponse({
    required this.returnValue,
    required this.message,
    required this.uuid,
    required this.rowCount,
    required this.pageCount,
    required this.offset,
    required this.object,
  });

  String? returnValue;
  String? message;
  String? uuid;
  int? rowCount;
  int? pageCount;
  int? offset;
  List<WalletHistoryModel> object;

  factory WalletHistoryResponse.fromJson(Map<String, dynamic> json) =>
      WalletHistoryResponse(
          returnValue: json["returnValue"],
          message: json["message"],
          uuid: json["uuid"],
          rowCount: json["rowCount"],
          pageCount: json["pageCount"],
          offset: json["offset"],
          object: json['object'] != null
              ? json['object']
                  .map<WalletHistoryModel>(
                      (json) => WalletHistoryModel.fromJson(json))
                  .toList()
              : []);

  Map<String, dynamic> toJson() => {
        "returnValue": returnValue,
        "message": message,
        "uuid": uuid,
        "rowCount": rowCount,
        "pageCount": pageCount,
        "offset": offset,
      };
}
