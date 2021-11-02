part of 'resetpassword_bloc.dart';

@immutable
abstract class ResetpasswordState {}

class ResetpasswordInitial extends ResetpasswordState {}
class ResetpasswordLoading extends ResetpasswordState {}
class ResetpasswordLoaded extends ResetpasswordState {
  final ResetPasswordResponse response;

  ResetpasswordLoaded(this.response);
}
class ResetpasswordError extends ResetpasswordState {}
