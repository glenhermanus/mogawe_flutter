import 'dart:convert';
import 'dart:io';

import 'package:logger/logger.dart';
import 'package:mogawe/constant/api_path.dart';
import 'package:mogawe/core/data/request/form/fact_result_request.dart';
import 'package:mogawe/core/data/response/form/form_response.dart';
import 'package:mogawe/core/data/response/form/result/form_submit_response.dart';
import 'package:mogawe/core/data/response/form/start_end_form_response.dart';
import 'package:mogawe/core/data/sources/network/network_service.dart';

class FormRepository extends NetworkService {
  FormRepository();
  var logger = Logger(printer: PrettyPrinter());


  FormRepository._privateConstructor();
  static final FormRepository _instance =
  FormRepository._privateConstructor();
  static FormRepository get instance => _instance;

  final String contentType = "Content-Type";
  final String applicationJson = "application/json; charset=UTF-8";
  final String token = "token";

  Future<FormResponse> getFormResponse(
      {required String realToken,
       required String? idTask,}
      ) async {
    var header = {token: realToken};
    var map = await getMethod("${BASE_URL}api/fieldfact/getByTask/?idTask=$idTask", header,);
    return FormResponse.fromJson(map);
  }

  Future<FormResponse> startPesona({required String realToken,
    required String? idJob
  }) async {
    var header = {token: realToken};
    var map = await getMethod("${BASE_URL}api/fieldfact/applyAndGetSection/?idJob=$idJob", header,);
    return FormResponse.fromJson(map);
  }

  Future<StartEndFormResponse> startForm({required String realToken,
        required String? idTask, required int timeStampLong,
  }) async {
    var header = {token: realToken};
    var map = await getMethod("${BASE_URL}api/fieldtask/start/?idTask=$idTask&timestamp=$timeStampLong", header,);
    return StartEndFormResponse.fromJson(map);
  }

  Future<FormSubmitResponse> submitResult(
      String? realToken,
      String? idTask,
      String idResult,
      String uuidSession,
      double latitude,
      double longitude,
      String startDate) async {
    var body = {
      'idTask': idTask,
      'idResult': idResult,
      'uuidSession': uuidSession,
      'latitude': latitude,
      'longitude': longitude,
      'startDate': startDate,
    };
    var header = {
      token: realToken!,
      contentType: applicationJson
    };

    var map = await postMethod("${BASE_URL}api/fieldresultfact/submitResult",
        body: body, headers: header);

    return FormSubmitResponse.fromJson(map);
  }

  Future<FormSubmitResponse> submitResultFact(
      String? realToken,
      String idResult,
      List<FactResultRequest> listFactResult,
      ) async {

    List<Map<String, dynamic>> requestBody = listFactResult.map((e) => e.toJson()).toList();

    // String requestBody = json.encoder.convert(toJson());
    print("requestBody is " + requestBody.toString());

    var body = {
      'idResult': idResult,
      "results": requestBody,
      "api_key":"504fbae0d815bf3e",
      "username":"MGWAPP"
    };

    logger.d(body);

    var header = {
      token: realToken!,
      contentType: applicationJson
    };

    var map = await postMethod("${BASE_URL}api/fieldresultfact/submitResultFact",
        body: body, headers: header);

    return FormSubmitResponse.fromJson(map);
  }

  Future<FormSubmitResponse> submitResultFiles(
      String? realToken,
      String idFact,
      String idResult,
      String uuidSession,
      String timestamp,
      Map<String, File> file) async {
    var body = {
      'idFact': idFact,
      'idResult': idResult,
      'timestamp': timestamp,
    };
    var header = {
      token: realToken!,
      contentType: applicationJson
    };

    print("body submit file is : ");
    logger.d(body);
    print("file body submit file is : ");
    logger.d(file);

    var map = await multipartPost("${BASE_URL}api/fieldresultfact/uploadFileV2",
        body: body, header: header, files: file);

    return FormSubmitResponse.fromJson(map);
  }




}
