abstract class PersonaEvent {}

class GetPersonaDetail extends PersonaEvent {
  final String uuidJob;
  final bool isFromBanner;
  GetPersonaDetail(this.uuidJob, this.isFromBanner);
}