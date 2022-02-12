import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mogawe/core/flutter_flow/lat_lng.dart';

Future<Position> locateUser() async {
  return Geolocator
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
}

Future<String> getPlace(LatLng location) async {
  List<Placemark> newPlace =
  await placemarkFromCoordinates(location.latitude, location.longitude);

  Placemark placeMark = newPlace[0];
  String name = placeMark.street ?? "";
  String subLocality = placeMark.subLocality ?? "";
  String locality = placeMark.locality ?? "";
  String administrativeArea = placeMark.administrativeArea ?? "";
  String postalCode = placeMark.postalCode ?? "";
  String country = placeMark.country ?? "";
  String address =
      "$name, $subLocality, $locality, $administrativeArea $postalCode, $country";

  print(address);
  return address;
}