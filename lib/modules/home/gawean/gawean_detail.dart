import 'package:flutter/material.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';

class GaweanDetailScreen extends StatefulWidget {
  const GaweanDetailScreen({Key? key}) : super(key: key);

  @override
  _GaweanDetailScreenState createState() => _GaweanDetailScreenState();
}

class _GaweanDetailScreenState extends State<GaweanDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.secondaryColor,
        iconTheme: IconThemeData(color: FlutterFlowTheme.tertiaryColor),
        automaticallyImplyLeading: true,
        title: Text(
          'Informasi Gawean',
          style: FlutterFlowTheme.subtitle1.override(
            fontFamily: 'Poppins',
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right : 8.0),
            child: Icon(
              Icons.share,
              color: FlutterFlowTheme.primaryColor,
            ),
          ),
        ],
        centerTitle: false,
        elevation: 0,
      ),
    );
  }
}
