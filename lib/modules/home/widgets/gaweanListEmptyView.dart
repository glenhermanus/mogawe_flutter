import 'package:flutter/material.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/modules/hire_me/hire_me_page.dart';
import 'package:mogawe/modules/pesona/pesona_page.dart';

Widget gaweanListEmptyView({required BuildContext context}) {
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
          'Wah, kamu belum punya gawean\nyang bisa dikerjain lagi.',
          textAlign: TextAlign.center,
          style: FlutterFlowTheme.subtitle2.override(
            fontFamily: 'Poppins',
          ),
        ),
      ),
      Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
        child: FFButtonWidget(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HireMePage(),
              ),
            );
          },
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
      Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
        child: FFButtonWidget(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PesonaPage(),
              ),
            );
          },
          text: 'Tambahkan pesonamu',
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
