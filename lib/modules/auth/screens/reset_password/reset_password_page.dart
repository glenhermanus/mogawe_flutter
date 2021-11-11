import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mogawe/blocs/reset_password/bloc/resetpassword_bloc.dart';
import 'package:mogawe/core/data/request/reset_password_request.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_extension.dart';
import 'package:mogawe/modules/auth/screens/new_password_activation/new_password_activation_page.dart';

class ResetPasswordPage extends StatefulWidget {
  ResetPasswordPage({Key? key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _bloc = ResetpasswordBloc();
  ResetPasswordRequest data = ResetPasswordRequest();
  bool? passwordVisibility;

  @override
  void initState() {
    super.initState();
    passwordVisibility = false;
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  _onResetPass() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _bloc.add(ResetpasswordSubmitted(data));
    }
  }

  _showErrorDialog(String? desc) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('Error'),
          content: Text(desc ?? ''),
          actions: [
            CupertinoDialogAction(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
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
          'Reset Password',
          style: FlutterFlowTheme.subtitle1.override(
            fontFamily: 'Poppins',
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: FlutterFlowTheme.secondaryColor,
      body: SafeArea(
        child: BlocListener<ResetpasswordBloc, ResetpasswordState>(
          bloc: _bloc,
          listener: (context, state) {
            if (state is ResetpasswordLoaded) {
              if (state.response.returnValue == '001') {
                _showErrorDialog(state.response.message);
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NewPasswordActivationPage(email: data.email),
                  ),
                );
              }
            }
          },
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Form(
                    key: _formKey,
                    child: _formResetPassword(),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 48, 0, 0),
                    child: BlocBuilder<ResetpasswordBloc, ResetpasswordState>(
                      bloc: _bloc,
                      builder: (context, state) {
                        return FFButtonWidget(
                          onPressed: _onResetPass,
                          text: 'Reset Password',
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 48,
                            color: FlutterFlowTheme.primaryColor,
                            textStyle: FlutterFlowTheme.subtitle2.override(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                            ),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: 12,
                          ),
                          loading: state is ResetpasswordLoading,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                    child: Text(
                      'Kode aktivasi untuk password baru akan kami kirim melalui email yang sudah terdaftar',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _formResetPassword() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Email',
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                ),
              ),
              TextFormField(
                validator: (val) {
                  if ((val?.isEmpty ?? false)) {
                    return 'Mohon masukkan email anda';
                  }
                  if (!(val?.isValidEmail() ?? false)) {
                    return 'Mohon masukkan format email dengan benar';
                  }
                  return null;
                },
                onSaved: (val) {
                  data.email = val;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'john.doe@email.com',
                  hintStyle: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Poppins',
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                  filled: true,
                  fillColor: FlutterFlowTheme.fieldColor,
                  prefixIcon: Icon(
                    Icons.email,
                    size: 18,
                  ),
                ),
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Password baru',
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                ),
              ),
              TextFormField(
                validator: (val) {
                  if (val?.isEmpty ?? false) {
                    return 'Mohon masukkan password baru anda';
                  }
                  return null;
                },
                onSaved: (val) {
                  data.newPassword = val;
                },
                keyboardType: TextInputType.visiblePassword,
                obscureText: !passwordVisibility!,
                decoration: InputDecoration(
                  hintText: '******',
                  hintStyle: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Poppins',
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                  filled: true,
                  fillColor: FlutterFlowTheme.fieldColor,
                  prefixIcon: Icon(
                    Icons.lock,
                    size: 18,
                  ),
                  suffixIcon: InkWell(
                    onTap: () => setState(
                      () => passwordVisibility = !passwordVisibility!,
                    ),
                    child: Icon(
                      passwordVisibility!
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Color(0xFF757575),
                      size: 18,
                    ),
                  ),
                ),
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
