import 'package:mogawe/core/data/response/merchant/address_pickup.dart';
import 'package:mogawe/core/data/response/profile/profile_response.dart';

abstract class MulaiMerchantState {}

class InitMulaiMerchantState extends MulaiMerchantState {}

class ShowLoadingMulaiMerchantState extends MulaiMerchantState {}

class ShowListAddressPickupState extends MulaiMerchantState {
  List<AddressPickup> data;

  ShowListAddressPickupState(this.data);
}

class ShowLoadingMerchantState extends MulaiMerchantState {}

class SuccessUpdatePhotoTokoState extends MulaiMerchantState {
  String message;

  SuccessUpdatePhotoTokoState(this.message );
}

class ShowPhotoState extends MulaiMerchantState {
  String photo;

  ShowPhotoState(this.photo );
}

class SetPickupAddressAsDefaultState extends MulaiMerchantState {}

class DeletePickupMulaiMerchantState extends MulaiMerchantState {}

class ShowEmptyListMulaiMerchantState extends MulaiMerchantState {}

class ShowErrorAddressPickupState extends MulaiMerchantState {
  String message;

  ShowErrorAddressPickupState(this.message);
}

class ShowErrorUploadPhotoState extends MulaiMerchantState {
  String message;

  ShowErrorUploadPhotoState(this.message);
}




