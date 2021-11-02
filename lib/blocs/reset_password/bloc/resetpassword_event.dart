part of 'resetpassword_bloc.dart';

@immutable
abstract class ResetpasswordEvent {
}

class ResetpasswordSubmitted extends ResetpasswordEvent {
  final ResetPasswordRequest request;

  ResetpasswordSubmitted(this.request);
}
