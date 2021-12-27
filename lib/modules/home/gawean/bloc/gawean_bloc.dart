import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/core/repositories/gawean_repository.dart';
import 'package:mogawe/modules/home/gawean/bloc/gawean_event.dart';
import 'package:mogawe/modules/home/gawean/bloc/gawean_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GaweanBloc extends Bloc<GaweanEvent, GaweanState> {
  late GaweanRepository _gaweanRepository;
  late String _userToken;

  GaweanBloc() : super(InitGaweanState()) {
    _gaweanRepository = GaweanRepository.instance;
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
      // try {
      //
      // } catch (ex) {
      //   yield ShowErrorGaweanListState("$ex");
      // }
    }
  }
}
