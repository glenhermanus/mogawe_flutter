import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'continous_form_event.dart';
import 'continous_form_state.dart';

class ContinuousFormBloc
    extends Bloc<ContinuousFormEvent, ContinuousFormState> {
  int _currentProgress = 0;

  final _counterStateController = StreamController<int>();
  StreamSink<int> get _inController => _counterStateController.sink;
  Stream<int> get currentProgress => _counterStateController.stream;

  ContinuousFormBloc() : super(InitContinuousFormState());

  @override
  Stream<ContinuousFormState> mapEventToState(
      ContinuousFormEvent event) async* {
    if (event is ShowContinuousFormEvent) {
      yield ShowContinuousFormState(event.form);
    }
    if (event is NotifyIncrementCounter) {
      _currentProgress++;
      print("increment continuous form with progress $_currentProgress");
    }
    if (event is NotifyDecrementCounter) {
      _currentProgress--;
      print("decrement continuous form with progress $_currentProgress");
    }
    if(_currentProgress < 0){
      _currentProgress = 0;
    }

    _inController.add(_currentProgress);
  }

  void dispose(){
    _counterStateController.close();
  }
}
