import 'package:mogawe/core/data/response/merchant/address_pickup.dart';
import 'package:mogawe/core/data/response/pesona/certificate_response.dart';
import 'package:mogawe/core/data/response/pesona/count_status.dart';
import 'package:mogawe/core/data/response/pesona/expired_response.dart';
import 'package:mogawe/core/data/response/pesona/pending_response.dart';
import 'package:mogawe/core/data/response/pesona/pesona_response.dart';
import 'package:mogawe/core/data/response/pesona/pesona_response_object.dart';
import 'package:mogawe/core/data/response/pesona/verified_response.dart';
import 'package:mogawe/core/data/response/profile/profile_response.dart';

abstract class ScoringState {}

class InitScoringState extends ScoringState {}

class ShowLoadingScoringState extends ScoringState {}

class ShowLoadingScoringsState extends ScoringState {}

class ShowListScoringState extends ScoringState {
 // List<ScoringResponsesObject> data;

 // ShowListScoringState(this.data);
}

class ShowListScoringsState extends ScoringState {
  List<Object> data;

  ShowListScoringsState(this.data);
}

class ShowPendingStatusState extends ScoringState {
  List<ObjectPending> dataPending;

  ShowPendingStatusState(this.dataPending);
}

class ShowVerifiedStatusState extends ScoringState {

  List<ObjectVerif> dataVerified;

  ShowVerifiedStatusState(this.dataVerified);
}

class ShowExpiredStatusState extends ScoringState {

  List<ObjectExpired> dataExpired;

  ShowExpiredStatusState(this.dataExpired);
}

class ShowCountState extends ScoringState {
  CountStatusResponse data;

  ShowCountState(this.data);
}

class ShowEmptyListScoringState extends ScoringState {}

class ShowEmptyVerifState extends ScoringState {}

class ShowEmptyPendingState extends ScoringState {}

class ShowEmptyExpiredState extends ScoringState {}

class ShowEmptyListScoringsState extends ScoringState {}

class ShowErrorScoringState extends ScoringState {
  String message;

  ShowErrorScoringState(this.message);
}

class ShowErrorCountState extends ScoringState {
  String message;

  ShowErrorCountState(this.message);
}

class ShowErrorScoringsState extends ScoringState {
  String message;

  ShowErrorScoringsState(this.message);
}



