import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mogawe/core/data/request/reset_password_request.dart';
import 'package:mogawe/core/data/response/reset_password_response.dart';
import 'package:mogawe/modules/auth/repositories/auth_repository.dart';
import 'package:mogawe/utils/services/password_hasher.dart';

part 'resetpassword_event.dart';
part 'resetpassword_state.dart';

class ResetpasswordBloc extends Bloc<ResetpasswordEvent, ResetpasswordState> {
  final _repository = AuthRepository();

  ResetpasswordBloc() : super(ResetpasswordInitial()) {
    on<ResetpasswordSubmitted>(_onResetpasswordSubmitted);
  }

  FutureOr<void> _onResetpasswordSubmitted(
      ResetpasswordSubmitted event, Emitter<ResetpasswordState> emit) async {
    try {
      emit(ResetpasswordLoading());
      event.request.newPassword =
          PasswordHasher().convertToSha256(event.request.newPassword ?? '');
      final response = await _repository.resetPassword(event.request);
      emit(ResetpasswordLoaded(response));
    } catch (e) {
      print(e);
    }
  }
}
