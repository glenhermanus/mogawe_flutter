import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/core/repositories/wallet_repository.dart';
import 'package:mogawe/modules/wallet/bloc/wallet_event.dart';
import 'package:mogawe/modules/wallet/bloc/wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  late WalletRepository _repo;
  late var _userToken;

  WalletBloc() : super(InitWalletState()) {
    _repo = WalletRepository.instance;
  }

  @override
  Stream<WalletState> mapEventToState(WalletEvent event) async* {
    _userToken = await AuthRepository().readSecureData('token');

    if (event is GetWalletHistoryEvent) {
      yield ShowLoadingWalletState();
      try {
        var data = await _repo.getProfileHistory(realToken: _userToken);
        yield ShowWalletHistoryList(data);
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
