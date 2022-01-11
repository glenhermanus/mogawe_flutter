import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:logger/logger.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/utils/ui/widgets/MogawePrimaryButton.dart';

class MapsLocationPicker extends StatefulWidget {
  MapsLocationPicker();

  @override
  _MapsLocationPickerState createState() => _MapsLocationPickerState();
}

class _MapsLocationPickerState extends State<MapsLocationPicker> {
  var logger = Logger(printer: PrettyPrinter());

  loc.LocationData? _currentPosition;
  String? _address, _addressLatest, lat, long;
  GoogleMapController? mapController;
  Set<Marker> marker = new Set<Marker>();
  loc.Location location = loc.Location();
  GoogleMapController? _controller;
  LatLng _initialcameraposition = LatLng(-6.200000, 106.816666);
  TextEditingController detail_alamat = new TextEditingController();
  TextEditingController _editDetailAlamatSelected = new TextEditingController();
  bool _loadingButton = false;
  double? latLatest, longLatest;

  List<Marker> myMarker = [];
  String markedAddress = "";
  late double markedLatitude, markedLongitude;

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _controller;
    location.onLocationChanged.listen((l) {
      _controller?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(l.latitude as double, l.longitude as double),
              zoom: 15),
        ),
      );
      marker = Set<Marker>.of(
        <Marker>[
          Marker(
            draggable: true,
            markerId: MarkerId("1"),
            position: _initialcameraposition,
            icon: BitmapDescriptor.defaultMarker,
            onTap: () {
              if (markedAddress == "") {
                detail_alamat.text = _address!;
              } else {
                detail_alamat.text = markedAddress;
              }
            },
            infoWindow: const InfoWindow(
              title: 'Pilih Lokasi',
            ),
          )
        ],
      );
    });
  }

  getLoc() async {
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
      _initialcameraposition = LatLng(_currentPosition!.latitude as double,
          _currentPosition!.longitude as double);
      location.onLocationChanged.listen((loc.LocationData currentLocation) {
        _currentPosition = currentLocation;
        if (!mounted) return;
        if(_currentPosition?.latitude != null &&  _currentPosition?.longitude != null){
          _initialcameraposition = LatLng(_currentPosition?.latitude ?? 0.0,
              _currentPosition?.longitude ?? 0.0);
          _getAddress(_currentPosition?.latitude ?? 0.0,
              _currentPosition?.longitude ?? 0.0)
              .then((value) {
          });
          marker = Set<Marker>.of(
            <Marker>[
              Marker(
                draggable: true,
                markerId: MarkerId("1"),
                position: _initialcameraposition,
                icon: BitmapDescriptor.defaultMarker,
                onTap: () {
                  if (_addressLatest == null) {
                    detail_alamat.text = _address as String;
                  } else {
                    detail_alamat.text = _addressLatest!;
                  }
                },
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
        }
      });
    });
  }

  Future<List<Placemark>> _getAddress(double lat, double lang) async {
    final List<Placemark> add = await placemarkFromCoordinates(lat, lang);
    return add;
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
    detail_alamat.dispose();
    _editDetailAlamatSelected.dispose();
  }

  @override
  void initState() {
    super.initState();
    getLoc();
  }

  @override
  Widget build(BuildContext context) {
    _editDetailAlamatSelected.text = markedAddress;
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Container(
            color: Colors.white,
            child: Center(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(color: Colors.white),
                    width: MediaQuery.of(context).size.width,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                          target: _initialcameraposition, zoom: 15),
                      mapType: MapType.normal,
                      markers: Set.from(myMarker),
                      onMapCreated: _onMapCreated,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      onTap: _handleGoogleMapTap,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: DraggableScrollableSheet(
                      expand: false,
                      initialChildSize: 0.40,
                      maxChildSize: 0.40,
                      minChildSize: 0.0,
                      builder: (context, scrollController) => StatefulBuilder(
                          builder:
                              (BuildContext context, StateSetter stateSetter) {
                        return Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: TextFormField(
                                    controller: markedAddress == "" ? detail_alamat : _editDetailAlamatSelected,
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
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 10, 16, 25),
                                  child: MogawePrimaryButton(
                                    onTap: () {
                                      if(markedLongitude != null && markedLatitude != null){
                                        _saveAddress(markedAddress != "" ? markedAddress : _address ?? "", markedLatitude, markedLongitude);
                                      }
                                    },
                                    buttonText: "Simpan Lokasi",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
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

  void _handleGoogleMapTap(LatLng tapPoint) {
    setState(() {
      myMarker = [];
      myMarker.add(
        Marker(markerId: MarkerId(tapPoint.toString()), position: tapPoint),
      );
      markedLatitude = tapPoint.latitude;
      markedLongitude = tapPoint.longitude;

      _getPlace(tapPoint);
    });
  }

  void _getPlace(LatLng tapPoint) async {
    List<Placemark> newPlace =
        await placemarkFromCoordinates(tapPoint.latitude, tapPoint.longitude);

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
    markedAddress = address;
  }

  void _saveAddress(String address, double latitude, double longitude) {
    logger.d("back and save dengan address $address");
    Navigator.of(context).pop({'address': address, 'latitude': latitude, 'longitude': longitude});
  }
}
