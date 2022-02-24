abstract class HomeEvent {}

class GetAdsBanner extends HomeEvent {}

class DoUpdateTargetRevenueEvent extends HomeEvent {
  final int revenue;

  DoUpdateTargetRevenueEvent(this.revenue);
}

class GetTargetContent extends HomeEvent {}

class GetTarget extends HomeEvent {}
