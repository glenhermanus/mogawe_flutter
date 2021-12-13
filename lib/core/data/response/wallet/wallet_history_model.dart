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
  DateTime? receivedDate;
  String trxType;
  DateTime? trxTime;
  String? trxCategory;
  String? description;

  factory WalletHistoryModel.fromJson(Map<String, dynamic> json) =>
      WalletHistoryModel(
        total: json["total"] == null ? null : json["total"],
        receivedDate: json["receivedDate"] == null
            ? null
            : DateTime.parse(json["receivedDate"]),
        trxType: json["trxType"] == null ? null : json["trxType"],
        trxTime:
            json["trxTime"] == null ? null : DateTime.parse(json["trxTime"]),
        trxCategory: json["trxCategory"] == null ? null : json["trxCategory"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "receivedDate": receivedDate,
        "trxType": trxType,
        "trxTime": trxTime?.toIso8601String(),
        "trxCategory": trxCategory,
        "description": description,
      };
}
