import 'package:flutter/material.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/utils/ui/widgets/shimmering_skeleton.dart';

Widget buildHomeShimmerLoading() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Stack(
        children: [
          Align(
            alignment: AlignmentDirectional(0, -1),
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.primaryColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              child: Row(
                children: [
                  Skeleton(
                    width: 330,
                    height: 175,
                  ),
                  SizedBox(width: 12),
                  Skeleton(
                    width: 330,
                    height: 175,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 85),
      Padding(
        padding: const EdgeInsets.only(left: 18.0),
        child: Skeleton(
          width: 150,
          height: 24,
        ),
      ),
      SizedBox(height: 12),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Skeleton(
          height: 175,
        ),
      ),
      SizedBox(height: 36),
      Padding(
        padding: const EdgeInsets.only(left: 18.0),
        child: Skeleton(
          width: 150,
          height: 24,
        ),
      ),
      SizedBox(height: 8),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Skeleton(
          height: 50,
        ),
      ),
    ],
  );
}