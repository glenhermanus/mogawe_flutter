import 'package:mogawe/core/data/response/form/fact.dart';
import 'package:mogawe/core/data/response/form/result/fact_input.dart';
import 'package:mogawe/modules/form/tracker/model/activity_tracker.dart';

abstract class FormEvent {}

class StartForm extends FormEvent {
  final String idTask;
  final int currentTimeMillis;

  StartForm(this.idTask, this.currentTimeMillis);
}

class NotifyIncrementCounter extends FormEvent {}

class NotifyDecrementCounter extends FormEvent {}

class ResetCounter extends FormEvent {}

class SaveChangedFacts extends FormEvent {
  final Fact fact;
  SaveChangedFacts(this.fact);
}

class ChangeActivityTrackerStatus extends FormEvent{
  final ActivityTracker tracker;
  ChangeActivityTrackerStatus(this.tracker);
}

class ConfirmSectionTrackerDone extends FormEvent{
  final ActivityTracker currentTracker;
  final ActivityTracker nextTracker;
  ConfirmSectionTrackerDone(this.currentTracker, this.nextTracker);
}

class SubmitResult extends FormEvent{}

class DeleteSectionLocalDatabase extends FormEvent{}

class TestShowDatabase extends FormEvent{}

class NextForm extends FormEvent{}

