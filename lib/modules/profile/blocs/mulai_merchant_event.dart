import 'dart:io';

abstract class MulaiMerchantEvent {}

class GetMulaiMerchantEvent extends MulaiMerchantEvent {}

class UpdateDefaultMulaiMerchantEvent extends MulaiMerchantEvent {
  String uuid;

  UpdateDefaultMulaiMerchantEvent(this.uuid);
}

class DoUpdatePhotoEvent extends MulaiMerchantEvent {
  Map<String, File> file;

  DoUpdatePhotoEvent(this.file);
}


class DeletePickupMulaiMerchantEvent extends MulaiMerchantEvent {
  String uuid;

  DeletePickupMulaiMerchantEvent(this.uuid);
}