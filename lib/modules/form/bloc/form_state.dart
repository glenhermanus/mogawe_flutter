import 'package:mogawe/core/data/response/form/form_model.dart';
import 'package:mogawe/core/data/response/form/start_end_form_response.dart';
import 'package:mogawe/core/data/response/form/task.dart';

abstract class FormState {}

class InitFormState extends FormState{}

class ShowLoadingForm extends FormState {}

class ShowLoadingSubmitFacts extends FormState {}

class ShowLoadingSubmitFile extends FormState {}

class ShowDialogLoadingSubmitFacts extends FormState {}

class ShowDialogCloseForm extends FormState {}

class ShowPesonaForm extends FormState {
  List<FormModel> forms;
  ShowPesonaForm(this.forms);
}

class ShowContinuousForm extends FormState {
  List<FormModel> forms;
  ShowContinuousForm(this.forms);
}

class ShowTrackerActivityForm extends FormState {
  List<FormModel> forms;
  ShowTrackerActivityForm(this.forms);
}