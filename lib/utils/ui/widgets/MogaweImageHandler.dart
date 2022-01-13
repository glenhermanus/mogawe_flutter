import 'package:flutter/material.dart';

Widget mogaweImageHandler(
    {required String? url,
    double? height,
    double? width,
    required BoxFit fit}) {
  final String emptyImageAsset = 'assets/images/noimagefound.png';

  return (url != "" || url != null)
      ? Image.network(
          url ?? "",
          fit: fit,
          height: height,
          width: width,
        )
      : Image.asset(
          emptyImageAsset,
          fit: fit,
          height: height,
          width: width,
        );
}
