abstract class RegistrationEvent {}

class DoRegisterEvent extends RegistrationEvent {
  Map<String, String> body;

  DoRegisterEvent(this.body);
}

class DoActivateMailEvent extends RegistrationEvent {
  Map<String, String> body;

  DoActivateMailEvent(this.body);
}

class DoResendActivationEmailEvent extends RegistrationEvent {
  Map<String, String> body;

  DoResendActivationEmailEvent(this.body);
}

class ChangeRegistrationStateEvent extends RegistrationEvent {}

class DoActivateNewPasswordEvent extends RegistrationEvent {
  Map<String, String> body;

  DoActivateNewPasswordEvent(this.body);
}