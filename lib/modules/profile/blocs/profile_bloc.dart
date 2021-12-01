import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mogawe/modules/auth/repositories/profile_repository.dart';
import 'package:mogawe/modules/profile/blocs/profile_event.dart';
import 'package:mogawe/modules/profile/blocs/profile_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {

  late ProfileRepository _repo;
  late String _userToken;

  ProfileBloc() : super(InitProfileState()) {
    _repo = ProfileRepository.instance;
  }

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async*{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userToken = prefs.getString('token') ?? "";
    _userToken = "eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJNTy00MjFCM0EiLCJpYXQiOjE2MzQ1MjkxMzEsInN1YiI6Im1vZ2F3ZXJzIiwiaXNzIjoibW9nYXdlIn0.6I3GpI_gB02jpicmXzotWg4webpBU_3kpwFhWAF57bU";


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
  }
}