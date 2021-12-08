import 'dart:convert';

WalletHistoryModel WalletHistoryModelFromJson(String str) =>
    WalletHistoryModel.fromJson(json.decode(str));

String WalletHistoryModelToJson(WalletHistoryModel data) =>
    json.encode(data.toJson());

class WalletHistoryModel {
  WalletHistoryModel({
    required this.total,
    required this.receivedDate,
    required this.trxType,
    required this.trxTime,
    required this.trxCategory,
    required this.description,
  });

  double total;
  String receivedDate;
  String trxType;
  DateTime trxTime;
  String trxCategory;
  String description;

  factory WalletHistoryModel.fromJson(Map<String, dynamic> json) =>
      WalletHistoryModel(
        total: json["total"] ?? 0.0,
        receivedDate: json["receivedDate"] ?? "",
        trxType: json["trxType"] ?? "",
        trxTime: DateTime.parse(json["trxTime"]),
        trxCategory: json["trxCategory"] ?? "",
        description: json["description"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "receivedDate": receivedDate,
        "trxType": trxType,
        "trxTime": trxTime.toIso8601String(),
        "trxCategory": trxCategory,
        "description": description,
      };
}
