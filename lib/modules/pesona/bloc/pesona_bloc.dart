import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/core/repositories/pesona_repository.dart';
import 'package:mogawe/modules/pesona/bloc/pesona_event.dart';
import 'package:mogawe/modules/pesona/bloc/pesona_state.dart';

class PesonaBloc extends Bloc<PesonaEvent, PesonaState> {
  late PesonaRepository _repo;
  late var _userToken;

  PesonaBloc() : super(InitPesonaState()) {
    _repo = PesonaRepository.instance;
  }

  @override
  Stream<PesonaState> mapEventToState(PesonaEvent event) async* {
    _userToken = await AuthRepository().readSecureData('token');
    if (event is GetPesonaEvent) {
      yield ShowLoadingPesonaState();
      try {
        var data = await _repo.getCertification(realToken: _userToken);
        if(data.isEmpty){
          yield ShowEmptyListPesonaState();
        } else {
          yield ShowListPesonaState(data);
        }
      } catch(ex) {
        yield ShowErrorPesonaState("$ex");
      }
    }
    if (event is GetPesonaCertificate) {
      try {
        var data = await _repo.getCertificationList(realToken: _userToken);
        if(data.isEmpty){
          yield ShowEmptyListCertificateState();
        } else {
          yield ShowListCertificateState(data);
        }
      } catch(ex) {
        yield ShowErrorCertificateState("$ex");
      }
    }

  }

}