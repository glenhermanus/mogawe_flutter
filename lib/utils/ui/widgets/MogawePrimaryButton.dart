import 'dart:async';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/utils/ui/animation/bounce_tap.dart';

class MogawePrimaryButton extends StatefulWidget {
  final VoidCallback onTap;
  final String buttonText;

  const MogawePrimaryButton(
      {Key? key, required this.onTap, required this.buttonText})
      : super(key: key);

  @override
  _MogawePrimaryButtonState createState() => _MogawePrimaryButtonState();
}

class _MogawePrimaryButtonState extends State<MogawePrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return BounceTap(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: FlutterFlowTheme.primaryColor,
        ),
        width: double.infinity,
        height: 56,
        child: Center(
          child: AutoSizeText(
            widget.buttonText,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ),
    );
  }
}