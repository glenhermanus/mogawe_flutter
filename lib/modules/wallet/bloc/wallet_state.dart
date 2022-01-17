import 'package:mogawe/core/data/response/ewallet/ewallet_model.dart';
import 'package:mogawe/core/data/response/ewallet/nominal/ewallet_nominal_model.dart';
import 'package:mogawe/core/data/response/wallet/wallet_history_model.dart';

abstract class WalletState {}

class InitWalletState extends WalletState {}

class ShowLoadingWalletState extends WalletState {}

class ShowLoadingEWalletNominalState extends WalletState{}

class ShowLoadingEWalletState extends WalletState{}

class ShowWalletHistoryList extends WalletState {
  List<WalletHistoryModel> list;

  ShowWalletHistoryList(this.list);
}

class ShowEWalletNominal extends WalletState {
  List<EWalletNominalModel> list;

  ShowEWalletNominal(this.list);
}

class ShowEWalletList extends WalletState {
  List<EWalletModel> list;

  ShowEWalletList(this.list);
}

class ShowEmptyEWalletList extends WalletState {}

class ShowErrorGetWalletState extends WalletState {
  String message;

  ShowErrorGetWalletState(this.message);
}
