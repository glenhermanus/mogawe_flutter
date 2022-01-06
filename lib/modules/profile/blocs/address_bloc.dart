import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mogawe/core/repositories/address_repository.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/modules/profile/blocs/address_event.dart';
import 'package:mogawe/modules/profile/blocs/address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  late AddressRepository _repo;
  late var _userToken;

  AddressBloc() : super(InitAddressState()) {
    _repo = AddressRepository.instance;
  }

  @override
  Stream<AddressState> mapEventToState(AddressEvent event) async* {
    _userToken = await AuthRepository().readSecureData('token');

    if (event is GetAddressEvent) {
      yield ShowLoadingAddressState();
      try {
        var data = await _repo.getListPickupAddress(realToken: _userToken);
        if(data.object.isEmpty){
          yield ShowEmptyListAddressState();
        } else {
          yield ShowListAddressPickupState(data.object);
        }
      } catch(ex) {
        yield ShowErrorAddressPickupState("$ex");
      }
    }

    if (event is UpdateDefaultAddressEvent){
        var responseUpload = await _repo.setAddressAsDefault(realToken: _userToken,uuid:  event.uuid);
        var data = await _repo.getListPickupAddress(realToken: _userToken);
        if(responseUpload.returnValue != "000"){
          ShowErrorAddressPickupState("Terjadi kesalahan");
      } else {
          yield ShowListAddressPickupState(data.object);
        }
    }

    if (event is DeletePickupAddressEvent){
      var data = await _repo.deletePickupAddress(realToken: _userToken,uuid:  event.uuid);
      if(data.returnValue != "000"){
        ShowErrorAddressPickupState("Terjadi kesalahan");
      }
    }

  }

}