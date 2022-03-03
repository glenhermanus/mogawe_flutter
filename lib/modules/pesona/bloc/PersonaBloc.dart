
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/core/repositories/pesona_repository.dart';
import 'package:mogawe/modules/pesona/bloc/PersonaEvent.dart';
import 'package:mogawe/modules/pesona/bloc/PersonaState.dart';

class PersonaBloc extends Bloc<PersonaEvent, PersonaState> {

  late PesonaRepository _repo;
  late var _userToken;

  PersonaBloc() : super(InitPersonaState()) {
    _repo = PesonaRepository.instance;
  }

  @override
  Stream<PersonaState> mapEventToState(PersonaEvent event) async* {
    _userToken = await AuthRepository().readSecureData('token');
    print("TOken is " + _userToken);

    if (event is GetPersonaDetail) {
      yield ShowLoadingPersona();
      if (event.isFromBanner){
        var dataCertificate = await _repo.getDetailCertificate(_userToken, event.uuidJob);
        var data = await _repo.getDetailPersona(_userToken, dataCertificate.uuidJob ?? "");
        yield ShowPersonaDetail(data);
      } else {
        var data = await _repo.getDetailPersona(_userToken, event.uuidJob);
        yield ShowPersonaDetail(data);
      }
    }
  }
}