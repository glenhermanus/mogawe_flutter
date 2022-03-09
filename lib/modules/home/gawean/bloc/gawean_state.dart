import 'package:mogawe/core/data/response/home_content/gawean_model.dart';
import 'package:mogawe/core/data/response/home_content/gawean_row_model.dart';

abstract class GaweanState {}

class InitGaweanState extends GaweanState {}

class ShowLoadingListGaweanState extends GaweanState {}

class ShowEmptyListState extends GaweanState {}

class ShowListGaweanState extends GaweanState {
  List<GaweanRowModel> list;

  ShowListGaweanState(this.list);
}

class ShowListTaskState extends GaweanState {
  List<Gawean> list;

  ShowListTaskState(this.list);
}

class ShowErrorGaweanListState extends GaweanState {
  String message;

  ShowErrorGaweanListState(this.message);
}