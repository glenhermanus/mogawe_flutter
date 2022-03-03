import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:mogawe/core/data/request/form/fact_result_request.dart';
import 'package:mogawe/core/data/response/form/fact.dart';
import 'package:mogawe/core/data/response/form/form_model.dart';
import 'package:mogawe/core/data/response/form/result/form_submit_response.dart';
import 'package:mogawe/core/data/sources/local/database_helper.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/core/repositories/form_repository.dart';
import 'package:mogawe/modules/form/bloc/form_event.dart';
import 'package:mogawe/modules/form/bloc/form_state.dart';
import 'package:mogawe/modules/form/tracker/model/activity_tracker.dart';

class FormBloc extends Bloc<FormEvent, FormState> {
  late FormRepository _repo;
  late DatabaseHelper _databaseHelper;
  var logger = Logger(printer: PrettyPrinter());

  late var _userToken;

  int _currentProgress = 0;
  String _submitText = "";
  String uuidSession = "";
  String? idTask;
  List<Fact> facts = [];
  List<FormModel> listModel = [];
  List<FactResultRequest> factsResults = [];

  List<ActivityTracker> activityTrackers = [];
  String startTime = "";

  final _counterStateController = StreamController<int>.broadcast();
  StreamSink<int> get _inController => _counterStateController.sink;
  Stream<int> get currentProgress => _counterStateController.stream;

  final _submitTextStateController = StreamController<String>.broadcast();
  StreamSink<String> get _inTextController => _submitTextStateController.sink;
  Stream<String> get currentSubmitText => _submitTextStateController.stream;

  FormBloc() : super(InitFormState()) {
    _repo = FormRepository.instance;
    _databaseHelper = DatabaseHelper();
  }

  @override
  Stream<FormState> mapEventToState(FormEvent event) async* {
    _userToken = await AuthRepository().readSecureData('token');
    if (event is StartForm) {
      yield ShowLoadingForm();
      var startForm = await _repo.startForm(
          realToken: _userToken,
          idTask: event.idTask,
          timeStampLong: event.currentTimeMillis);
      var data = await _repo.getFormResponse(
          realToken: _userToken, idTask: event.idTask);
      uuidSession = data.uuid;
      idTask = event.idTask;
      startTime = DateTime.now().toIso8601String();
      print("StartTime is $startTime");

      if (data.object.first.questionnaireTemplateName == "Activity Tracker") {
        _convertSectionsToTrackers(data.object);
        yield ShowTrackerActivityForm(data.object);
      } else {
        yield ShowContinuousForm(data.object);
      }
    }

    if (event is StartPesona) {
      yield ShowLoadingForm();
      var data = await _repo.startPesona(
          realToken: _userToken,
          idJob: event.idJob);

      if (data.object.first.questionnaireTemplateName == "Activity Tracker") {
        _convertSectionsToTrackers(data.object);
        yield ShowTrackerActivityForm(data.object);
      } else {
        yield ShowPesonaForm(data.object);
      }
    }

    //counter
    if (event is NotifyIncrementCounter) {
      _currentProgress++;
    }
    if (event is NotifyDecrementCounter) {
      _currentProgress--;
    }
    if (event is ResetCounter) {
      _currentProgress = 0;
    }

    _setCounterToDefaultIfGoBelowZero();

    //Save Fact
    if (event is SaveChangedFacts) {
      String foundUuid = "";
      if (facts.isEmpty) {
        facts.add(event.fact);
      } else {
        print("ContinuousForm received fact uuid is ${event.fact.uuid}");
        for (var fact in facts) {
          if (fact.uuid == event.fact.uuid) {
            foundUuid = event.fact.uuid;
            break;
          }
        }
        if (foundUuid != "") {
          facts.removeWhere((element) {
            return element.uuid == foundUuid;
          });
        }
        facts.add(event.fact);
      }
    }

    //submit Form
    if (event is SubmitResult) {
      yield(ShowDialogLoadingSubmitFacts());
      _submitText = "Mengirim form kamu...";
      _inTextController.add(_submitText);
      FormSubmitResponse response = await _requestSubmit();
      if(response.returnValue == "000"){
        FormSubmitResponse responseSubmitFacts = await _requestSubmitFacts(response.uuid);
        _submitText = "Mengirim jawaban kamu...!";
        _inTextController.add(_submitText);
        if(responseSubmitFacts.returnValue == "000"){
          _submitText = "done!";
          _inTextController.add(_submitText);
          await _requestSubmitFiles(responseSubmitFacts.uuid);
        }
      }
    }
  }

  Future<FormSubmitResponse> _requestSubmit() async {
    FormSubmitResponse submitResponse = await _repo.submitResult(
        _userToken,
        idTask,
        "",
        uuidSession,
        0.0,
        0.0,
        startTime);

    return submitResponse;
  }

  Future<FormSubmitResponse> _requestSubmitFacts(String uuidResult) async {
    for (var fact in facts) {
      FactResultRequest factResult = new FactResultRequest(
          factName: fact.factName,
          factSequence: fact.sequence,
          finalScore: fact.finalScore ?? "0",
          idFactDisplay: fact.idFactDisplay,
          idItemDisplay: fact.idItemDisplay ?? 0,
          uuidFactType: fact.uuidFactType,
          value: fact.input,
          files: fact.files,
          sectionSequence: 1,
          id: 0,
          resultId: 0,
          sectionIsEdited: false,
          sectionName: fact.sectionName);

      factsResults.add(factResult);
    }

    logger.d("result is $facts");
    logger.d("result is $factsResults");

    FormSubmitResponse submitFactResponse =
    await _repo.submitResultFact(_userToken, uuidResult, factsResults);

    return submitFactResponse;
  }

  Future<void> _requestSubmitFiles(String uuidResult) async {
    List<FactResultRequest> filteredFacts = _filterResultFactWithFile();
    for (var factWithFile in filteredFacts) {
      for (var file in factWithFile.files) {
        await _repo.submitResultFiles(
            _userToken, factWithFile.idFactDisplay ?? "0", uuidResult, uuidSession, startTime, file);
      }
    }
  }

  List<FactResultRequest> _filterResultFactWithFile() {
    List<FactResultRequest> filteredFacts = [];
    for (var normalFact in factsResults) {
      if (normalFact.files.isNotEmpty) {
        filteredFacts.add(normalFact);
      }
    }
    return filteredFacts;
  }

  void _setCounterToDefaultIfGoBelowZero() {
    if (_currentProgress < 0) {
      _currentProgress = 0;
    }
    _inController.add(_currentProgress);
  }

  void _convertSectionsToTrackers(List<FormModel> sections) {
    int index = 1;
    for (var section in sections) {
      ActivityTracker tracker = new ActivityTracker(
          sectionName: section.name,
          uuidSection: section.uuid,
          status: "",
          startTime: "", sequence: index, trackerTotal: sections.length);
      activityTrackers.add(tracker);
      index++;
    }
  }

  void dispose() {
    _counterStateController.close();
    _submitTextStateController.close();
  }
}