import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';

class MogaweNominalText extends StatelessWidget {
  final int nominal;
  final bool isNeedSymbol;
  final Color? color;

  const MogaweNominalText(
      {Key? key,
      required this.nominal,
      required this.isNeedSymbol, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('#,###,###');
    var formattedNominal = formatter.format(nominal);
    return isNeedSymbol ?
    Text(
        nominal == 0
            ? "Rp $nominal"
            : nominal > 0 ?
        "+Rp $formattedNominal" : "-Rp $formattedNominal",
        style: FlutterFlowTheme.subtitle1.override(
          fontFamily: 'Poppins',
          color: nominal == 0
              ? FlutterFlowTheme.tertiaryColor
              : nominal > 0 ? FlutterFlowTheme.moGaweGreen : FlutterFlowTheme.primaryColor,
        ),)
    : Text(
      "Rp " + formattedNominal,
      style: FlutterFlowTheme.subtitle1
          .override(fontFamily: 'Poppins', color: color ?? Colors.black),
    );
  }
}
