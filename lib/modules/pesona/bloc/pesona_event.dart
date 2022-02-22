import 'dart:io';

abstract class PesonaEvent {}

class GetPesonaEvent extends PesonaEvent {}
class GetPesonaCertificate extends PesonaEvent{}
class GetPesonaStatusEvent extends PesonaEvent {}

class UpdateDefaultPesonaEvent extends PesonaEvent {
  String uuid;

  UpdateDefaultPesonaEvent(this.uuid);
}

class DoUpdatePhotoEvent extends PesonaEvent {
  Map<String, File> file;

  DoUpdatePhotoEvent(this.file);
}


class DeletePickupPesonaEvent extends PesonaEvent {
  String uuid;

  DeletePickupPesonaEvent(this.uuid);
}