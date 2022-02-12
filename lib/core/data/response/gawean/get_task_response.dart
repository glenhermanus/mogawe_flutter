import 'package:mogawe/core/data/response/home_content/gawean_model.dart';

class GetTaskResponse {
  GetTaskResponse({
    required this.returnValue,
    required this.message,
    required this.uuid,
    required this.rowCount,
    required this.pageCount,
    required this.offset,
    required this.object,
    required this.object2,
    required this.res,
  });

  String returnValue;
  String message;
  dynamic uuid;
  int rowCount;
  int pageCount;
  int offset;
  List<Gawean> object;
  dynamic object2;
  dynamic res;

  factory GetTaskResponse.fromJson(Map<String, dynamic> json) =>
      GetTaskResponse(
        returnValue: json["returnValue"],
        message: json["message"],
        uuid: json["uuid"],
        rowCount: json["rowCount"],
        pageCount: json["pageCount"],
        offset: json["offset"],
        object: List<Gawean>.from(
            json["object"].map((x) => Gawean.fromJson(x))),
        object2: json["object2"],
        res: json["res"],
      );

  Map<String, dynamic> toJson() => {
        "returnValue": returnValue,
        "message": message,
        "uuid": uuid,
        "rowCount": rowCount,
        "pageCount": pageCount,
        "offset": offset,
        "object": List<Gawean>.from(object.map((x) => x.toJson())),
        "object2": object2,
        "res": res,
      };
}
