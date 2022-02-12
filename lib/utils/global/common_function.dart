import 'package:google_maps_flutter/google_maps_flutter.dart';

double mogaweCalculatePercentage({required int current, required int total}) {
  double result = (current * 100) / total * 0.01;
  return result;
}

LatLngBounds boundsFromLatLngList(List<LatLng> list) {
  assert(list.isNotEmpty);
  double x0 = 0, x1 = 0, y0 = 0, y1 = 0;
  for (LatLng latLng in list) {
    if (x0 == 0) {
      x0 = x1 = latLng.latitude;
      y0 = y1 = latLng.longitude;
    } else {
      if (latLng.latitude > x1) x1 = latLng.latitude;
      if (latLng.latitude < x0) x0 = latLng.latitude;
      if (latLng.longitude > y1) y1 = latLng.longitude;
      if (latLng.longitude < y0) y0 = latLng.longitude;
    }
  }
  return LatLngBounds(northeast: LatLng(x1, y1), southwest: LatLng(x0, y0));
}
