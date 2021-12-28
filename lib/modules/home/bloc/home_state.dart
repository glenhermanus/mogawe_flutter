import 'package:mogawe/core/data/response/home/ads_model.dart';
import 'package:mogawe/core/data/response/home_content/gawean_row_model.dart';

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
  List<GaweanRowModel> list;

  ShowHomeCertificate(this.list);
}

class ShowErrorCertificateState extends HomeState {
  String message;

  ShowErrorCertificateState(this.message);
}
