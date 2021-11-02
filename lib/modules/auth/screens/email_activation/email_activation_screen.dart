import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/modules/auth/screens/email_activation/email_activation_page.dart';
import 'package:mogawe/modules/auth/screens/email_activation_success/email_activation_success_page.dart';
import 'package:mogawe/modules/auth/screens/login/login_page.dart';
import 'package:mogawe/modules/auth/screens/registration/bloc/registration_bloc.dart';
import 'package:mogawe/modules/auth/screens/registration/bloc/registration_event.dart';
import 'package:mogawe/modules/auth/screens/registration/bloc/registration_state.dart';

class EmailActivationScreen extends StatefulWidget {

  final String? email;
  final bool? isActivateEmail;

  const EmailActivationScreen({Key? key, this.email, this.isActivateEmail}) : super(key: key);

  @override
  _EmailActivationScreenState createState() => _EmailActivationScreenState();
}

class _EmailActivationScreenState extends State<EmailActivationScreen> {

  late RegistrationBloc bloc;
  bool isLoading = false;
  bool isResendLoading = false;
  int? count = 30;

  @override
  void initState() {
    super.initState();
    bloc = RegistrationBloc();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  Widget blocListener(Widget child) {
    return BlocListener(
      bloc: bloc,
      listener: (ctx, state) => print("State : $state"),
      child: child,
    );
  }

  Widget blocBuilder() {
    return BlocBuilder(
      bloc: bloc,
      builder: (ctx, state) {
        if (state is InitRegistrationState) {
          countDown();
          return layout();
        }
        if (state is RegistrationStateChanged) {
          if (isResendLoading && count == 0) {
            var body = {"email": widget.email ?? ""};
            bloc.add(DoResendActivationEmailEvent(body));
          }
          return layout();
        }
        if (state is ShowLoadingRegistrationState) {
          isLoading = true;
          return layout();
        }
        if (state is SuccessActivateEmailState) {
          checkLoading();
          WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
            Navigator.push(context, MaterialPageRoute(builder: (_) =>
            EmailActivationSuccessPage()));
          });
          return layout();
        }
        if (state is SuccessActivateNewPasswordState) {
          checkLoading();
          WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) =>
            LoginPage()), (route) => false);
          });
          return layout();
        }
        if (state is SuccessResendActivationEmailState) {
          count = 30;
          countDown();
          return layout();
        }
        if (state is ShowErrorRegistrationState) {
          checkLoading();
          WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                state.message,
                style: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Poppins',
                    color: Colors.white
                ),
              ),
              backgroundColor: Colors.red,
            ));
          });
          return layout();
        }
        return Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //Layout here
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.secondaryColor,
        iconTheme: IconThemeData(color: FlutterFlowTheme.tertiaryColor),
        automaticallyImplyLeading: true,
        title: Text(
          'Aktivasi Email',
          style: FlutterFlowTheme.subtitle1.override(
            fontFamily: 'Poppins',
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: FlutterFlowTheme.secondaryColor,
      body: blocListener(blocBuilder()),
    );
  }

  Widget layout() => EmailActivationPage(
    email: widget.email,
    isLoading: isLoading,
    count: count,
    isResendLoading: isResendLoading,
    onResendCode: () {
      isResendLoading = true;
      bloc.add(ChangeRegistrationStateEvent());
    },
    onActivateCode: (v) {
      if (widget.isActivateEmail!) bloc.add(DoActivateMailEvent(v));
      else bloc.add(DoActivateNewPasswordEvent(v));
    },
  );

  void checkLoading() {
    if (isLoading) isLoading = false;
  }

  void countDown() {
    var sec = Duration(seconds: 1);
    Timer.periodic(sec, (timer) {
      if (count == 0) {
        timer.cancel();
        isResendLoading = false;
      } else {
        count = count!-1;
      }
      bloc.add(ChangeRegistrationStateEvent());
    });
  }
}
