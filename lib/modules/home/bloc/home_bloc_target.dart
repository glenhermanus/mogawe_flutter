import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mogawe/core/data/response/home_content/Revenue.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/core/repositories/gawean_repository.dart';
import 'package:mogawe/core/repositories/home_repository.dart';
import 'package:mogawe/core/repositories/pesona_repository.dart';
import 'package:mogawe/modules/home/bloc/home_event.dart';
import 'package:mogawe/modules/home/bloc/home_state.dart';

class HomeTargetBloc extends Bloc<HomeEvent, HomeState> {
  late GaweanRepository _gaweanRepository;

  late var _userToken;

  HomeTargetBloc() : super(InitHomeState()) {
    _gaweanRepository = GaweanRepository.instance;
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    _userToken = await AuthRepository().readSecureData('token');

    if (event is GetTarget) {
      var data = await _gaweanRepository.getGaweanRowList(realToken: _userToken);
      yield ShowMogawersRevenue(data);
    }
  }
}
