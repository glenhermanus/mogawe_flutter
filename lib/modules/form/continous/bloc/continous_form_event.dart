import 'package:mogawe/core/data/response/form/form_model.dart';

abstract class ContinuousFormEvent {}

class ShowContinuousFormEvent extends ContinuousFormEvent {
  FormModel form;
  ShowContinuousFormEvent(this.form);
}

class NotifyIncrementCounter extends ContinuousFormEvent {}

class NotifyDecrementCounter extends ContinuousFormEvent {}


