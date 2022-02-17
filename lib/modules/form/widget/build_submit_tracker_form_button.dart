import 'package:flutter/material.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';

Widget buildSubmitTrackerFormButton({
  required Function() onPressed,
  required Color color,
}) {
  return Padding(
    padding:
        const EdgeInsets.only(top: 18.0, bottom: 28.0, left: 18.0, right: 18.0),
    child: FFButtonWidget(
      text: "Kirim",
      onPressed: onPressed,
      options: FFButtonOptions(
        height: 60,
        width: double.infinity,
        color: color,
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
  );
}
