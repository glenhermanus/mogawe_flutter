import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/core/repositories/gawean_repository.dart';
import 'package:mogawe/modules/home/gawean/all/bloc/task_event.dart';
import 'package:mogawe/modules/home/gawean/all/bloc/task_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  late GaweanRepository _gaweanRepository;
  late String _userToken;

  TaskBloc() : super(InitTaskState()) {
    _gaweanRepository = GaweanRepository.instance;
  }

  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userToken = await AuthRepository().readSecureData('token') as String;

    if (event is GetTaskListEvent) {
      yield ShowLoadingListTaskState();
      try {
      var data = await _gaweanRepository.getTaskList(realToken: _userToken);
      
        yield ShowListTaskState(data);
      } catch (ex) {
        yield ShowErrorState("$ex");
      }
    }
  }

}