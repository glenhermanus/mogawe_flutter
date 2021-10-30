abstract class RegistrationState {}

class InitRegistrationState extends RegistrationState {}

class RegistrationStateChanged extends RegistrationState {}

class ShowLoadingRegistrationState extends RegistrationState {}

class SuccessRegisterState extends RegistrationState {
  String email;

  SuccessRegisterState(this.email);
}

class SuccessActivateEmailState extends RegistrationState {}

class SuccessResendActivationEmailState extends RegistrationState {}

class SuccessActivateNewPasswordState extends RegistrationState {}

class ShowErrorRegistrationState extends RegistrationState {
  String message;

  ShowErrorRegistrationState(this.message);
}