import 'package:flutter/material.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';

class NewPasswordActivityPage extends StatefulWidget {
  const NewPasswordActivityPage({Key? key}) : super(key: key);

  @override
  _NewPasswordActivityPageState createState() =>
      _NewPasswordActivityPageState();
}

class _NewPasswordActivityPageState extends State<NewPasswordActivityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.secondaryColor,
        iconTheme: IconThemeData(color: FlutterFlowTheme.tertiaryColor),
        automaticallyImplyLeading: true,
        title: Text(
          'New Password Activation',
          style: FlutterFlowTheme.subtitle1.override(
            fontFamily: 'Poppins',
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: FlutterFlowTheme.secondaryColor,
      body: Center(
        child: Text(
          'New Password Activation page',
          style: FlutterFlowTheme.bodyText1.override(fontFamily: 'Poppins'),
        ),
      ),
    );
  }
}
