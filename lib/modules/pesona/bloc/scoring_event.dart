import 'dart:io';

abstract class ScoringEvent {}

class GetScoringEvent extends ScoringEvent {}

class GetCertificateEvent extends ScoringEvent{}

class GetScoringStatusEvent extends ScoringEvent {}

class GetScoringCountEvent extends ScoringEvent {}

class GetScoringPendingEvent extends ScoringEvent {}

class GetScoringVerifEvent extends ScoringEvent {}

class GetScoringExpiredEvent extends ScoringEvent {}

