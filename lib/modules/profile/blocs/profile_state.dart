import 'package:mogawe/core/data/response/merchant/supplier_product.dart';
import 'package:mogawe/core/data/response/profile/profile_history_response.dart';
import 'package:mogawe/core/data/response/profile/profile_response.dart';
import 'package:mogawe/core/data/response/merchant/shipment_courier.dart';
import 'package:mogawe/core/data/response/merchant/merchant_profile_response.dart';

abstract class ProfileState {}

class InitProfileState extends ProfileState {}

class ShowLoadingProfileState extends ProfileState {}

class ShowLoadingSelfPickRadiusState extends ProfileState {}

class ShowLoadingShipmentState extends ProfileState {}

class ShowLoadingMerchantState extends ProfileState {}

class ShowProfileData extends ProfileState {
  ObjectData data;

  ShowProfileData(this.data);
}

class ShowProfileMerchant extends ProfileState {
  Object data;
  List<ObjectDatas> datas;

  ShowProfileMerchant(this.data, this.datas);
}

class ShowShipmentMerchant extends ProfileState {
  List<ObjectShipment> data;

  ShowShipmentMerchant(this.data);
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

class SuccessUpdateMerchantState extends ProfileState {
  String message;
  Object data;

  SuccessUpdateMerchantState(this.message, this.data);
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

class SuccessUpdatePhotoMerchantState extends ProfileState {
  String messages;
  Object  datam;

  SuccessUpdatePhotoMerchantState(this.messages, this.datam);
}

class SuccessUpdateSelfPickRadiusState extends ProfileState {
  String messages;

  SuccessUpdateSelfPickRadiusState(this.messages);
}

class SuccessUpdateshippingExpeditionState extends ProfileState {
  String messages;

  SuccessUpdateshippingExpeditionState(this.messages);
}

class ShowErrorGetProfileState extends ProfileState {
  String message;

  ShowErrorGetProfileState(this.message);
}

class ShowErrorGetMerchantState extends ProfileState {
  String message;

  ShowErrorGetMerchantState(this.message);
}

class ShowErrorProfileState extends ProfileState {
  String message;

  ShowErrorProfileState(this.message);
}

class ShowErrorMerchantState extends ProfileState {
  String message;

  ShowErrorMerchantState(this.message);
}

class ShowErrorSelfPickRadiusState extends ProfileState {
  String message;

  ShowErrorSelfPickRadiusState(this.message);
}

class ShowErrorShipmentCourierState extends ProfileState {
  String message;

  ShowErrorShipmentCourierState(this.message);
}