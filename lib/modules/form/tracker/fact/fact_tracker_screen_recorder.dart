import 'package:flutter/material.dart';
import 'package:mogawe/core/data/response/form/fact.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';

class FactTrackerScreenRecorder extends StatefulWidget {
  const FactTrackerScreenRecorder({required this.fact});

  final Fact fact;

  @override
  _FactTrackerScreenRecorderState createState() => _FactTrackerScreenRecorderState();
}

class _FactTrackerScreenRecorderState extends State<FactTrackerScreenRecorder> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Icon(
                Icons.check_circle,
                color: FlutterFlowTheme.primaryColor,
              ),
              SizedBox(width: 8),
              Text(widget.fact.factName),
            ],
          ),
          Text(widget.fact.hintName),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: InkWell(
                onTap: () async => print("Voice recorder pressed"),
                child: _buildDottedPlaceHolder()),
          ),
        ],
      ),
    );
  }

  Widget _buildDottedPlaceHolder() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          shape: BoxShape.circle
      ),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Icon(
          Icons.videocam_outlined,
          size: 48,
          color: Colors.grey,
        ),
      ),
    );
  }

}
