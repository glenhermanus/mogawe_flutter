import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/core/repositories/home_repository.dart';
import 'package:mogawe/core/repositories/pesona_repository.dart';
import 'package:mogawe/modules/home/bloc/home_event.dart';
import 'package:mogawe/modules/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  late HomeRepository _repo;
  late PesonaRepository _pesonaRepository;
  late var _userToken;

  HomeBloc() : super(InitHomeState()) {
    _repo = HomeRepository.instance;
    _pesonaRepository = PesonaRepository.instance;
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    _userToken = await AuthRepository().readSecureData('token');

    if (event is GetAdsBanner) {
      yield ShowLoadingAds();
      try {
        var data = await _repo.getHomeAds(realToken: _userToken);
        yield ShowHomeAds(data);
      } catch(ex) {
        yield ShowErrorHomeState("$ex");
      }
    }

    if(event is GetCertificate) {
      yield ShowLoadingCertificate();
      try {
        var data = await _repo.getHomeContenetRowList(realToken: _userToken);
        yield ShowHomeCertificate(data);
      } catch(ex) {
        yield ShowErrorCertificateState("$ex");
      }
    }

  }
}
