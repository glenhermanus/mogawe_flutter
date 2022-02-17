import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mogawe/core/repositories/address_repository.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/core/repositories/mulai_merchant_repository.dart';
import 'package:mogawe/modules/profile/blocs/address_event.dart';
import 'package:mogawe/modules/profile/blocs/address_state.dart';
import 'package:mogawe/modules/profile/blocs/mulai_merchant_event.dart';
import 'package:mogawe/modules/profile/blocs/mulai_merchant_state.dart';

class MulaiMerchantBloc extends Bloc<MulaiMerchantEvent, MulaiMerchantState> {
  late MulaiMerchantRepository _repo;
  late var _userToken;

  MulaiMerchantBloc() : super(InitMulaiMerchantState()) {
    _repo = MulaiMerchantRepository.instance;
  }

  @override
  Stream<MulaiMerchantState> mapEventToState(MulaiMerchantEvent event) async* {
    _userToken = await AuthRepository().readSecureData('token');

    if (event is DoUpdatePhotoEvent) {
      print("Map : ${event.file}");
      yield ShowLoadingMerchantState();
      try {
        var msg = await _repo.updatePhotoProfileToko(event.file,realToken: _userToken);
        print(msg.object);

        yield SuccessUpdatePhotoTokoState(msg.object ??'', );
      } catch(ex) {
        yield ShowErrorUploadPhotoState("$ex");
      }
    }

  }

}