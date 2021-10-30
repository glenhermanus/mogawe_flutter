import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/utils/ui/widgets/app_util.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RegistrationPage extends StatefulWidget {

  final bool? loadingButton;
  final Function(Map<String, String>? body)? onTapRegister;

  RegistrationPage({Key? key, this.loadingButton, this.onTapRegister}) :
        super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController? textController1;
  TextEditingController? textController2;
  TextEditingController? textController3;
  bool? passwordVisibility;
  late TextEditingController textController4;
  bool? checkboxListTileValue = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    textController3 = TextEditingController();
    passwordVisibility = false;
    textController4 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 24),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nama',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                        ),
                      ),
                      TextFormField(
                        controller: textController1,
                        obscureText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Nama wajib diisi";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'John Doe',
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
                        controller: textController2,
                        obscureText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email wajib diisi";
                          } else if (!AppUtil.isEmailValidated(value)) {
                            return "Format email salah";
                          } return null;
                        },
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
                      )
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
                        'Password',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                        ),
                      ),
                      TextFormField(
                        controller: textController3,
                        obscureText: !passwordVisibility!,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return "Password wajib diisi";
                          }
                          return null;
                        },
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
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 48, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Punya Kode Referensi? (Opsional)',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                        ),
                      ),
                      TextFormField(
                        controller: textController4,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Reference Code',
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
                        ),
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Text(
                        'Tidak wajib diisi',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 48, 0, 0),
                  child: CheckboxListTile(
                    value: checkboxListTileValue ??= true,
                    onChanged: (newValue) {
                      if (!checkboxListTileValue!) showToCWebView();
                      setState(() => checkboxListTileValue = newValue);
                    },
                    title: Text(
                      'Saya sudah membaca dan setuju dengan \"Perjanjian kerja sama  kemitraan MoGawe\"',
                      style: FlutterFlowTheme.subtitle2.override(
                        fontFamily: 'Poppins',
                        fontSize: 11,
                      ),
                    ),
                    tileColor: FlutterFlowTheme.secondaryColor,
                    activeColor: FlutterFlowTheme.primaryColor,
                    dense: false,
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
                FFButtonWidget(
                  onPressed: () {
                    if (_formKey.currentState!.validate() && checkboxListTileValue!) {
                      var body = {
                        "email": textController2!.text,
                        "fullName": textController1!.text,
                        "password": AppUtil.hashedPassword(textController3!.text),
                        "refCode": textController4.text
                      };
                      widget.onTapRegister!(body);
                    } else if (!checkboxListTileValue!) {
                      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "Anda belum menyetujui \"Perjanjian kerja sama "
                                " kemitraan Mogawe\"",
                            style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                color: Colors.white
                            ),
                          ),
                          backgroundColor: Colors.red,
                        ));
                      });
                    }
                  },
                  text: 'Daftar',
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
                  loading: widget.loadingButton,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showToCWebView() {
    showModalBottomSheet(context: context, builder: (_) =>
    Container(
      padding: EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height / 1.05,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(height: 3, width: 150, color: Color(0xff999999)),
          SizedBox(height: 16),
          Expanded(child: WebView(
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: "https://mogawe.id/partnership.html",
            gestureRecognizers: Set()
              ..add(
                Factory<VerticalDragGestureRecognizer>(
                      () => VerticalDragGestureRecognizer(),
                ), // or null
              ),
          ))
        ],
      ),
    ), isScrollControlled: true, shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(28),
        topRight: Radius.circular(28))
    ));
  }
}
