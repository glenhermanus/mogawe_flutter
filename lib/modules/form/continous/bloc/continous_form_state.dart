import 'package:mogawe/core/data/response/form/form_model.dart';

abstract class ContinuousFormState {}

class InitContinuousFormState extends ContinuousFormState{}

class ShowContinuousFormState extends ContinuousFormState {
  FormModel form;
  ShowContinuousFormState(this.form);
}