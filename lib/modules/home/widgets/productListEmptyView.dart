import 'package:flutter/material.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';

Widget productListEmptyView({required  VoidCallback? onPressed}) {
  return Column(
    children: [
      Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 18),
        child: Image.asset(
          'assets/images/im_no_job.png',
          width: double.infinity,
          height: 242,
          fit: BoxFit.cover,
        ),
      ),
      Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
        child: Text(
          'Wah, kamu belum punya barang \n di etalase nih',
          textAlign: TextAlign.center,
          style: FlutterFlowTheme.subtitle2.override(
            fontFamily: 'Poppins',
          ),
        ),
      ),
      Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
        child: FFButtonWidget(
          onPressed: onPressed,
          text: 'Dapatkan penugasan baru',
          options: FFButtonOptions(
            width: 240,
            height: 48,
            color: FlutterFlowTheme.secondaryColor,
            textStyle: FlutterFlowTheme.subtitle2.override(
              fontFamily: 'Poppins',
              color: FlutterFlowTheme.primaryColor,
              fontSize: 12,
            ),
            borderSide: BorderSide(
              color: FlutterFlowTheme.primaryColor,
              width: 1,
            ),
            borderRadius: 12,
          ),
        ),
      ),
    ],
  );
}
