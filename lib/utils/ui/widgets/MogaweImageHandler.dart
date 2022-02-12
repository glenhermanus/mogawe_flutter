import 'package:flutter/material.dart';

Widget mogaweImageHandler(
    {required String? url,
    double? height,
    double? width,
    required bool isProfile,
      BoxFit? fit}) {
  final String emptyImageAsset = 'assets/images/noimagefound.png';
  final String emptyProfileAssets = 'assets/images/im_ambar_good_bgwhite.jpg';

  return (url != "" && url != null)
      ? Image.network(
          url ?? "",
          fit: fit,
          height: height,
          width: width,
        )
      : Image.asset(
          isProfile ? emptyProfileAssets : emptyImageAsset,
          fit: BoxFit.cover,
          height: height,
          width: width,
        );
}
