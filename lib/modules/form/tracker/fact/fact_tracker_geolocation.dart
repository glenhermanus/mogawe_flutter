import 'package:flutter/material.dart';
import 'package:mogawe/core/data/response/form/fact.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/modules/address/widgets/maps_location_picker.dart';
import 'package:mogawe/modules/form/handler/form_handler.dart';

class FactTrackerGeoLocation extends StatefulWidget {

  const FactTrackerGeoLocation({
    required this.fact,
    required this.incrementCounterCallback,
    required this.sendChangedFact,
  });

  final Fact fact;
  final NotifyIncrementCounterHandler incrementCounterCallback;
  final SendChangedFact sendChangedFact;

  @override
  _FactTrackerGeoLocationState createState() => _FactTrackerGeoLocationState();
}

class _FactTrackerGeoLocationState extends State<FactTrackerGeoLocation> {
  String _address = "";
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(6, 16, 6, 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.check_circle,
                color: _address == "" ? FlutterFlowTheme.tertiaryColor :
                FlutterFlowTheme.primaryColor,
              ),
              SizedBox(width: 8),
              Text(widget.fact.factName),
              Spacer(),
              FFButtonWidget(
                text: "Pick Location",
                onPressed: () async {
                  var result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MapsLocationPicker(),
                      ));
                  if (result != null || result != "") {
                    setState(() {
                      _addressLat = result['latitude'] as double;
                      _addressLng = result['longitude'] as double;
                      _textAddressLat = _addressLat.toString();
                      _textAddressLng = _addressLng.toString();
                      _address = result['address'] as String;
                    });

                    if(!_isAlreadyNotify){
                      widget.incrementCounterCallback();
                    }

                    widget.fact.input = "$_addressLat~$_addressLng~$_address";
                    widget.sendChangedFact(widget.fact);
                  }
                },
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
          Text(_address == "" ? "" : "$_textAddressLat , $_textAddressLng"),
          SizedBox(height: 4),
          Text(_address),
        ],
      ),
    );
  }
}