import 'package:mogawe/core/data/response/merchant/address_pickup.dart';
import 'package:mogawe/core/data/response/pesona/certificate_response.dart';
import 'package:mogawe/core/data/response/pesona/pesona_response.dart';
import 'package:mogawe/core/data/response/pesona/pesona_response_object.dart';
import 'package:mogawe/core/data/response/profile/profile_response.dart';

abstract class PesonaState {}

class InitPesonaState extends PesonaState {}

class ShowLoadingPesonaState extends PesonaState {}

class ShowLoadingCertificateState extends PesonaState {}

class ShowListPesonaState extends PesonaState {
  List<PesonaResponsesObject> data;

  ShowListPesonaState(this.data);
}

class ShowListCertificateState extends PesonaState {
  List<Object> data;

  ShowListCertificateState(this.data);
}

class ShowEmptyListPesonaState extends PesonaState {}

class ShowEmptyListCertificateState extends PesonaState {}

class ShowErrorPesonaState extends PesonaState {
  String message;

  ShowErrorPesonaState(this.message);
}

class ShowErrorCertificateState extends PesonaState {
  String message;

  ShowErrorCertificateState(this.message);
}



