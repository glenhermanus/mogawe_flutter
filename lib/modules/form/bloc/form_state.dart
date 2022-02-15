import 'package:mogawe/core/data/response/form/form_model.dart';

abstract class FormState {}

class InitFormState extends FormState{}

class ShowLoadingForm extends FormState {}

class ShowLoadingSubmitFacts extends FormState {}

class ShowLoadingSubmitFile extends FormState {}

class ShowDialogLoadingSubmitFacts extends FormState {}

class ShowDialogCloseForm extends FormState {}

class ShowContinuousForm extends FormState {
  List<FormModel> forms;
  ShowContinuousForm(this.forms);
}

class ShowTrackerActivityForm extends FormState {
  List<FormModel> forms;
  ShowTrackerActivityForm(this.forms);
}