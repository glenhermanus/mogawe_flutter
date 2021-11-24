import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:mogawe/core/data/response/user_login_response.dart';
import 'package:mogawe/core/data/sources/network/user_network_service.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/modules/auth/repositories/auth_repository.dart';
import 'package:mogawe/modules/auth/screens/registration/registration_screen.dart';
import 'package:mogawe/modules/auth/screens/reset_password/reset_password_page.dart';
import 'package:mogawe/modules/home/home_page.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthRepository _authRepository = AuthRepository.instance;
  final _formKey = new GlobalKey<FormState>();
  var logger = Logger(printer: PrettyPrinter());

  String _email = "", _password = "";

  TextEditingController? _emailInputController;
  TextEditingController? _passwordInputController;
  bool? passwordVisibility;
  bool _loadingButton1 = false;
  bool _loadingButton2 = false;
  bool _loadingButton3 = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Map? fbcoba;
  UserLoginResponse? userLoginResponse;

  @override
  void initState() {
    super.initState();
    _emailInputController = TextEditingController();
    _passwordInputController = TextEditingController();
    passwordVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.secondaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Halo MoGawers!',
                  style: FlutterFlowTheme.title2.override(
                    fontFamily: 'Poppins',
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 48, 0, 0),
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
                        controller: _emailInputController,
                        obscureText: false,
                        validator: (value) => value == null || value.isEmpty
                            ? "Masukkan email mu"
                            : null,
                        onSaved: (value) => _email = value!,
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
                            Icons.person,
                            size: 18,
                          ),
                        ),
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Password',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                        ),
                      ),
                      TextFormField(
                        controller: _passwordInputController,
                        obscureText: !passwordVisibility!,
                        validator: (value) => value == null || value.isEmpty
                            ? "Masukkan passwordmu"
                            : null,
                        onSaved: (value) => _password = value!,
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
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(1, 0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          setState(() => _loadingButton1 = true);
                          try {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResetPasswordPage(),
                              ),
                            );
                          } finally {
                            setState(() => _loadingButton1 = false);
                          }
                        },
                        text: 'Lupa Password?',
                        options: FFButtonOptions(
                          width: 160,
                          height: 40,
                          color: FlutterFlowTheme.secondaryColor,
                          textStyle: FlutterFlowTheme.subtitle2.override(
                            fontFamily: 'Poppins',
                            color: FlutterFlowTheme.primaryColor,
                            fontSize: 14,
                          ),
                          elevation: 0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: 12,
                        ),
                        loading: _loadingButton1,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      _handleSubmitLogin(_email, _password);
                    },
                    text: 'Masuk',
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
                    loading: _loadingButton2,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                  child: Text(
                    'Atau',
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () async{
                          await loginfb();
                        },
                        child: Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: Color(0xFF1F3C95),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: FaIcon(
                              FontAwesomeIcons.facebookF,
                              color: FlutterFlowTheme.secondaryColor,
                              size: 32,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: ()async{
                          await loginGoogle();
                        },
                        child: Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.secondaryColor,
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                              color: FlutterFlowTheme.primaryColor,
                            ),
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: FaIcon(
                              FontAwesomeIcons.google,
                              color: FlutterFlowTheme.primaryColor,
                              size: 32,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: ()async{
                          await loginTwitter();
                        },
                        child: Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: Color(0xFF4DC0FA),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: FaIcon(
                              FontAwesomeIcons.twitter,
                              color: FlutterFlowTheme.secondaryColor,
                              size: 32,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 64, 0, 0),
                  child: Text(
                    'Belum punya akun MoGawe?',
                    style: FlutterFlowTheme.subtitle2.override(
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      setState(() => _loadingButton3 = true);
                      try {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegistrationScreen(),
                          ),
                        );
                      } finally {
                        setState(() => _loadingButton3 = false);
                      }
                    },
                    text: 'Daftar Baru',
                    options: FFButtonOptions(
                      width: 160,
                      height: 32,
                      color: FlutterFlowTheme.secondaryColor,
                      textStyle: FlutterFlowTheme.title3.override(
                        fontFamily: 'Poppins',
                        color: FlutterFlowTheme.primaryColor,
                        fontSize: 18,
                      ),
                      elevation: 0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: 12,
                    ),
                    loading: _loadingButton3,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleSubmitLogin(String email, String password) async {
    final FormState? form = _formKey.currentState;
    // if (form!.validate()) {
    //   form.save();
    //
    //
    // } else {}


    //! delete after done
    String email = "gellaps@gmail.com";
    String staticPassword =
        "ec7481d891314c11f10406d8bea73a2086a9e727a624f23de1694341016d055c";

    var response = await _authRepository.submitLogin(email, staticPassword);
    if (response.returnValue == "000") {
      logger.d("Success Login");
      setState(() => _loadingButton2 = true);
      try {

        await AuthRepository().writeSecureData("token", response.token);
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );


      } finally {
        setState(() => _loadingButton2 = false);
      }
    }
  }

  Future<void> loginfb() async{
    final result = await  FacebookAuth.instance.login(
        permissions: ["public_profile", "email"]
    );
    if(result.status == LoginStatus.success){
      final req = await FacebookAuth.instance.getUserData(fields: "email, id, name");

      fbcoba = req;
      var responses = await AuthRepository().LoginFacebook(fbcoba!['name'], fbcoba!['email'], fbcoba!['id']);
      if (responses.returnValue == "000") {
        logger.d("Success Login");
        userLoginResponse = responses;
        setState(() => _loadingButton2 = true);
        try {
          AuthRepository().writeSecureData('token', userLoginResponse!.token);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        } finally {
          setState(() => _loadingButton2 = false);
        }
      }
      print(responses.token);

      print(fbcoba!['email']);

    }
  }

  Future<void> gettoken(token)async{
    var responseses = await UserNetworkService().profileUser(token);

  }

  Future<void> loginTwitter() async{
    final twitterLogin = TwitterLogin(
        apiKey: 'bJdoHHY9aH8V2RoxLuffg0InR',
        apiSecretKey: 'u5HJcyYgD85d7UPYfrnRcZY4kgfbZBJg4I5ZWXW7NRR1xYyaF6',
        redirectURI: 'twittersdk://'
    );

    final authResult = await twitterLogin.login(forceLogin: true);
    logger.d(authResult.status);
    switch (authResult.status) {
      case TwitterLoginStatus.loggedIn:
      // success
        print('====== Login success ======');
        break;
      case TwitterLoginStatus.cancelledByUser:
      // cancel
        print('====== Login cancel ======');
        break;
      case TwitterLoginStatus.error:
      case null:
      // error
        print('====== Login error ======');
        break;
    }

  }

  Future<void> loginGoogle()async{
    var id;
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      final GoogleSignInAccount? googleSignInAccount =
      await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

}
