import 'package:flutter/material.dart';
import 'package:mogawe/utils/ui/widgets/shimmering_skeleton.dart';

Widget buildWithdrawalPageLoading() {
  return SingleChildScrollView(
    physics: const NeverScrollableScrollPhysics(),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Skeleton(
                width: 120,
                height: 20,
              ),
              SizedBox(width: 18,),
              Skeleton(
                width: 150,
                height: 20,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Skeleton(
                width: 100,
                height: 40,
              ),
              Skeleton(
                width: 100,
                height: 40,
              ),
              Skeleton(
                width: 100,
                height: 40,
              ),
            ],
          ),
        ),
        SizedBox(height: 12,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Skeleton(
                width: 100,
                height: 40,
              ),
              Skeleton(
                width: 100,
                height: 40,
              ),
              Skeleton(
                width: 100,
                height: 40,
              ),
            ],
          ),
        ),
        SizedBox(height: 28),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Skeleton(
            height: 120,
          ),
        ),
        SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Skeleton(
            height: 120,
          ),
        ),
        SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Skeleton(
            height: 120,
          ),
        ),
        SizedBox(height: 18),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Skeleton(
            height: 50,
          ),
        ),
        SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Skeleton(
            height: 280,
          ),
        ),
      ],
    ),
  );
}
