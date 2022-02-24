abstract class PersonaEvent {}

class GetPersonaDetail extends PersonaEvent {
  final String uuidJob;
  GetPersonaDetail(this.uuidJob);
}