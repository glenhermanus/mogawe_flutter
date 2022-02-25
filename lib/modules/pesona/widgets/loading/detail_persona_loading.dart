import 'package:flutter/material.dart';
import 'package:mogawe/utils/ui/widgets/shimmering_skeleton.dart';

Widget buildDetailPersonaLoading() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SkeletonNoRadius(
        height: 250,
      ),
      SizedBox(height: 32),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Skeleton(
          width: 150,
          height: 22,
        ),
      ),
      SizedBox(height: 16),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Skeleton(
          height: 18,
        ),
      ),
      SizedBox(height: 8),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Skeleton(
          height: 18,
        ),
      ),
      SizedBox(height: 8),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Skeleton(
          height: 18,
        ),
      ),
      SizedBox(height: 8),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Skeleton(
          height: 18,
        ),
      ),
      SizedBox(height: 64),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Skeleton(
          height: 55,
        ),
      ),
    ],
  );
}
