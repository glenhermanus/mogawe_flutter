import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:mogawe/constant/const.dart';
import 'package:mogawe/core/data/response/hire_me/instant/task_instant.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/utils/global/common_function.dart';
import 'package:mogawe/utils/ui/animation/bounce_tap.dart';

class HireMeInstantDetailPage extends StatefulWidget {
  const HireMeInstantDetailPage(
      {required this.taskInstant, required this.timerSeconds, Key? key})
      : super(key: key);
  final TaskInstant taskInstant;
  final int? timerSeconds;

  @override
  _HireMeInstantDetailPageState createState() =>
      _HireMeInstantDetailPageState();
}

class _HireMeInstantDetailPageState extends State<HireMeInstantDetailPage> {
  Completer<GoogleMapController> _controller = Completer();

  late Timer _timer;
  bool _isTimeOut = false;
  int _timerLeft = 59;

  late LatLng? _initialCameraPosition;
  List<LatLng> _boundsLocation = [];
  final Set<Polyline> _polylines = {};

  PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polylineCoordinates = [];

  loc.Location location = loc.Location();
  loc.LocationData? _currentPosition;

  @override
  void initState() {
    super.initState();
    _initialCameraPosition = null;
    _timerLeft = widget.timerSeconds ?? 59;
    _startTimer();
    _getUserCurrentLocation();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_timerLeft == 0) {
          setState(() {
            timer.cancel();
            _isTimeOut = true;
          });
        } else {
          setState(() {
            _timerLeft--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.secondaryColor,
        iconTheme: IconThemeData(color: FlutterFlowTheme.tertiaryColor),
        automaticallyImplyLeading: true,
        title: Text(
          'Detail Project',
          style: FlutterFlowTheme.subtitle1.override(
            fontFamily: 'Poppins',
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.share,
              color: FlutterFlowTheme.primaryColor,
            ),
          ),
        ],
        centerTitle: false,
        elevation: 0,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Expanded(child: _buildContent()),
        _buildProjectFooter(),
      ],
    );
  }

  Widget _buildContent() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: widget.taskInstant.jobPicture != null ? true : false,
              child: Image.network(
                widget.taskInstant.jobPicture ??
                    "https://sbu.co.id/info/wp-content/themes/easymag/images/no-image.png",
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 24, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.taskInstant.jobName}",
                    style:
                        FlutterFlowTheme.title1.copyWith(fontFamily: "Roboto"),
                  ),
                  SizedBox(height: 24),
                  _descriptionSection(),
                  SizedBox(height: 24),
                  _informationSection(),
                  SizedBox(height: 24),
                  _mapSection()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _informationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "INFORMASI",
          style: FlutterFlowTheme.subtitle1,
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          decoration: BoxDecoration(
              color: FlutterFlowTheme.fieldColor,
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icon/ic_time_grey.svg",
                      height: 32,
                    ),
                    SizedBox(width: 12),
                    Text(
                      widget.taskInstant.expiredDate.toString() == "null"
                          ? "--"
                          : widget.taskInstant.expiredDate,
                      style: FlutterFlowTheme.subtitle3
                          .copyWith(color: Colors.black, fontFamily: 'Roboto'),
                    )
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icon/ic_money_grey.svg",
                      height: 32,
                    ),
                    SizedBox(width: 12),
                    Text(
                      widget.taskInstant.fee.toString() == "null"
                          ? "--"
                          : "Rp ${widget.taskInstant.fee}",
                      style: FlutterFlowTheme.subtitle3
                          .copyWith(color: Colors.black, fontFamily: 'Roboto'),
                    )
                  ],
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _descriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "DESKRIPSI",
          style: FlutterFlowTheme.subtitle1,
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: FlutterFlowTheme.fieldColor,
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.taskInstant.jobDescription ??
                      "Deksripsi tidak tersedia",
                  style: FlutterFlowTheme.subtitle3.copyWith(
                      color: FlutterFlowTheme.tertiaryColor,
                      fontFamily: 'Roboto'),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  CameraPosition taskInstantLocation(double lat, double lng) {
    return CameraPosition(
        target: LatLng(37.43296265331129, -122.08832357078792));
  }

  Widget _mapSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "MAP",
          style: FlutterFlowTheme.subtitle1,
        ),
        SizedBox(
          height: 12,
        ),
        Stack(
          children: [
            Container(
              height: 450,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: _initialCameraPosition == null
                    ? Container(
                        child: Center(
                          child: Text(
                            'loading map..',
                            style: TextStyle(
                                fontFamily: 'poppins', color: Colors.grey[400]),
                          ),
                        ),
                      )
                    : GoogleMap(
                        gestureRecognizers: {
                          Factory<OneSequenceGestureRecognizer>(
                            () => EagerGestureRecognizer(),
                          ),
                        },
                        onMapCreated: (GoogleMapController controller) {
                          Future.delayed(
                            Duration(milliseconds: 200),
                            () => controller.animateCamera(
                              CameraUpdate.newLatLngBounds(
                                  boundsFromLatLngList(_boundsLocation), 1),
                            ),
                          );
                          _controller.complete(controller);
                          _setPolylines();
                        },
                        myLocationEnabled: true,
                        mapType: MapType.normal,
                        markers: Set.from(_getTaskMarker()),
                        polylines: _polylines,
                        initialCameraPosition: CameraPosition(
                            target: _initialCameraPosition ?? LatLng(0.0, 0.0),
                            zoom: _initialCameraPosition == null ? 0 : 15),
                      ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              margin: EdgeInsets.fromLTRB(18, 18, 18, 0),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: FlutterFlowTheme.primaryColor),
                    child: SvgPicture.asset("assets/icon/ic_location_red.svg",
                        height: 24, color: Colors.white),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Flexible(
                    child: Text(
                      "${widget.taskInstant.locationName} - ${widget.taskInstant.locationAddress}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: FlutterFlowTheme.subtitle2
                          .copyWith(color: Colors.black, fontFamily: 'Roboto'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: 12,
        ),
      ],
    );
  }

  Widget _buildProjectFooter() {
    return Container(
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
            color: Colors.black54, blurRadius: 10.0, offset: Offset(0.0, 1.2))
      ], color: Colors.white),
      height: 130,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.lightBlue),
                borderRadius: BorderRadius.circular(10)),
            child: Text(_timerLeft < 10 ? "00:0$_timerLeft" : "00:$_timerLeft"),
          ),
          SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: FFButtonWidget(
              onPressed: () {},
              text: 'Accept',
              options: FFButtonOptions(
                width: double.infinity,
                height: 45,
                color: _isTimeOut
                    ? FlutterFlowTheme.tertiaryColorLighter
                    : FlutterFlowTheme.moGaweGreen,
                textStyle: FlutterFlowTheme.subtitle2.override(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: 20,
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BounceTap(
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: FlutterFlowTheme.primaryColor),
                    ),
                    onTap: () {}),
                BounceTap(
                    child: Text(
                      'Next',
                      style: TextStyle(
                          color: FlutterFlowTheme.tertiaryDarkerColor),
                    ),
                    onTap: () {}),
              ],
            ),
          ),
          SizedBox(height: 16)
        ],
      ),
    );
  }

  List<Marker> _getTaskMarker() {
    List<Marker> markers = [];

    markers.add(Marker(
      markerId: MarkerId(widget.taskInstant.uuid),
      position: LatLng(double.parse(widget.taskInstant.latitude),
          double.parse(widget.taskInstant.longitude)),
    ));
    setState(() {
      _boundsLocation.add(LatLng(double.parse(widget.taskInstant.latitude),
          double.parse(widget.taskInstant.longitude)));
    });

    return markers;
  }

  _setPolylines() async {
    PointLatLng origin = PointLatLng(
        _initialCameraPosition!.latitude, _initialCameraPosition!.longitude);
    PointLatLng dest = PointLatLng(double.parse(widget.taskInstant.latitude),
        double.parse(widget.taskInstant.longitude));

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        GOOGLE_MAP_API, origin, dest);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    print("Google map keys is $GOOGLE_MAP_API");

    print("Dapat result ${result.errorMessage} with status ${result.status}");

    setState(() {
      Polyline polyline = Polyline(
          polylineId: PolylineId("poly"),
          color: Color.fromARGB(255, 40, 122, 198),
          points: polylineCoordinates);
      _polylines.add(polyline);
    });
  }

  void _getUserCurrentLocation() async {
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

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    setState(() {
      _initialCameraPosition = LatLng(position.latitude, position.longitude);
      _boundsLocation.add(LatLng(position.latitude, position.longitude));
      print('testplace ${placemark[0].administrativeArea}');
    });
  }

  TaskInstant _mockGawean() {
    TaskInstant task = new TaskInstant(
        id: 799691,
        uuid: "5945de39-40fc-11ec-a9de-755c917b66f3",
        uuidMogawers: null,
        idMogawers: 0,
        uuidQueue: "376343cc-a8a8-4d29-a1af-5a72728f0f2f",
        statusTask: null,
        statusNotes: null,
        groupTask: null,
        sequence: null,
        limit: null,
        isPinned: null,
        isStarting: null,
        startDate: null,
        receivedDate: null,
        expiredDate: null,
        assignmentType: null,
        uuidJob: "5945de39-40fc-11ec-a9de-755c917b66f3",
        jobName: "RAJA SUSU KAMAL",
        jobDescription: null,
        uuidJobType: "e6d88855-76e3-4139-98aa-b98c1a1fd010",
        uuidLocationType: "2d144ea3-4322-11e9-b2bb-42010a940029",
        uuidLocation: "f3214387-4ec7-49ab-90b6-d10c43c8d999",
        uuidLocationLevel: null,
        uuidProject: "c82e8cda-880e-4013-b55f-c54e03f7dc87",
        projectName: null,
        projectDescription: null,
        uuidBatch: null,
        batchName: null,
        latitude: "-6.132553",
        longitude: "106.729324",
        name: "RAJA SUSU KAMAL",
        locationName: "RAJA SUSU KAMAL",
        locationAddress:
            "Jl. Kamal Raya No.26 RT.1/RW.8 Cengkareng Bar. Kecamatan Cengkareng Kota Jakarta Barat Daerah Khusus Ibukota Jakarta 11730 Indonesia Kecamatan Cengkareng 11730",
        locationLevel: "7",
        jobTypeName: "Observation",
        tutorial: "https://www.youtube.com/watch?v=G1IbRujko-A",
        code: null,
        description: "Survey minimarket",
        brief: null,
        howTo: null,
        minimumLevel: 1,
        jobLimit: null,
        fee: 0,
        type: null,
        isScreening: null,
        isDirect: false,
        target: 1,
        points: 0,
        duration: "0",
        schedule: null,
        isPublished: false,
        isAutoApproved: false,
        locationDescription: "",
        isQcNeeded: true,
        isHaveArea: null,
        jobPicture: null,
        jobBanner: null,
        jobColor: null,
        jobTextColor: null,
        radius: 100,
        defaulLimit: null,
        postMessage: null,
        resultCount: null,
        mogawersCode: null,
        fullName: null,
        email: null,
        jobId: "799691",
        category: null,
        isDisplayable: false,
        isAssigned: false,
        jobActions: null,
        certificates: null,
        jobTimes: null,
        endDate: null,
        uuidOrder: null,
        uuidTaskOrder: null,
        uuidTaskOrderJob: null,
        idTask: "5945de39-40fc-11ec-a9de-755c917b66f3");

    return task;
  }
}
