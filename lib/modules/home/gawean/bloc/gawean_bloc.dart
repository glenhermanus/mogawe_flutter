import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/core/repositories/gawean_repository.dart';
import 'package:mogawe/modules/home/gawean/bloc/gawean_event.dart';
import 'package:mogawe/modules/home/gawean/bloc/gawean_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GaweanBloc extends Bloc<GaweanEvent, GaweanState> {
  late GaweanRepository _gaweanRepository;
  int menuIndex = 0;
  late String _userToken;

  late StreamController<int> _counterStateController ;
  StreamSink<int> get _inCounter => _counterStateController.sink;
  Stream<int> get counter => _counterStateController.stream;

  final _counterEventController = StreamController<GaweanEvent>();
  Sink<GaweanEvent> get counterEventSink => _counterEventController.sink;

  GaweanBloc() : super(InitGaweanState()) {
    _gaweanRepository = GaweanRepository.instance;
    _counterStateController = StreamController<int>();
    _counterEventController.stream.listen(mapEventToState);
  }

  @override
  Stream<GaweanState> mapEventToState(GaweanEvent event) async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userToken = await AuthRepository().readSecureData('token') as String;

    if (event is GetGaweanListEvent) {
      yield ShowLoadingListGaweanState();
      var data = await _gaweanRepository.getGaweanRowList(realToken: _userToken);
      if (data.isEmpty) {
        yield ShowEmptyListState();
      } else {
        yield ShowListGaweanState(data);
      }
    }

    if(event is ChangeMenuToGawean){
      menuIndex = 0;
      _inCounter.add(menuIndex);
    }

    if(event is ChangeMenuToEtalase) {
      menuIndex = 1;
      _inCounter.add(menuIndex);
    }
  }

  void dispose(){
    _counterStateController.close();
  }
}
