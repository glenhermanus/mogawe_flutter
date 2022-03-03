import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/core/repositories/pesona_repository.dart';
import 'package:mogawe/core/repositories/sales_repository.dart';
import 'package:mogawe/modules/hire_me/sales/bloc/sales_event.dart';
import 'package:mogawe/modules/hire_me/sales/bloc/sales_state.dart';
import 'package:mogawe/modules/pesona/bloc/pesona_event.dart';
import 'package:mogawe/modules/pesona/bloc/pesona_state.dart';

class SalesBloc extends Bloc<SalesEvent, SalesState> {
  late SalesRepository _repo;
  late var _userToken;

  SalesBloc() : super(InitSalesState()) {
    _repo = SalesRepository.instance;
  }

  @override
  Stream<SalesState> mapEventToState(SalesEvent event) async* {
    _userToken = await AuthRepository().readSecureData('token');
    if (event is GetSalesEvent) {
      yield ShowLoadingSalesState();
      try {
        var data = await _repo.hiremeSalesresponse(realToken: _userToken);
        if(data.isEmpty){
          yield ShowEmptyListSalesState();
        } else {
          yield ShowListSalesState(data);
        }
      } catch(ex) {
        yield ShowErrorSalesState("$ex");
      }
    }
    if (event is GetSalesFavorite) {
      yield ShowLoadingFavoriteState();
      try {
        var data = await _repo.favSalesResponse(realToken: _userToken);
        if(data.isEmpty){
          yield ShowEmptyListFavoriteState();
        } else {
          yield ShowListFavoriteState(data);
        }
      } catch(ex) {
        yield ShowErrorFavoriteState("$ex");
      }
    }

    if (event is GetSalesFavoriteUpdate) {
      try {
        var data = await _repo.favSalesResponse(realToken: _userToken);
        if(data.isEmpty){
          yield ShowEmptyListFavoriteState();
        } else {
          yield ShowListFavoriteState(data);
        }
      } catch(ex) {
        yield ShowErrorFavoriteState("$ex");
      }
    }

  }

}