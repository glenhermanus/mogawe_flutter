import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mogawe/core/data/response/form/fact.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/core/flutter_flow/lat_lng.dart';
import 'package:mogawe/modules/form/handler/form_handler.dart';
import 'package:mogawe/utils/global/location_function.dart';

class FactTrackerCheckIn extends StatefulWidget {
  const FactTrackerCheckIn({
    required this.fact,
    required this.incrementCounterCallback,
    required this.sendChangedFact,
  });

  final Fact fact;
  final NotifyIncrementCounterHandler incrementCounterCallback;
  final SendChangedFact sendChangedFact;


  @override
  _FactTrackerCheckInState createState() => _FactTrackerCheckInState();
}

class _FactTrackerCheckInState extends State<FactTrackerCheckIn> {
  String _address = "";
  bool _isLoading = false;
  double _addressLat = 0.0;
  double _addressLng = 0.0;
  String _textAddressLat = "";
  String _textAddressLng = "";
  bool _isAlreadyNotify = false;

  @override
  void initState() {
    super.initState();
    if(widget.fact.input?.isNotEmpty ?? true){
      List<String>? results = widget.fact.input?.split('~');
      if(mounted){
        setState(() {
          //Expected Results is (lat,lng,address)
          print("results is $results");
          _textAddressLat = results?[0] ?? "";
          _textAddressLng = results?[1] ?? "";
          _address = results?[2] ?? "";
          _isAlreadyNotify = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(6, 16, 6, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.check_circle,
                color: _address == ""
                    ? FlutterFlowTheme.tertiaryColor
                    : FlutterFlowTheme.primaryColor,
              ),
              SizedBox(width: 8),
              Text(widget.fact.factName),
              Spacer(),
              FFButtonWidget(
                text: "Check-In",
                loading: _isLoading,
                onPressed: _getUserLocation,
                options: FFButtonOptions(
                  height: 40,
                  color: FlutterFlowTheme.primaryColor,
                  textStyle: FlutterFlowTheme.subtitle2.override(
                    fontFamily: 'Poppins',
                    color: FlutterFlowTheme.secondaryColor,
                    fontSize: 14,
                  ),
                  elevation: 0,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: 12,
                ),
              ),
            ],
          ),
          Text(widget.fact.hintName),
          SizedBox(height: 8),
          Text(_address == "" ? "" : "$_addressLat , $_addressLng"),
          SizedBox(height: 4),
          Text(_address),
        ],
      ),
    );
  }

  _getUserLocation() async {
    if(mounted){
      setState(() => _isLoading = true);

      Position currentLocation = await locateUser();
      LatLng userPosition =
      LatLng(currentLocation.latitude, currentLocation.longitude);
      String locationAddress = await getPlace(userPosition);

      setState(() {
        _address = locationAddress;
        _addressLat = userPosition.latitude;
        _addressLng = userPosition.longitude;
        _textAddressLat = _addressLat.toString();
        _textAddressLng = _addressLng.toString();
        _isLoading = false;
      });
    }


    if(_isAlreadyNotify){
      widget.incrementCounterCallback();
    }

    widget.fact.input = "$_addressLat, $_addressLng, $_address";
    widget.sendChangedFact(widget.fact);
  }
}