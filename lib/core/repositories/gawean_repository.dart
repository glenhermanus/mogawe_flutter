import 'package:mogawe/constant/api_path.dart';
import 'package:mogawe/core/data/request/gawean/update_gawean_sequence.dart';
import 'package:mogawe/core/data/response/GenericResponse.dart';
import 'package:mogawe/core/data/response/gawean/get_task_response.dart';
import 'package:mogawe/core/data/response/gawean/update_reminder_gawean_response.dart';
import 'package:mogawe/core/data/response/home_content/gawean_model.dart';
import 'package:mogawe/core/data/response/home_content/gawean_row_model.dart';
import 'package:mogawe/core/data/response/home_content/widget_row_response.dart';
import 'package:mogawe/core/data/sources/network/network_service.dart';

class GaweanRepository extends NetworkService {
  GaweanRepository();

  GaweanRepository._privateConstructor();
  static final GaweanRepository _instance =
      GaweanRepository._privateConstructor();
  static GaweanRepository get instance => _instance;

  final String contentType = "Content-Type";
  final String applicationJson = "application/json; charset=UTF-8";
  final String token = "token";

  Future<List<GaweanRowModel>> getGaweanRowList(
    {required String realToken,
    String? page,
    String? offset,
    String? latitude,
    String? longitude,}
  ) async {
    var header = {token: realToken};
    var map = await getMethod(
      "${BASE_URL}api/fieldtask/v3/widgetrow/get?page=1&offset=10&lat=-6.44046987091469&lng=106.8603937882579",
      header,
    );
    return WidgetRowResponse.fromJson(map).object;
  }

  Future<List<Gawean>> getTaskList({
    required String realToken
  }) async {
    var header = { token: realToken };
    var map = await getMethod(
        "${BASE_URL}api/fieldtask/myTask?page=1&offset=20",
        header
    );
    return GetTaskResponse.fromJson(map).object;
  }

  Future<GenericResponse> cancelGawean({
    required String realToken,
    required String idTask}) async {
    var header = {token: realToken};
    var map = await getMethod(
      "${BASE_URL}api/fieldtask/cancel/$idTask",
      header,
    );
    return GenericResponse.fromJson(map);
  }

  Future<UpdateReminderGaweanResponse> updateGaweanReminder(String realToken, Map<String, String?> body) async {
    var header = {token: realToken, contentType: applicationJson};



    var map = await putMethod(
        "${BASE_URL}api/fieldtask/myTask/updateReminder",
        header: header,
        body: body
    );
    return UpdateReminderGaweanResponse.fromJson(map);
  }

  Future<GenericResponse> updateGaweanSequence(String realToken, UpdateGaweanSequenceRequest listUuidGawean) async {
    var body = listUuidGawean.toJson();
    var header = {token: realToken, contentType: applicationJson};
    var map = await putMethod(
        "${BASE_URL}api/fieldtask/myTask/updateSequence",
        header: header,
        body: body
    );
    return GenericResponse.fromJson(map);
  }

}
