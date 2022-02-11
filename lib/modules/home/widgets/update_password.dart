import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/core/repositories/profile_repository.dart';
import 'package:mogawe/utils/services/password_hasher.dart';
import 'package:mogawe/utils/ui/widgets/shimmering_skeleton.dart';

class UpdatePassword extends StatefulWidget {
  final String email;
  UpdatePassword({required this.email});

  @override
  _UpdatePasswordState createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  String _passwordNew = "", _password = "",  _passwordConfirm = "";
  var logger = Logger(printer: PrettyPrinter());
  TextEditingController _passwordInputController = new TextEditingController();
  TextEditingController _passwordInputControllerNew = new TextEditingController();
  TextEditingController _passwordInputControllerConfirm = new TextEditingController();
  bool passwordVisibility = true;
  bool _loadingButton2= false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.secondaryColor,
        iconTheme: IconThemeData(color: FlutterFlowTheme.tertiaryColor),
        automaticallyImplyLeading: true,
        title: Text(
          'MoGawe',
          style: FlutterFlowTheme.subtitle1.override(
            fontFamily: 'Poppins',
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFF5F5F5),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(34),
            child: Column(
              children: [
                TextFormField(
                  controller: _passwordInputController,
                  obscureText: passwordVisibility,
                  validator: (value) => value == null || value.isEmpty
                      ? "Masukkan passwordmu"
                      : null,
                  onSaved: (value) => _password = value!,
                  decoration: InputDecoration(
                    labelText: 'Password Lama',
                    floatingLabelStyle: FlutterFlowTheme.subtitle1.override(
                        fontFamily: 'Poppins',
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.w400
                    ),
                    labelStyle: FlutterFlowTheme.subtitle1.override(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w400
                    ),
                    hintStyle: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff000000),
                        width: 0.5,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff000000),
                        width: 0.5,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                    suffixIcon: IconButton(
                        icon: Icon(
                          passwordVisibility? Icons.visibility_off : Icons.visibility,),
                        onPressed: () {
                          setState(() {
                            passwordVisibility = !passwordVisibility;
                          });
                        }),
                  ),
                  style: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: _passwordInputControllerNew,
                  obscureText: passwordVisibility,
                  validator: (value) => value == null || value.isEmpty
                      ? "Masukkan password barumu"
                      : null,
                  onSaved: (value) => _passwordNew = value!,
                  decoration: InputDecoration(
                    labelText: 'Password Baru',
                    floatingLabelStyle: FlutterFlowTheme.subtitle1.override(
                        fontFamily: 'Poppins',
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.w400
                    ),
                    labelStyle: FlutterFlowTheme.subtitle1.override(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w400
                    ),
                    hintStyle: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff000000),
                        width: 0.5,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff000000),
                        width: 0.5,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                    suffixIcon: IconButton(
                        icon: Icon(
                          passwordVisibility? Icons.visibility_off : Icons.visibility,),
                        onPressed: () {
                          setState(() {
                            passwordVisibility = !passwordVisibility;
                          });
                        }),
                  ),
                  style: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: _passwordInputControllerConfirm,
                  obscureText: passwordVisibility,
                  validator: (value) => value == null || value.isEmpty
                      ? "Masukkan password barumu"
                      : null,
                  onSaved: (value) => _passwordConfirm = value!,
                  decoration: InputDecoration(
                    labelText: 'Konfirmasi Password Baru',
                    floatingLabelStyle: FlutterFlowTheme.subtitle1.override(
                        fontFamily: 'Poppins',
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.w400
                    ),
                    labelStyle: FlutterFlowTheme.subtitle1.override(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w400
                    ),
                    hintStyle: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff000000),
                        width: 0.5,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff000000),
                        width: 0.5,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                    suffixIcon: IconButton(
                        icon: Icon(
                          passwordVisibility? Icons.visibility_off : Icons.visibility,),
                        onPressed: () {
                          setState(() {
                            passwordVisibility = !passwordVisibility;
                          });
                        }),
                  ),
                  style: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      setState(() => _loadingButton2 = true);
                      try {
                        _handleUpdate(widget.email, _password, _passwordNew, _passwordConfirm, context);
                      } finally {
                        setState(() => _loadingButton2 = false);
                      }
                    },
                    text: 'Ganti Password',
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
              ],
            ),
          )
        ],
      ),
    );
  }

  void alertSukses() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Password Update"),
        content: const Text("Password Anda telah diubah"),
        actions: [

          TextButton(
            onPressed: () {

             Navigator.pop(context);
             Navigator.pop(context);
             Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],

      ),
    );
  }

  loadingAlert(title, status, loading) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => StatefulBuilder(
            builder: (BuildContext context, StateSetter stateSetter) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                contentPadding: EdgeInsets.only(top: 0.0, bottom: 20),
                content: Container(
                  width: MediaQuery.of(context).size.width * 0.5,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[

                      Divider(
                        color: Colors.grey,
                        height: 1.0,
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(19.0),
                          ),
                        ),
                        child: Column(
                          children: [
                            status != null ? status == true ? Icon(Icons.check, size: 30,) : Icon(Icons.clear, size: 30,) : Container(),
                            SizedBox(height: 15,),
                            Text('$title', style: FlutterFlowTheme.bodyText2,),
                            SizedBox(height: 15,),
                            loading == true ? CircularProgressIndicator(color: Colors.red,) : Container(),
                            SizedBox(height: 10,),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }

  Future<void> _handleUpdate(String email, String password, String passwordNew, String passwordConfirm, BuildContext ctx) async {

    String? password = _passwordInputController.value.text;
    String? passwordnew = _passwordInputControllerNew.value.text;
    String? passwordConfirm = _passwordInputControllerConfirm.value.text;
    var token = await AuthRepository().readSecureData('token');

    if(passwordConfirm == passwordnew){
      String hashedPassword = PasswordHasher().convertToSha256(passwordConfirm ?? "");
      String hashedPasswordold = PasswordHasher().convertToSha256(password ?? "");
      var response = await ProfileRepository().UpdatePasswordReq(email ?? "", hashedPasswordold, hashedPassword, token);
      loadingAlert('Mohon tunggu sebentar', null, true);
      logger.d(hashedPassword);
      logger.d(hashedPasswordold);
      logger.d(token);

      if (response.returnValue == "000") {
        logger.d("Success Login");
        setState(() => _loadingButton2 = true);
        try {
          _loadingButton2 = true;

          alertSukses();
          // String tokenn = "eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJNTy04Rk1HOFAiLCJpYXQiOjE2NDA2ODczODEsInN1YiI6Im1vZ2F3ZXJzIiwiaXNzIjoibW9nYXdlIn0._WeLYchQDHyWX5PM7kgIgwdcaYT8DV33B4v-2Dv4Yn0";
          print('berhasil');
        } catch (ex){}
        finally {
          setState(() => _loadingButton2 = false);
        }
      } else {
        logger.d("Gagal Login");
        Navigator.pop(context);
        final snackBar = new SnackBar(content: new Text(response.message),
            backgroundColor: Colors.red);
        ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
      }
    }
    else{
      final snackBar = new SnackBar(content: new Text('Password baru Anda tidak sama'),
          backgroundColor: Colors.red);
      ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
    }


  }

}
