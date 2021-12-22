import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/modules/auth/repositories/auth_repository.dart';
import 'package:mogawe/modules/hire_me/sales/working/sales_shipment/sales_address_page.dart';

class LocationShipment extends StatefulWidget {
  String uuid;
  LocationShipment({required this.uuid});

  @override
  _LocationShipmentState createState() => _LocationShipmentState();
}

class _LocationShipmentState extends State<LocationShipment> {
  loc.LocationData? _currentPosition;
  String? _address, lat,long;
  GoogleMapController? mapController;
  Marker? marker;
  loc.Location location = loc.Location();
  GoogleMapController? _controller;
  LatLng _initialcameraposition = LatLng(-6.200000, 106.816666);
  TextEditingController detail_alamat = new TextEditingController();
  bool _loadingButton = false;

  void _onMapCreated(GoogleMapController _cntlr)
  {
    _controller = _controller;
    location.onLocationChanged.listen((l) {
      _controller?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude as double, l.longitude as double),zoom: 15),
        ),
      );
    });
  }

  getLoc() async{
    bool _serviceEnabled;
    loc.PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    setState(() {
      _initialcameraposition = LatLng(_currentPosition!.latitude as double,_currentPosition!.longitude as double);
      location.onLocationChanged.listen((loc.LocationData currentLocation) {
        print("${currentLocation.longitude} : ${currentLocation.longitude}");
        setState(() {

          _currentPosition = currentLocation;
          _initialcameraposition = LatLng(_currentPosition!.latitude as double,_currentPosition!.longitude as double);

          _getAddress(_currentPosition?.latitude as double,_currentPosition?.longitude as double)
              .then((value) {
            setState(() {
              _address = "${value.first.street} ${value.first.subLocality} ${value.first.locality} ${value.first.administrativeArea} "
                  "${value.first.subAdministrativeArea} ${value.first.postalCode}";
              detail_alamat.text = _address as String;
            });
          });
        });
      });
    });

  }


 Future<List<Placemark>> _getAddress(double lat, double lang) async {
   final List<Placemark> add = await placemarkFromCoordinates(lat, lang);
    return add;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
        // code omitted..
        getLoc();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
   _controller?.dispose();
    _onMapCreated;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Container(
            color: Colors.white,
            child: Center(
              child: Column(
                children: [
                  Container(
                    height:  MediaQuery.of(context).size.height/2.5,
                    width: MediaQuery.of(context).size.width,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(target: _initialcameraposition,
                          zoom: 15),
                      mapType: MapType.normal,
                      onMapCreated: _onMapCreated,
                      myLocationEnabled: true,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  SizedBox(
                    height: 3,
                  ),

                  SizedBox(
                    height: 3,
                  ),
                  _address != null ?
                    Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextFormField(
                      controller: detail_alamat,
                      obscureText: false,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Color(0xffbfbfbf),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                      ),
                      maxLines: 3,
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ) : Container(),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 24, 16, 16),
                    child: FFButtonWidget(
                      onPressed: () {
                        AuthRepository().writeSecureData('alamat', _address as String);
                        AuthRepository().writeSecureData('lat', _currentPosition?.latitude.toString() as String);
                        AuthRepository().writeSecureData('long', _currentPosition?.longitude.toString() as String);
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SalesAddress(uuid: widget.uuid,),
                          ),
                        );
                      },
                      text: 'Simpan Alamat',
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 56,
                        color: FlutterFlowTheme.primaryColor,
                        textStyle: FlutterFlowTheme.subtitle2.override(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: 12,
                      ),
                      loading: _loadingButton,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
}
