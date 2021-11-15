import 'package:mogawe/core/data/response/profile/profile_response.dart';

abstract class ProfileState {}

class InitProfileState extends ProfileState {}

class ShowLoadingProfileState extends ProfileState {}

class ShowProfileData extends ProfileState {
  ObjectData data;

  ShowProfileData(this.data);
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

class ShowErrorProfileState extends ProfileState {
  String message;

  ShowErrorProfileState(this.message);
}