import 'package:flutter/material.dart';
import 'package:mogawe/core/data/response/form/fact.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/modules/address/widgets/maps_location_picker.dart';
import 'package:mogawe/modules/form/handler/form_handler.dart';

class FactGeoLocation extends StatefulWidget {

  const FactGeoLocation({
    required this.fact,
    required this.incrementCounterCallback,
    required this.sendChangedFact,
  });

  final Fact fact;
  final NotifyIncrementCounterHandler incrementCounterCallback;
  final SendChangedFact sendChangedFact;

  @override
  _FactGeoLocationState createState() => _FactGeoLocationState();
}

class _FactGeoLocationState extends State<FactGeoLocation> {
  String _address = "";
  double _addressLat = 0.0;
  double _addressLng = 0.0;

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
                      _address = result['address'] as String;
                    });

                    widget.incrementCounterCallback();
                    widget.fact.input = "$_addressLat, $_addressLng, $_address";
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
          Text(_address == "" ? "" : "$_addressLat , $_addressLng"),
          SizedBox(height: 4),
          Text(_address),
        ],
      ),
    );
  }
}