import 'dart:io';

abstract class PesonaEvent {}

class GetPesonaEvent extends PesonaEvent {}

class GetPesonaCertificate extends PesonaEvent{}

class GetPesonaStatusEvent extends PesonaEvent {}
