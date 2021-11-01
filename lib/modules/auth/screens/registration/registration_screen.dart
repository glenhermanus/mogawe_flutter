import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/modules/auth/screens/email_activation/email_activation_screen.dart';
import 'package:mogawe/modules/auth/screens/registration/bloc/registration_bloc.dart';
import 'package:mogawe/modules/auth/screens/registration/bloc/registration_event.dart';
import 'package:mogawe/modules/auth/screens/registration/bloc/registration_state.dart';
import 'package:mogawe/modules/auth/screens/registration/registration_page.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  late RegistrationBloc bloc;
  bool isLoading = false;

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
        if (state is InitRegistrationState) return layout();
        if (state is ShowLoadingRegistrationState) {
          isLoading = true;
          return layout();
        }
        if (state is SuccessRegisterState) {
          checkLoading();
          WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
            Navigator.push(context, MaterialPageRoute(builder: (_) =>
            EmailActivationScreen(email: state.email, isActivateEmail: true)));
          });
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.secondaryColor,
        iconTheme: IconThemeData(color: FlutterFlowTheme.tertiaryColor),
        automaticallyImplyLeading: true,
        title: Text(
          'Pendaftaran',
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

  Widget layout() => RegistrationPage(
    loadingButton: isLoading,
    onTapRegister: (body) => bloc.add(DoRegisterEvent(body!)),
  );

  void checkLoading() {
    if (isLoading) isLoading = false;
  }
}
