import 'package:mogawe/core/data/response/home/ads_model.dart';
import 'package:mogawe/core/data/response/pesona/pesona_response_object.dart';

abstract class HomeState {}

class InitHomeState extends HomeState{}

class ShowLoadingAds extends HomeState {}

class ShowHomeAds extends HomeState {
  List<Ads> list;

  ShowHomeAds(this.list);
}

class ShowErrorHomeState extends HomeState {
  String message;

  ShowErrorHomeState(this.message);
}

class ShowLoadingCertificate extends HomeState {}

class ShowHomeCertificate extends HomeState {
  List<PesonaResponsesObject> list;

  ShowHomeCertificate(this.list);
}
