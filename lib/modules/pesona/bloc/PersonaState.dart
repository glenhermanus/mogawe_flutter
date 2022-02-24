import 'package:mogawe/core/data/response/pesona/detail_pesona_response.dart';

abstract class PersonaState {}

class InitPersonaState extends PersonaState{}

class ShowLoadingPersona extends PersonaState {}

class ShowPersonaDetail extends PersonaState {
  DetailPesonaResponses detailPersona;
  ShowPersonaDetail(this.detailPersona);
}