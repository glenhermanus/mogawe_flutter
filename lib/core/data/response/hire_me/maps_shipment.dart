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
  String? _address, _addressLatest, lat,long;
  GoogleMapController? mapController;
  Set<Marker> marker = new Set<Marker>();
  loc.Location location = loc.Location();
  GoogleMapController? _controller;
  LatLng _initialcameraposition = LatLng(-6.200000, 106.816666);
  TextEditingController detail_alamat = new TextEditingController();
  bool _loadingButton = false;
  LatLng _lasMarker = LatLng(-6.200000, 106.816666);
  double? latLatest, longLatest;

  void _onMapCreated(GoogleMapController _cntlr)
  {
    _controller = _controller;
    location.onLocationChanged.listen((l) {
      _controller?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude as double, l.longitude as double),zoom: 15),
        ),
      );
      marker =   Set<Marker>.of(
        <Marker>[
          Marker(
            draggable: true,
            markerId: MarkerId("1"),
            position: _initialcameraposition,
            icon: BitmapDescriptor.defaultMarker,
            onTap: (){
              if(_addressLatest == null){
                detail_alamat.text =  _address!;
              }
              else{
                detail_alamat.text = _addressLatest!;
              }},
            onDragEnd: ((newPosition) {
              print(newPosition.latitude);
              print(newPosition.longitude);
              latLatest = newPosition.latitude;
              longLatest = newPosition.longitude;
              _lasMarker = LatLng(latLatest as double,longLatest as double);
            }),

            infoWindow: const InfoWindow(
              title: 'Pilih Lokasi',
            ),
          )
        ],
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
    if (!mounted) return;
    setState(() {
      _initialcameraposition = LatLng(_currentPosition!.latitude as double,_currentPosition!.longitude as double);
      location.onLocationChanged.listen((loc.LocationData currentLocation) {
        _currentPosition = currentLocation;
        if (!mounted) return;
        _initialcameraposition = LatLng(_currentPosition!.latitude as double,_currentPosition!.longitude as double);
        _getAddress(_currentPosition?.latitude as double,_currentPosition?.longitude as double)
            .then((value) {
          _address = "${value.first.street} ${value.first.subLocality} ${value.first.locality} ${value.first.administrativeArea} "
              "${value.first.subAdministrativeArea} ${value.first.postalCode}";
          detail_alamat.text =  _address  as String;


        });
        _latestAddress(latLatest as double,longLatest as double).then((value) {
          _addressLatest = "${value.first.street} ${value.first.subLocality} ${value.first.locality} ${value.first.administrativeArea} "
              "${value.first.subAdministrativeArea} ${value.first.postalCode}";
          detail_alamat.text = _addressLatest as String;
        });
        marker =   Set<Marker>.of(
          <Marker>[
            Marker(

              draggable: true,
              markerId: MarkerId("1"),
              position: _initialcameraposition,
              icon: BitmapDescriptor.defaultMarker,
              onTap: (){   if(_addressLatest == null){
                detail_alamat.text =  _address  as String;
              }
              else{
                detail_alamat.text = _addressLatest!;
              }},
              onDragEnd: ((newPosition) {
                print(newPosition.latitude);
                print(newPosition.longitude);
                latLatest = newPosition.latitude;
                longLatest = newPosition.longitude;

              }),

              infoWindow: const InfoWindow(
                title: 'Pilih Lokasi',
              ),
            )
          ],
        );


      });
    });

  }


  Future<List<Placemark>> _getAddress(double lat, double lang) async {
    final List<Placemark> add = await placemarkFromCoordinates(lat, lang);
    return add;
  }

  Future<List<Placemark>> _latestAddress(double lat, double lang) async {
    final List<Placemark> add = await placemarkFromCoordinates(lat, lang);
    return add;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller?.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoc();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Container(
            color: Colors.white,
            child: Center(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(target: _initialcameraposition,
                          zoom: 15),
                      mapType: MapType.normal,
                      markers:  marker,
                      onMapCreated: _onMapCreated,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                    ),
                  ),

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: DraggableScrollableSheet(
                      expand: false,
                      initialChildSize: 0.35,
                      maxChildSize: 0.35,
                      minChildSize: 0.35,
                      builder: (context, scrollController) =>  StatefulBuilder(
                          builder: (BuildContext context, StateSetter stateSetter) {
                            return Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                  _addressLatest != null ?   _address != null ?  Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: TextFormField(
                                        controller: detail_alamat,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          fillColor: Colors.white,
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
                                    ) : Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: TextFormField(

                                        obscureText: false,
                                        decoration: InputDecoration(
                                          fillColor: Colors.white,
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
                                    ) : Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: TextFormField(

                                      obscureText: false,
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
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
                                  ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 25),
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
                                    ),

                                  ],
                                ),
                              ),
                            );
                          }),),
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
