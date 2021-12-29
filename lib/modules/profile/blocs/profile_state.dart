import 'package:mogawe/core/data/response/profile/profile_history_response.dart';
import 'package:mogawe/core/data/response/profile/profile_response.dart';

abstract class ProfileState {}

class InitProfileState extends ProfileState {}

class ShowLoadingProfileState extends ProfileState {}

class ShowProfileData extends ProfileState {
  ObjectData data;

  ShowProfileData(this.data);
}

class ShowProfileHistoryDataState extends ProfileState {
  List<ProfileHistoryData> list;

  ShowProfileHistoryDataState(this.list);
}

class ShowPaginateProfileHistoryDataState extends ProfileState {
  List<ProfileHistoryData> list;

  ShowPaginateProfileHistoryDataState(this.list);
}

class SuccessUpdateProfileState extends ProfileState {
  String message;
  ObjectData data;

  SuccessUpdateProfileState(this.message, this.data);
}

class SuccessUpdateTargetRevenueState extends ProfileState {
  String message;
  ObjectData data;

  SuccessUpdateTargetRevenueState(this.message, this.data);
}

class SuccessUpdateSelfReminderState extends ProfileState {
  String message;
  ObjectData data;

  SuccessUpdateSelfReminderState(this.message, this.data);
}

class SuccessUpdatePhotoProfileState extends ProfileState {
  String message;
  ObjectData data;

  SuccessUpdatePhotoProfileState(this.message, this.data);
}

class ShowErrorGetProfileState extends ProfileState {
  String message;

  ShowErrorGetProfileState(this.message);
}

class ShowErrorProfileState extends ProfileState {
  String message;

  ShowErrorProfileState(this.message);
}