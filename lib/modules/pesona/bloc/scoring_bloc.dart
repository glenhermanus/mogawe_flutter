import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/core/repositories/pesona_repository.dart';
import 'package:mogawe/modules/pesona/bloc/pesona_event.dart';
import 'package:mogawe/modules/pesona/bloc/pesona_state.dart';
import 'package:mogawe/modules/pesona/bloc/scoring_event.dart';
import 'package:mogawe/modules/pesona/bloc/scoring_state.dart';

class ScoringBloc extends Bloc<ScoringEvent, ScoringState> {
  late PesonaRepository _repo;
  late var _userToken;

  ScoringBloc() : super(InitScoringState()) {
    _repo = PesonaRepository.instance;
  }

  @override
  Stream<ScoringState> mapEventToState(ScoringEvent event) async* {
    _userToken = await AuthRepository().readSecureData('token');

    if (event is GetCertificateEvent) {
      yield ShowLoadingScoringsState();
      try {
        var data = await _repo.getCertificationList(realToken: _userToken);
        if(data.isEmpty){
          yield ShowEmptyListScoringsState();
        } else {
          yield ShowListScoringsState(data);
        }
      } catch(ex) {
        yield ShowErrorScoringsState("$ex");
      }
    }

    if (event is GetScoringPendingEvent) {
      try {
        var data = await _repo.getStatusPending(realToken: _userToken);
        if(data.isEmpty){
          yield ShowEmptyPendingState();
        } else {
          yield ShowPendingStatusState(data);
        }
      } catch(ex) {
        print(ex);
      }
    }

    if (event is GetScoringVerifEvent) {
      try {
        var data = await _repo.getStatusVerif(realToken: _userToken);

        if(data.isEmpty){
          yield ShowEmptyVerifState();
        } else {
          yield ShowVerifiedStatusState(data);
        }
      } catch(ex) {
        print(ex);
      }
    }
    if (event is GetScoringExpiredEvent) {
      try {
        var data = await _repo.getStatusExpired(realToken: _userToken);

        if(data.isEmpty){
          yield ShowEmptyExpiredState();
        } else {
          yield ShowExpiredStatusState(data);
        }
      } catch(ex) {
        print(ex);
      }
    }
  }

}