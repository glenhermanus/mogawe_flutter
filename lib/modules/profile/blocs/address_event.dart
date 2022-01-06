abstract class AddressEvent {}

class GetAddressEvent extends AddressEvent {}

class UpdateDefaultAddressEvent extends AddressEvent {
  String uuid;

  UpdateDefaultAddressEvent(this.uuid);
}

class DeletePickupAddressEvent extends AddressEvent {
  String uuid;

  DeletePickupAddressEvent(this.uuid);
}