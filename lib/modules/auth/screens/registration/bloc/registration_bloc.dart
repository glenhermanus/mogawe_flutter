import 'package:bloc/bloc.dart';
import 'package:mogawe/modules/auth/repositories/auth_repository.dart';
import 'package:mogawe/modules/auth/screens/registration/bloc/registration_event.dart';
import 'package:mogawe/modules/auth/screens/registration/bloc/registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {

  late AuthRepository _repo;

  RegistrationBloc() : super(InitRegistrationState()) {
    _repo = AuthRepository.instance;
  }

  @override
  Stream<RegistrationState> mapEventToState(RegistrationEvent event) async*{
    if (event is DoRegisterEvent) {
      yield ShowLoadingRegistrationState();
      try {
        await _repo.submitRegister(event.body);
        yield SuccessRegisterState(event.body["email"].toString());
      } catch(ex) {
        yield ShowErrorRegistrationState("$ex");
      }
    }
    if (event is DoActivateMailEvent) {
      yield ShowLoadingRegistrationState();
      try {
        await _repo.submitActivateEmail(event.body);
        yield SuccessActivateEmailState();
      } catch(ex) {
        yield ShowErrorRegistrationState("$ex");
      }
    }
    if (event is DoResendActivationEmailEvent) {
      try {
        await _repo.submitResendActivationEmail(event.body);
        yield SuccessResendActivationEmailState();
      } catch(ex) {
        yield ShowErrorRegistrationState('$ex');
      }
    }
    if (event is ChangeRegistrationStateEvent) {
      yield RegistrationStateChanged();
    }
    if (event is DoActivateNewPasswordEvent) {
      yield ShowLoadingRegistrationState();
      try {
        await _repo.submitActivateNewPassowrd(event.body);
        yield SuccessActivateNewPasswordState();
      } catch(ex) {
        yield ShowErrorRegistrationState("$ex");
      }
    }
  }
}