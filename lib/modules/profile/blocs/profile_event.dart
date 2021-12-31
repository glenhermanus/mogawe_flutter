import 'dart:io';

abstract class ProfileEvent {}

class GetProfileEvent extends ProfileEvent {}

class GetMerchantEvent extends ProfileEvent {}

class GetProfileHistoryEvent extends ProfileEvent {}

class GetShipmentCourierEvent extends ProfileEvent {}

class SearchProfileHistoryEvent extends ProfileEvent {
  String? q;
  String? periode;

  SearchProfileHistoryEvent(this.q, this.periode);
}

class FilterProfileHistoryEvent extends ProfileEvent {
  String periode;
  String? q;

  FilterProfileHistoryEvent(this.periode, this.q);
}

class PaginateProfileHistoryEvent extends ProfileEvent {
  String? q;
  String? periode;
  String page;

  PaginateProfileHistoryEvent(this.q, this.periode, this.page);
}

class DoUpdateProfileEvent extends ProfileEvent {
  Map<String, String> map;

  DoUpdateProfileEvent(this.map);
}

class DoUpdateMerchantEvent extends ProfileEvent {
  Map<String, String> map;

  DoUpdateMerchantEvent(this.map);
}

class DoUpdateTargetRevenueEvent extends ProfileEvent {
  Map<String, dynamic> map;

  DoUpdateTargetRevenueEvent(this.map);
}

class DoUpdateSelfReminderEvent extends ProfileEvent {
  Map<String, dynamic> map;

  DoUpdateSelfReminderEvent(this.map);
}

class DoUpdatePhotoProfileEvent extends ProfileEvent {
  Map<String, File> file;

  DoUpdatePhotoProfileEvent(this.file);
}

class DoUpdatePhotoMerchantEvent extends ProfileEvent {
  Map<String, File> file;

  DoUpdatePhotoMerchantEvent(this.file);
}

class DoUpdateSelfPickRadiusEvent extends ProfileEvent {
  Map<String,int> radius;

  DoUpdateSelfPickRadiusEvent(this.radius);
}

class DoUpdateShippingExpeditionEvent extends ProfileEvent {
  Map<String,String> shipping;

  DoUpdateShippingExpeditionEvent(this.shipping);
}