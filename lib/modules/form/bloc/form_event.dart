import 'package:mogawe/core/data/response/form/fact.dart';
import 'package:mogawe/core/data/response/form/result/fact_input.dart';

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

class SubmitResult extends FormEvent{}

class DeleteSectionLocalDatabase extends FormEvent{}

class TestShowDatabase extends FormEvent{}

class NextForm extends FormEvent{}

