import 'package:mogawe/core/data/response/form/form_model.dart';

abstract class FormState {}

class InitFormState extends FormState{}

class ShowLoadingForm extends FormState {}

class ShowLoadingSubmitFacts extends FormState {}

class ShowLoadingSubmitFile extends FormState {}

class ShowContinuousForm extends FormState {
  FormModel form;
  ShowContinuousForm(this.form);
}

class ShowTrackerActivityForm extends FormState {
  List<FormModel> forms;
  ShowTrackerActivityForm(this.forms);
}