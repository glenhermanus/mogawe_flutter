abstract class ProfileEvent {}

class GetProfileEvent extends ProfileEvent {}

class DoUpdateProfileEvent extends ProfileEvent {
  Map<String, String> map;

  DoUpdateProfileEvent(this.map);
}

class DoUpdateTargetRevenueEvent extends ProfileEvent {
  Map<String, dynamic> map;

  DoUpdateTargetRevenueEvent(this.map);
}