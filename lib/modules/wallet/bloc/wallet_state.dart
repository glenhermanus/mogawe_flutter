import 'package:mogawe/core/data/response/wallet/wallet_history_model.dart';

abstract class WalletState {}

class InitWalletState extends WalletState {}

class ShowLoadingWalletState extends WalletState {}

class ShowWalletHistoryList extends WalletState {
  List<WalletHistoryModel> list;

  ShowWalletHistoryList(this.list);
}

class ShowErrorGetWalletState extends WalletState {
  String message;

  ShowErrorGetWalletState(this.message);
}
