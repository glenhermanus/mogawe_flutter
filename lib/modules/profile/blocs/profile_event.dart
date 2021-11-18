import 'dart:io';

abstract class ProfileEvent {}

class GetProfileEvent extends ProfileEvent {}

class GetProfileHistoryEvent extends ProfileEvent {}

class FilterProfileHistoryEvent extends ProfileEvent {
  String periode;

  FilterProfileHistoryEvent(this.periode);
}

class PaginateProfileHistoryEvent extends ProfileEvent {
  String? periode;
  String page;

  PaginateProfileHistoryEvent(this.periode, this.page);
}

class DoUpdateProfileEvent extends ProfileEvent {
  Map<String, String> map;

  DoUpdateProfileEvent(this.map);
}

class DoUpdateTargetRevenueEvent extends ProfileEvent {
  Map<String, dynamic> map;

  DoUpdateTargetRevenueEvent(this.map);
}

class DoUpdatePhotoProfileEvent extends ProfileEvent {
  Map<String, File> file;

  DoUpdatePhotoProfileEvent(this.file);
}