import 'package:flutter/material.dart';
import 'package:mogawe/core/data/response/form/fact.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';

class FactTrackerBoolean extends StatefulWidget {
  const FactTrackerBoolean({required this.fact});

  final Fact fact;

  @override
  _FactTrackerBooleanState createState() => _FactTrackerBooleanState();
}

class _FactTrackerBooleanState extends State<FactTrackerBoolean> {
  int selectionValue = 100;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 16,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.0),
          child: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: selectionValue == 100
                    ? FlutterFlowTheme.tertiaryColor
                    : FlutterFlowTheme.primaryColor,
              ),
              SizedBox(width: 8),
              Text(widget.fact.factName),
            ],
          ),
        ),
        RadioListTile(
          value: 0,
          groupValue: selectionValue,
          title: Text("Yes"),
          onChanged: (value) {
            setState(() {
              selectionValue = 0;
            });
          },
        ),
        RadioListTile(
          value: 1,
          groupValue: selectionValue,
          title: Text("No"),
          onChanged: (value) {
            setState(() {
              selectionValue = 1;
            });
          },
        ),
      ],
    );
  }
}
