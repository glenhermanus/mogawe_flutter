
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';

class EmailActivationPage extends StatefulWidget {

  final String? email;
  final bool? isLoading;
  final bool? isResendLoading;
  final int? count;
  final Function(Map<String, String> code)? onActivateCode;
  final Function()? onResendCode;

  EmailActivationPage({Key? key, this.email, this.isLoading,
    this.count, this.onActivateCode, this.isResendLoading, this.onResendCode})
      : super(key: key);

  @override
  _EmailActivationPageState createState() => _EmailActivationPageState();
}

class _EmailActivationPageState extends State<EmailActivationPage> {
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  TextEditingController textController3 = TextEditingController();
  TextEditingController textController4 = TextEditingController();
  TextEditingController textController5 = TextEditingController();
  TextEditingController textController6 = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      'Kode aktivasi sudah kami kirim ke email kamu '
                          '\n${widget.email!.substring(0,4)}*******'
                          '${widget.email!.substring(
                          widget.email!.length-4,widget.email!.length
                      )}',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 4, 0),
                              child: TextFormField(
                                controller: textController1,
                                obscureText: false,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                  ],
                                onChanged: (v) {
                                  if (v.isEmpty)
                                    FocusScope.of(context).unfocus();
                                  else FocusScope.of(context).nextFocus();
                                },
                                decoration: InputDecoration(
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
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
                              child: TextFormField(
                                controller: textController2,
                                obscureText: false,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                ],
                                onChanged: (v) {
                                  if (v.isEmpty)
                                    FocusScope.of(context).previousFocus();
                                  else FocusScope.of(context).nextFocus();
                                },
                                decoration: InputDecoration(
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
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
                              child: TextFormField(
                                controller: textController3,
                                obscureText: false,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                ],
                                onChanged: (v) {
                                  if (v.isEmpty)
                                    FocusScope.of(context).previousFocus();
                                  else FocusScope.of(context).nextFocus();
                                },
                                decoration: InputDecoration(
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
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
                              child: TextFormField(
                                controller: textController4,
                                obscureText: false,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                ],
                                onChanged: (v) {
                                  if (v.isEmpty)
                                    FocusScope.of(context).previousFocus();
                                  else FocusScope.of(context).nextFocus();
                                },
                                decoration: InputDecoration(
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
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
                              child: TextFormField(
                                controller: textController5,
                                obscureText: false,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                ],
                                onChanged: (v) {
                                  if (v.isEmpty)
                                    FocusScope.of(context).previousFocus();
                                  else FocusScope.of(context).nextFocus();
                                },
                                decoration: InputDecoration(
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
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                              child: TextFormField(
                                controller: textController6,
                                obscureText: false,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                ],
                                onChanged: (v) {
                                  if (v.isEmpty)
                                    FocusScope.of(context).previousFocus();
                                  else FocusScope.of(context).nextFocus();
                                },
                                decoration: InputDecoration(
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
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
                child: FFButtonWidget(
                  onPressed: () {
                    if (!isActivationNull()) {
                      var body = {
                        "email": widget.email ?? "",
                        "activationCode": "${textController1.text}"
                            "${textController2.text}"
                            "${textController3.text}"
                            "${textController4.text}"
                            "${textController5.text}"
                            "${textController6.text}"
                      };
                      widget.onActivateCode!(body);
                    }
                  },
                  text: 'Aktivasi',
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
                  loading: widget.isLoading,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 48, 0, 0),
                child: AutoSizeText(
                  'Belum dapat email?',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              Visibility(
                visible: widget.count != 0,
                child: Padding(padding: EdgeInsets.only(top: 16),
                    child: AutoSizeText(
                      'Tunggu ${widget.count} detik lagi',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                      ),
                    )),
              ),
              Visibility(
                visible: widget.count == 0,
                child: FFButtonWidget(
                  onPressed: () => widget.onResendCode!(),
                  text: 'Kirim Ulang',
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 48,
                    color: FlutterFlowTheme.secondaryColor,
                    textStyle: FlutterFlowTheme.subtitle2.override(
                      fontFamily: 'Poppins',
                      color: FlutterFlowTheme.primaryColor,
                    ),
                    elevation: 0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: 12,
                  ),
                  loading: widget.isResendLoading,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool isActivationNull() {
    var a = textController1.text;
    var b = textController2.text;
    var c = textController3.text;
    var d = textController4.text;
    var e = textController5.text;
    var f = textController6.text;
    if (a.isNotEmpty && b.isNotEmpty && c.isNotEmpty && d.isNotEmpty
    && e.isNotEmpty && f.isNotEmpty) {
      return false;
    }
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Masukkan kode aktivasi",
          style: FlutterFlowTheme.bodyText1.override(
              fontFamily: 'Poppins',
              color: Colors.white
          ),
        ),
        backgroundColor: Colors.red,
      ));
    });
    return true;
  }
}
