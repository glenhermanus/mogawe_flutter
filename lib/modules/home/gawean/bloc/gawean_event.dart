import 'package:mogawe/core/data/request/gawean/update_gawean_sequence.dart';

abstract class GaweanEvent {}

// Home
class GetGaweanListEvent extends GaweanEvent {}

class ChangeMenuToGawean extends GaweanEvent {}

// See All
class GetTaskListEvent extends GaweanEvent{}

class ChangeMenuToEtalase extends GaweanEvent {}

class UpdateGaweanSequence extends GaweanEvent {
  final UpdateGaweanSequenceRequest updateGaweanSequence;
  UpdateGaweanSequence(this.updateGaweanSequence);
}

