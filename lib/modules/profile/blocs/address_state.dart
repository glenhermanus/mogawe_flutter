import 'package:mogawe/core/data/response/merchant/address_pickup.dart';

abstract class AddressState {}

class InitAddressState extends AddressState {}

class ShowLoadingAddressState extends AddressState {}

class ShowListAddressPickupState extends AddressState {
  List<AddressPickup> data;

  ShowListAddressPickupState(this.data);
}

class SetPickupAddressAsDefaultState extends AddressState {}

class DeletePickupAddressState extends AddressState {}

class ShowEmptyListAddressState extends AddressState {}

class ShowErrorAddressPickupState extends AddressState {
  String message;

  ShowErrorAddressPickupState(this.message);
}




