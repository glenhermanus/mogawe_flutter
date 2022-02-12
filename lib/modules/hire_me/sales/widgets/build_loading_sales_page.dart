import 'package:flutter/material.dart';
import 'package:mogawe/utils/ui/widgets/shimmering_skeleton.dart';

Widget buildSalesPageLoading(double widthSize) {
  return SingleChildScrollView(
    physics: const NeverScrollableScrollPhysics(),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Skeleton(
            width: 150,
            height: 50,
          ),
        ),
        SizedBox(height: 18,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Skeleton(
                width: widthSize,
                height: 250,
              ),
              Skeleton(
                width: widthSize,
                height: 250,
              ),
            ],
          ),
        ),
        SizedBox(height: 18,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Skeleton(
                width: widthSize,
                height: 250,
              ),
              Skeleton(
                width: widthSize,
                height: 250,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
