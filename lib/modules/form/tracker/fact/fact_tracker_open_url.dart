import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mogawe/core/data/response/form/fact.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';

class FactTrackerOpenUrl extends StatefulWidget {
  const FactTrackerOpenUrl({required this.fact});

  final Fact fact;

  @override
  _FactTrackerOpenUrlState createState() => _FactTrackerOpenUrlState();
}

class _FactTrackerOpenUrlState extends State<FactTrackerOpenUrl> {
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
              /*Icon(
                Icons.check_circle,
                color: _address == "" ? FlutterFlowTheme.tertiaryColor :
                FlutterFlowTheme.primaryColor,
              ),*/
              SizedBox(width: 8),
              Text(widget.fact.factName),
              Spacer(),
              FFButtonWidget(
                text: "Open URL",
                onPressed: () async {
                  Clipboard.setData(new ClipboardData(text: widget.fact.factName)).then((_) {
                    Fluttertoast.showToast(msg: "URL has been copied");
                  });
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
          SizedBox(height: 4)
        ],
      ),
    );
  }
}
