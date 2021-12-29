import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/core/repositories/profile_repository.dart';
import 'package:mogawe/modules/profile/blocs/profile_event.dart';
import 'package:mogawe/modules/profile/blocs/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  late ProfileRepository _repo;
  late var _userToken;

  ProfileBloc() : super(InitProfileState()) {
    _repo = ProfileRepository.instance;
  }

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async*{
    _userToken = await AuthRepository().readSecureData('token');

    if (event is GetProfileEvent) {
      yield ShowLoadingProfileState();
      try {
        var data = await _repo.getProfile(realToken: _userToken);
        yield ShowProfileData(data.object!);
      } catch(ex) {
        yield ShowErrorGetProfileState("$ex");
      }
    }
    if (event is DoUpdateProfileEvent) {
      print("Map : ${event.map}");
      yield ShowLoadingProfileState();
      try {
        var msg = await _repo.updateProfile(event.map,realToken: _userToken);
        var data = await _repo.getProfile(realToken: _userToken);
        yield SuccessUpdateProfileState(msg.message, data.object!);
      } catch(ex) {
        yield ShowErrorProfileState("$ex");
      }
    }
    if (event is DoUpdateTargetRevenueEvent) {
      yield ShowLoadingProfileState();
      try {
        var msg = await _repo.updateTargetRevenue(event.map,realToken: _userToken);
        var data = await _repo.getProfile(realToken: _userToken);
        yield SuccessUpdateTargetRevenueState(msg.message, data.object!);
      } catch(ex) {
        yield ShowErrorProfileState("$ex");
      }
    }
    if (event is DoUpdateSelfReminderEvent) {
      yield ShowLoadingProfileState();
      try {
        var msg = await _repo.updateSelfReminder(event.map,realToken: _userToken);
        var data = await _repo.getProfile(realToken: _userToken);
        yield SuccessUpdateSelfReminderState(msg.message, data.object!);
      } catch(ex) {
        yield ShowErrorProfileState("$ex");
      }
    }
    if (event is DoUpdatePhotoProfileEvent) {
      yield ShowLoadingProfileState();
      try {
        var msg = await _repo.updatePhotoProfile(event.file, realToken: _userToken);
        var data = await _repo.getProfile(realToken: _userToken);
        yield SuccessUpdatePhotoProfileState(msg.message, data.object!);
      } catch(ex) {
        yield ShowErrorProfileState("$ex");
      }
    }
    if (event is GetProfileHistoryEvent) {
      try {
        var list = await _repo.getProfileHistory(realToken: _userToken);
        yield ShowProfileHistoryDataState(list);
      } catch(ex) {
        yield ShowErrorProfileState("$ex");
      }
    }
    if (event is FilterProfileHistoryEvent) {
      yield ShowLoadingProfileState();
      try {
        var list = await _repo.getProfileHistory(realToken: _userToken, periode: event.periode,
            page: "1", q: event.q);
        yield ShowProfileHistoryDataState(list);
      } catch(ex) {
        yield ShowErrorProfileState("$ex");
      }
    }
    if (event is PaginateProfileHistoryEvent) {
      try {
        var list = await _repo.getProfileHistory(
          periode: event.periode,
          page: event.page,
          q: event.q,
          realToken: _userToken
        );
        yield ShowPaginateProfileHistoryDataState(list);
      } catch(ex) {
        yield ShowErrorProfileState("$ex");
      }
    }
    if (event is SearchProfileHistoryEvent) {
      yield ShowLoadingProfileState();
      try {
        var list = await _repo.getProfileHistory(
          q: event.q,
          page: "1",
          periode: event.periode,
          realToken: _userToken,
        );
        yield ShowProfileHistoryDataState(list);
      } catch(ex) {
        yield ShowErrorProfileState("$ex");
      }
    }
    if (event is GetMerchantEvent) {
      yield ShowLoadingMerchantState();
      try {
        var data = await _repo.getProfileMerchant(realToken: _userToken);
        yield ShowProfileMerchant(data.object!);
      } catch(ex) {
        yield ShowErrorGetMerchantState("$ex");
      }
    }
    if (event is DoUpdatePhotoMerchantEvent) {
      yield ShowLoadingMerchantState();
      try {
        var msg = await _repo.updatePhotoMerchant(event.file, realToken: _userToken);
        var data = await _repo.getProfileMerchant(realToken: _userToken);
        yield SuccessUpdatePhotoMerchantState(msg.message, data.object!);
      } catch(ex) {
        yield ShowErrorMerchantState("$ex");

      }
    }
    if (event is DoUpdateSelfPickRadiusEvent) {

      try {
        var msg = await _repo.updateselPickup( realToken: _userToken, radius: event.radius);
        var data = await _repo.getProfileMerchant(realToken: _userToken);
        yield SuccessUpdateSelfPickRadiusState(msg.message);
      } catch(ex) {
        yield ShowErrorSelfPickRadiusState("$ex");

      }
    }
  }
}