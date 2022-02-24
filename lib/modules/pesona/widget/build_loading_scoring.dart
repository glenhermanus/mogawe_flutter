import 'package:flutter/material.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/utils/ui/widgets/shimmering_skeleton.dart';

Widget buildLoadingScoring() {
  return Scaffold(
    appBar: AppBar(
      iconTheme: IconThemeData(color: FlutterFlowTheme.blackColor),
      backgroundColor: FlutterFlowTheme.secondaryColor,
      automaticallyImplyLeading: true,
      title: Text(
        'PesonaKu',
        style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Poppins',
            fontSize: 20,
            color: FlutterFlowTheme.blackColor
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Row(
            children: [
              Icon(Icons.add, color: Colors.red, size: 18,),
              SizedBox(width: 4,),
              Text('Pesona', style: FlutterFlowTheme.title3.copyWith(color: Colors.red, fontSize: 14),)
            ],
          ),
        )
      ],
      centerTitle: false,
      elevation: 4,
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