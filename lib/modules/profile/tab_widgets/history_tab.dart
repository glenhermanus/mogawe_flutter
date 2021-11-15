import 'package:flutter/material.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({Key? key}) : super(key: key);

  @override
  _HistoryTabState createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {

  TextEditingController? textController1;
  TextEditingController? textController2;

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(
              16, 16, 16, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: TextFormField(
                  controller: textController1,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: 'search',
                    hintStyle: FlutterFlowTheme.bodyText1
                        .override(
                      fontFamily: 'Poppins',
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1,
                      ),
                      borderRadius:
                      BorderRadius.circular(8),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1,
                      ),
                      borderRadius:
                      BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor:
                    FlutterFlowTheme.fieldColor,
                    prefixIcon: Icon(
                      Icons.search,
                      size: 16,
                    ),
                  ),
                  style:
                  FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      16, 0, 0, 0),
                  child: TextFormField(
                    controller: textController2,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'last 7 days',
                      hintStyle: FlutterFlowTheme
                          .bodyText1
                          .override(
                        fontFamily: 'Poppins',
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius:
                        BorderRadius.circular(8),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius:
                        BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor:
                      FlutterFlowTheme.fieldColor,
                    ),
                    style: FlutterFlowTheme.bodyText1
                        .override(
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding:
          EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    24, 0, 0, 0),
                child: Text(
                  '12 Agustus 2021',
                  style:
                  FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    16, 8, 16, 0),
                child: Card(
                  clipBehavior:
                  Clip.antiAliasWithSaveLayer,
                  color: Color(0xFFF5F5F5),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding:
                    EdgeInsetsDirectional.fromSTEB(
                        16, 16, 16, 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          'MO1922 - Teknisi EDC PT. Mahapay',
                          style: FlutterFlowTheme
                              .subtitle2
                              .override(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional
                              .fromSTEB(0, 8, 0, 0),
                          child: Row(
                            mainAxisSize:
                            MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                EdgeInsetsDirectional
                                    .fromSTEB(
                                    0, 0, 8, 0),
                                child: Container(
                                  decoration:
                                  BoxDecoration(
                                    color:
                                    FlutterFlowTheme
                                        .moGaweGreen,
                                    borderRadius:
                                    BorderRadius
                                        .circular(4),
                                  ),
                                  child: Padding(
                                    padding:
                                    EdgeInsetsDirectional
                                        .fromSTEB(8,
                                        2, 8, 2),
                                    child: Text(
                                      'Approved',
                                      style:
                                      FlutterFlowTheme
                                          .bodyText2
                                          .override(
                                        fontFamily:
                                        'Poppins',
                                        color: FlutterFlowTheme
                                            .secondaryColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional
                                    .fromSTEB(
                                    0, 0, 8, 0),
                                child: Container(
                                  decoration:
                                  BoxDecoration(
                                    color:
                                    Color(0xFFC0C0C0),
                                    borderRadius:
                                    BorderRadius
                                        .circular(4),
                                  ),
                                  child: Padding(
                                    padding:
                                    EdgeInsetsDirectional
                                        .fromSTEB(8,
                                        2, 8, 2),
                                    child: Text(
                                      'Incentive',
                                      style:
                                      FlutterFlowTheme
                                          .bodyText2
                                          .override(
                                        fontFamily:
                                        'Poppins',
                                        color: FlutterFlowTheme
                                            .tertiaryColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisSize:
                                  MainAxisSize.max,
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .end,
                                  children: [
                                    Text(
                                      '+Rp50.000',
                                      style:
                                      FlutterFlowTheme
                                          .subtitle1
                                          .override(
                                        fontFamily:
                                        'Poppins',
                                        color: FlutterFlowTheme
                                            .moGaweGreen,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          height: 16,
                          thickness: 1,
                          color: Color(0xFFE7E7E7),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                          children: [
                            Text(
                              'Saldo berjalan:',
                              style: FlutterFlowTheme
                                  .bodyText1
                                  .override(
                                fontFamily: 'Poppins',
                                color: Color(0xFF8B8B8B),
                              ),
                            ),
                            Text(
                              'Rp85.000',
                              style: FlutterFlowTheme
                                  .bodyText1
                                  .override(
                                fontFamily: 'Poppins',
                                color: Color(0xFF8B8B8B),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    16, 8, 16, 0),
                child: Card(
                  clipBehavior:
                  Clip.antiAliasWithSaveLayer,
                  color: Color(0xFFF5F5F5),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding:
                    EdgeInsetsDirectional.fromSTEB(
                        16, 16, 16, 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          'MO1922 - Teknisi EDC PT. Mahapay',
                          style: FlutterFlowTheme
                              .subtitle2
                              .override(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional
                              .fromSTEB(0, 8, 0, 0),
                          child: Row(
                            mainAxisSize:
                            MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                EdgeInsetsDirectional
                                    .fromSTEB(
                                    0, 0, 8, 0),
                                child: Container(
                                  decoration:
                                  BoxDecoration(
                                    color:
                                    FlutterFlowTheme
                                        .moGaweGreen,
                                    borderRadius:
                                    BorderRadius
                                        .circular(4),
                                  ),
                                  child: Padding(
                                    padding:
                                    EdgeInsetsDirectional
                                        .fromSTEB(8,
                                        2, 8, 2),
                                    child: Text(
                                      'Approved',
                                      style:
                                      FlutterFlowTheme
                                          .bodyText2
                                          .override(
                                        fontFamily:
                                        'Poppins',
                                        color: FlutterFlowTheme
                                            .secondaryColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional
                                    .fromSTEB(
                                    0, 0, 8, 0),
                                child: Container(
                                  decoration:
                                  BoxDecoration(
                                    color:
                                    Color(0xFFC0C0C0),
                                    borderRadius:
                                    BorderRadius
                                        .circular(4),
                                  ),
                                  child: Padding(
                                    padding:
                                    EdgeInsetsDirectional
                                        .fromSTEB(8,
                                        2, 8, 2),
                                    child: Text(
                                      'Incentive',
                                      style:
                                      FlutterFlowTheme
                                          .bodyText2
                                          .override(
                                        fontFamily:
                                        'Poppins',
                                        color: FlutterFlowTheme
                                            .tertiaryColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisSize:
                                  MainAxisSize.max,
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .end,
                                  children: [
                                    Text(
                                      '+Rp50.000',
                                      style:
                                      FlutterFlowTheme
                                          .subtitle1
                                          .override(
                                        fontFamily:
                                        'Poppins',
                                        color: FlutterFlowTheme
                                            .moGaweGreen,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          height: 16,
                          thickness: 1,
                          color: Color(0xFFE7E7E7),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                          children: [
                            Text(
                              'Saldo berjalan:',
                              style: FlutterFlowTheme
                                  .bodyText1
                                  .override(
                                fontFamily: 'Poppins',
                                color: Color(0xFF8B8B8B),
                              ),
                            ),
                            Text(
                              'Rp85.000',
                              style: FlutterFlowTheme
                                  .bodyText1
                                  .override(
                                fontFamily: 'Poppins',
                                color: Color(0xFF8B8B8B),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
