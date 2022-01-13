import 'dart:convert';

Revenue revenueFromJson(String str) => Revenue.fromJson(json.decode(str));

String revenueToJson(Revenue? data) => json.encode(data!.toJson());

class Revenue {
  Revenue({
    required this.todayRevenue,
    required this.targetRevenue,
  });

  int todayRevenue;
  int targetRevenue;

  factory Revenue.fromJson(Map<String, dynamic> json) => Revenue(
    todayRevenue: json["todayRevenue"],
    targetRevenue: json["targetRevenue"],
  );

  Map<String, dynamic> toJson() => {
    "todayRevenue": todayRevenue,
    "targetRevenue": targetRevenue,
  };
}