import 'package:flutter_bloc/flutter_bloc.dart';
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
    _userToken = prefs.getString('token') ?? '';

    if (event is GetGaweanListEvent) {
      yield ShowLoadingListGaweanState();
      try {
        var data =
            await _gaweanRepository.getGaweanRowList(realToken: _userToken);
        if (data.isEmpty) {
          yield ShowEmptyListState();
        } else {
          yield ShowListGaweanState(data);
        }
      } catch (ex) {
        yield ShowErrorGaweanListState("$ex");
      }
    }
  }
}
