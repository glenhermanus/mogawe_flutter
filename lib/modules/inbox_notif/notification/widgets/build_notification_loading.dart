import 'package:flutter/material.dart';
import 'package:mogawe/utils/ui/widgets/shimmering_skeleton.dart';

Widget buildNotificationLoading() {
  return SingleChildScrollView(
    physics: const NeverScrollableScrollPhysics(),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Skeleton(
            height: 55,
          ),
        ),
        SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Skeleton(
            height: 55,
          ),
        ),        SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Skeleton(
            height: 55,
          ),
        ),        SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Skeleton(
            height: 55,
          ),
        ),        SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Skeleton(
            height: 55,
          ),
        ),        SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Skeleton(
            height: 55,
          ),
        ),
      ],
    ),
  );
}