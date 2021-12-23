import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mogawe/modules/auth/repositories/auth_repository.dart';
import 'package:mogawe/modules/auth/repositories/wallet_repository.dart';
import 'package:mogawe/modules/wallet/bloc/wallet_event.dart';
import 'package:mogawe/modules/wallet/bloc/wallet_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EWalletBloc extends Bloc<WalletEvent, WalletState> {
  late WalletRepository _repo;
  late String _userToken;

  EWalletBloc() : super(InitWalletState()) {
    _repo = WalletRepository.instance;
  }
  @override
  Stream<WalletState> mapEventToState(WalletEvent event) async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userToken = await AuthRepository().getToken() ?? "";

    if (event is GetEWalletWithdrawNominalEvent) {
      yield ShowLoadingEWalletNominalState();
      try {
        var data = await _repo.getEWalletNominal(realToken: _userToken);
        yield ShowEWalletNominal(data);
      } catch (ex) {
        yield ShowErrorGetWalletState("$ex");
      }
    }
    if (event is GetEWalletListEvent) {
      yield ShowLoadingEWalletState();
      try {
        var data = await _repo.getEWalletList(realToken: _userToken);
        yield ShowEWalletList(data);
      } catch (ex) {
        yield ShowErrorGetWalletState("$ex");
      }
    }
  }
}
