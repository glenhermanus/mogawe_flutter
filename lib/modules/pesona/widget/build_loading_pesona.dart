import 'package:flutter/material.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/utils/ui/widgets/shimmering_skeleton.dart';

Widget buildLoadingPesona() {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: FlutterFlowTheme.primaryColor,
      automaticallyImplyLeading: true,
      title: Text(
        'Pesona',
        style: FlutterFlowTheme.subtitle1.override(
          fontFamily: 'Poppins',
          color: FlutterFlowTheme.secondaryColor,
        ),
      ),

      centerTitle: false,
      elevation: 0,
    ),
    body: SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Skeleton(
              height: 130,
            ),
          ),
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Skeleton(
              height: 130,
            ),
          ),
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Skeleton(
              height: 130,
            ),
          ),
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Skeleton(
              height: 130,
            ),
          ),
        ],
      ),
    ),
  );
}