import 'package:mogawe/core/data/response/form/task.dart';
import 'package:mogawe/core/data/response/home_content/gawean_model.dart';

abstract class TaskState {}

class InitTaskState extends TaskState {}

class ShowLoadingListTaskState extends TaskState {}

class ShowListTaskState extends TaskState {
  List<Gawean> list;

  ShowListTaskState(this.list);
}

class ShowErrorState extends TaskState {
  String message;

  ShowErrorState(this.message);
}