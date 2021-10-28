import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class HireMeInstantPage extends StatefulWidget {
  HireMeInstantPage({Key? key}) : super(key: key);

  @override
  _HireMeInstantPageState createState() =>
      _HireMeInstantPageState();
}

class _HireMeInstantPageState extends State<HireMeInstantPage> {
  bool _loadingButton1 = false;
  bool _loadingButton2 = false;
  bool _loadingButton3 = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.secondaryColor,
        iconTheme: IconThemeData(color: FlutterFlowTheme.tertiaryColor),
        automaticallyImplyLeading: true,
        title: Text(
          'Gawean Instan',
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional(0, 1),
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: Color(0xFFF5F5F5),
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16, 16, 16, 32),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Kurir Pengiriman MolaBox',
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: Color(0xFF323232),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Icon(
                                        Icons.info_rounded,
                                        color: Colors.black,
                                        size: 24,
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 8, 0, 0),
                                    child: Text(
                                      'Mengantarkan barang ke tujuan yang ditentukan',
                                      style:
                                          FlutterFlowTheme.bodyText2.override(
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF919191),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 16, 0, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 16, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme
                                                      .moGaweGreen,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 2,
                                                      color: Color(0x8F515151),
                                                      offset: Offset(0, 2),
                                                      spreadRadius: 0,
                                                    )
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Icon(
                                                  Icons.calculate,
                                                  color: FlutterFlowTheme
                                                      .secondaryColor,
                                                  size: 24,
                                                ),
                                              ),
                                              Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme
                                                      .moGaweGreen,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 2,
                                                      color: Color(0x8F515151),
                                                      offset: Offset(0, 2),
                                                      spreadRadius: 0,
                                                    )
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, 0),
                                                  child: FaIcon(
                                                    FontAwesomeIcons.instagram,
                                                    color: FlutterFlowTheme
                                                        .secondaryColor,
                                                    size: 24,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme
                                                      .moGaweGreen,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 2,
                                                      color: Color(0x8F515151),
                                                      offset: Offset(0, 2),
                                                      spreadRadius: 0,
                                                    )
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Icon(
                                                  Icons.delivery_dining,
                                                  color: FlutterFlowTheme
                                                      .secondaryColor,
                                                  size: 24,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              'Rp50.000',
                                              style: FlutterFlowTheme.bodyText1
                                                  .override(
                                                fontFamily: 'Poppins',
                                                color: FlutterFlowTheme
                                                    .primaryColor,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              '/task',
                                              style: FlutterFlowTheme.bodyText1
                                                  .override(
                                                fontFamily: 'Poppins',
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(48, 32, 48, 0),
                          child: FFButtonWidget(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            text: 'Sign Me Up!',
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
                            loading: _loadingButton1,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                      child: Stack(
                        alignment: AlignmentDirectional(0, 1),
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: Color(0xFFF5F5F5),
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 16, 16, 32),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Kurir Pengiriman MolaBox',
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF323232),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Icon(
                                          Icons.info_rounded,
                                          color: Colors.black,
                                          size: 24,
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 8, 0, 0),
                                      child: Text(
                                        'Mengantarkan barang ke tujuan yang ditentukan',
                                        style:
                                            FlutterFlowTheme.bodyText2.override(
                                          fontFamily: 'Poppins',
                                          color: Color(0xFF919191),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 16, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 16, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme
                                                        .moGaweGreen,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 2,
                                                        color:
                                                            Color(0x8F515151),
                                                        offset: Offset(0, 2),
                                                        spreadRadius: 0,
                                                      )
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Icon(
                                                    Icons.calculate,
                                                    color: FlutterFlowTheme
                                                        .secondaryColor,
                                                    size: 24,
                                                  ),
                                                ),
                                                Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme
                                                        .moGaweGreen,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 2,
                                                        color:
                                                            Color(0x8F515151),
                                                        offset: Offset(0, 2),
                                                        spreadRadius: 0,
                                                      )
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0, 0),
                                                    child: FaIcon(
                                                      FontAwesomeIcons
                                                          .instagram,
                                                      color: FlutterFlowTheme
                                                          .secondaryColor,
                                                      size: 24,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme
                                                        .moGaweGreen,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 2,
                                                        color:
                                                            Color(0x8F515151),
                                                        offset: Offset(0, 2),
                                                        spreadRadius: 0,
                                                      )
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Icon(
                                                    Icons.delivery_dining,
                                                    color: FlutterFlowTheme
                                                        .secondaryColor,
                                                    size: 24,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                'Rp50.000',
                                                style: FlutterFlowTheme
                                                    .bodyText1
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  color: FlutterFlowTheme
                                                      .primaryColor,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                '/task',
                                                style: FlutterFlowTheme
                                                    .bodyText1
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(48, 32, 48, 0),
                            child: FFButtonWidget(
                              onPressed: () {
                                print('Button pressed ...');
                              },
                              text: 'Sign Me Up!',
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
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                      child: Stack(
                        alignment: AlignmentDirectional(0, 1),
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: Color(0xFFF5F5F5),
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 16, 16, 32),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Kurir Pengiriman MolaBox',
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF323232),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Icon(
                                          Icons.info_rounded,
                                          color: Colors.black,
                                          size: 24,
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 8, 0, 0),
                                      child: Text(
                                        'Mengantarkan barang ke tujuan yang ditentukan',
                                        style:
                                            FlutterFlowTheme.bodyText2.override(
                                          fontFamily: 'Poppins',
                                          color: Color(0xFF919191),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 16, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 16, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme
                                                        .moGaweGreen,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 2,
                                                        color:
                                                            Color(0x8F515151),
                                                        offset: Offset(0, 2),
                                                        spreadRadius: 0,
                                                      )
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Icon(
                                                    Icons.calculate,
                                                    color: FlutterFlowTheme
                                                        .secondaryColor,
                                                    size: 24,
                                                  ),
                                                ),
                                                Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme
                                                        .moGaweGreen,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 2,
                                                        color:
                                                            Color(0x8F515151),
                                                        offset: Offset(0, 2),
                                                        spreadRadius: 0,
                                                      )
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0, 0),
                                                    child: FaIcon(
                                                      FontAwesomeIcons
                                                          .instagram,
                                                      color: FlutterFlowTheme
                                                          .secondaryColor,
                                                      size: 24,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme
                                                        .moGaweGreen,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 2,
                                                        color:
                                                            Color(0x8F515151),
                                                        offset: Offset(0, 2),
                                                        spreadRadius: 0,
                                                      )
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Icon(
                                                    Icons.delivery_dining,
                                                    color: FlutterFlowTheme
                                                        .secondaryColor,
                                                    size: 24,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                'Rp50.000',
                                                style: FlutterFlowTheme
                                                    .bodyText1
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  color: FlutterFlowTheme
                                                      .primaryColor,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                '/task',
                                                style: FlutterFlowTheme
                                                    .bodyText1
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(48, 32, 48, 0),
                            child: FFButtonWidget(
                              onPressed: () {
                                print('Button pressed ...');
                              },
                              text: 'Sign Me Up!',
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
                              loading: _loadingButton3,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
