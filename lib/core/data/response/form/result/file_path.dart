import 'dart:convert';

ResultFilePath resultFilePathFromJson(String str) => ResultFilePath.fromJson(json.decode(str));

String resultFilePathToJson(ResultFilePath data) => json.encode(data.toJson());

class ResultFilePath {
  ResultFilePath({
    required this.path,
  });

  String path;

  factory ResultFilePath.fromJson(Map<String, dynamic> json) => ResultFilePath(
    path: json["path"] == null ? null : json["path"],
  );

  Map<String, dynamic> toJson() => {
    "path": path == null ? null : path,
  };
}