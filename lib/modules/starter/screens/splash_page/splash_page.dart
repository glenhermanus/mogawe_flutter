import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mogawe/constant/app_const_value.dart';
import 'package:mogawe/core/data/response/user_response.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/modules/auth/repositories/auth_repository.dart';
import 'package:mogawe/modules/starter/screens/onboarding/onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var logger = Logger(printer: PrettyPrinter());

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final AuthRepository _authRepository = AuthRepository.instance;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder(
          future: _authRepository.getVersionNumber(150),
          builder: (context, snapshot) {
            var state = snapshot.connectionState;
            switch (state) {
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              case ConnectionState.done:
                return _buildSplashScreenBody(snapshot);
              default:
                return Text('');
            }
          },
        ),
      ),
    );
  }

  Widget _buildSplashScreenBody(AsyncSnapshot<Object?> snapshot) {
    if (snapshot.hasError) {
      return Center(
        child: Text("Terjadi kesalahan"),
      );
    } else if (snapshot.hasData) {
      var data = snapshot.data as UserResponse;
      Timer(Duration(seconds: 3), () {
        switch (data.message) {
          case DEPRECATED_VERSION:
            logger.d("Is deprecated");
            _buildDialogForUpdateToNewestVersion();
            break;
          case OLD_VERSION:
            logger.d("Is old version");
            _saveIsUpdatedVersion(isNewestVersion: false);
            _navigateToOnboarding();
            break;
          case LATEST_VERSION:
            logger.d("Is latest version");
            _saveIsUpdatedVersion(isNewestVersion: true);
            _navigateToOnboarding();
            break;
        }
      });
      return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: _buildNewestVersionChecked());
    } else {
      return Text('');
    }
  }

  Widget _buildNewestVersionChecked() {
    return Align(
      alignment: AlignmentDirectional(0, -0.05),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo-light-horizontal.png',
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.2,
                  fit: BoxFit.contain,
                )
              ],
            ),
          ),
          Text(
            'Version 6.0',
            style: FlutterFlowTheme.bodyText1.override(
              fontFamily: 'Poppins',
              color: FlutterFlowTheme.primaryColor,
            ),
          )
        ],
      ),
    );
  }

  void _navigateToOnboarding() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => OnboardingPage(),
      ),
    );
  }

  Future<void> _buildDialogForUpdateToNewestVersion() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('MoGawe Update'),
          content: const Text('Harap update ke versi terbaru'),
          actions: [TextButton(onPressed: () {}, child: const Text('OK'))],
        );
      },
    );
  }

  Future<void> _saveIsUpdatedVersion({required bool isNewestVersion}) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool(UPDATE_AVAILABLE, isNewestVersion);
  }
}
