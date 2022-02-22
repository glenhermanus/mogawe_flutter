import 'package:mogawe/core/data/response/merchant/address_pickup.dart';
import 'package:mogawe/core/data/response/pesona/pesona_response.dart';
import 'package:mogawe/core/data/response/pesona/pesona_response_object.dart';
import 'package:mogawe/core/data/response/profile/profile_response.dart';

abstract class PesonaState {}

class InitPesonaState extends PesonaState {}

class ShowLoadingPesonaState extends PesonaState {}

class ShowListPesonaState extends PesonaState {
  List<PesonaResponsesObject> data;

  ShowListPesonaState(this.data);
}

class ShowLoadingMerchantState extends PesonaState {}

class SuccessUpdatePhotoTokoState extends PesonaState {
  String message;

  SuccessUpdatePhotoTokoState(this.message );
}

class ShowPhotoState extends PesonaState {
  String photo;

  ShowPhotoState(this.photo );
}

class SetPickupAddressAsDefaultState extends PesonaState {}

class DeletePickupPesonaState extends PesonaState {}

class ShowEmptyListPesonaState extends PesonaState {}

class ShowErrorPesonaState extends PesonaState {
  String message;

  ShowErrorPesonaState(this.message);
}

class ShowErrorUploadPhotoState extends PesonaState {
  String message;

  ShowErrorUploadPhotoState(this.message);
}




