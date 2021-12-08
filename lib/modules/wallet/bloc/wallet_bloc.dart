import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mogawe/modules/auth/repositories/wallet_repository.dart';
import 'package:mogawe/modules/wallet/bloc/wallet_event.dart';
import 'package:mogawe/modules/wallet/bloc/wallet_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  late WalletRepository _repo;
  late String _userToken;

  WalletBloc() : super(InitWalletState()) {
    _repo = WalletRepository.instance;
  }
  @override
  Stream<WalletState> mapEventToState(WalletEvent event) async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userToken = prefs.getString('token') ?? "";
    //!For Testing Purposes only! change to real token when done
    _userToken =
        "eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJNTy00MjFCM0EiLCJpYXQiOjE2MzQ1MjkxMzEsInN1YiI6Im1vZ2F3ZXJzIiwiaXNzIjoibW9nYXdlIn0.6I3GpI_gB02jpicmXzotWg4webpBU_3kpwFhWAF57bU";

    if (event is GetWalletHistoryEvent) {
      yield ShowLoadingWalletState();
      try {
        var data = await _repo.getProfileHistory(realToken: _userToken);
        yield ShowWalletHistoryList(data);
      } catch (ex) {
        yield ShowErrorGetWalletState("$ex");
      }
    }
  }
}
