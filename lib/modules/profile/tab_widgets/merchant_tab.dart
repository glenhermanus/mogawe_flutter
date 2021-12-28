import 'package:flutter/material.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';

class MerchantTab extends StatelessWidget {
  const MerchantTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(
              16, 24, 16, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Informasi Toko',
                style:
                FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  color: FlutterFlowTheme.primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    0, 16, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        'Nama Toko',
                        style: FlutterFlowTheme.bodyText1
                            .override(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    Text(
                      ' Toko Gellaps',
                      style: FlutterFlowTheme.bodyText1
                          .override(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.black,
                      size: 24,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    0, 16, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        'Alamat Pickup',
                        style: FlutterFlowTheme.bodyText1
                            .override(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    Text(
                      'Jl Rawasari Timur 1 dalam',
                      style: FlutterFlowTheme.bodyText1
                          .override(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.black,
                      size: 24,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    0, 24, 0, 16),
                child: Text(
                  'Metode Pengiriman',
                  style:
                  FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Poppins',
                    color: FlutterFlowTheme.primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text('Gratis Ongkir',
                      style: FlutterFlowTheme.bodyText1
                          .override(
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  Text(
                    ' Toko Gellaps',
                    style: FlutterFlowTheme.bodyText1
                        .override(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.black,
                    size: 24,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    0, 16, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        'Ekspedisi',
                        style: FlutterFlowTheme.bodyText1
                            .override(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    Text(
                      ' Toko Gellaps',
                      style: FlutterFlowTheme.bodyText1
                          .override(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.black,
                      size: 24,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(
              16, 24, 16, 0),
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
                    'Produk',
                    style: FlutterFlowTheme.bodyText1
                        .override(
                      fontFamily: 'Poppins',
                      color:
                      FlutterFlowTheme.primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Semua Produk',
                    style: FlutterFlowTheme.bodyText1
                        .override(
                      fontFamily: 'Poppins',
                      color:
                      FlutterFlowTheme.primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
                16, 16, 16, 0),
            child: GridView(
              padding: EdgeInsets.zero,
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              scrollDirection: Axis.vertical,
              children: [
                Card(
                  clipBehavior:
                  Clip.antiAliasWithSaveLayer,
                  color: Color(0xFFF5F5F5),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Stack(
                        alignment:
                        AlignmentDirectional(0, 1),
                        children: [
                          Image.network(
                            'https://picsum.photos/seed/624/600',
                            width: double.infinity,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional
                            .fromSTEB(8, 8, 8, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Baju Batik Oke',
                              style: FlutterFlowTheme
                                  .bodyText1
                                  .override(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional
                                  .fromSTEB(
                                  0, 4, 0, 0),
                              child: Row(
                                mainAxisSize:
                                MainAxisSize.max,
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text(
                                    'Rp100.000',
                                    style:
                                    FlutterFlowTheme
                                        .bodyText1
                                        .override(
                                      fontFamily:
                                      'Poppins',
                                      fontSize: 11,
                                    ),
                                  ),
                                  Text(
                                    'Rp10.000',
                                    style:
                                    FlutterFlowTheme
                                        .bodyText1
                                        .override(
                                      fontFamily:
                                      'Poppins',
                                      fontSize: 11,
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
                Card(
                  clipBehavior:
                  Clip.antiAliasWithSaveLayer,
                  color: Color(0xFFF5F5F5),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Stack(
                        alignment:
                        AlignmentDirectional(0, 1),
                        children: [
                          Image.network(
                            'https://picsum.photos/seed/624/600',
                            width: double.infinity,
                            height: 100,
                            fit: BoxFit.cover,
                          ),

                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional
                            .fromSTEB(8, 8, 8, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Baju Batik Oke',
                              style: FlutterFlowTheme
                                  .bodyText1
                                  .override(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional
                                  .fromSTEB(
                                  0, 4, 0, 0),
                              child: Row(
                                mainAxisSize:
                                MainAxisSize.max,
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text(
                                    'Rp100.000',
                                    style:
                                    FlutterFlowTheme
                                        .bodyText1
                                        .override(
                                      fontFamily:
                                      'Poppins',
                                      fontSize: 11,
                                    ),
                                  ),
                                  Text(
                                    'Rp10.000',
                                    style:
                                    FlutterFlowTheme
                                        .bodyText1
                                        .override(
                                      fontFamily:
                                      'Poppins',
                                      fontSize: 11,
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
                Card(
                  clipBehavior:
                  Clip.antiAliasWithSaveLayer,
                  color: Color(0xFFF5F5F5),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Stack(
                        alignment:
                        AlignmentDirectional(0, 1),
                        children: [
                          Image.network(
                            'https://picsum.photos/seed/624/600',
                            width: double.infinity,
                            height: 100,
                            fit: BoxFit.cover,
                          ),

                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional
                            .fromSTEB(8, 8, 8, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Baju Batik Oke',
                              style: FlutterFlowTheme
                                  .bodyText1
                                  .override(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional
                                  .fromSTEB(
                                  0, 4, 0, 0),
                              child: Row(
                                mainAxisSize:
                                MainAxisSize.max,
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text(
                                    'Rp100.000',
                                    style:
                                    FlutterFlowTheme
                                        .bodyText1
                                        .override(
                                      fontFamily:
                                      'Poppins',
                                      fontSize: 11,
                                    ),
                                  ),
                                  Text(
                                    'Rp10.000',
                                    style:
                                    FlutterFlowTheme
                                        .bodyText1
                                        .override(
                                      fontFamily:
                                      'Poppins',
                                      fontSize: 11,
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
                Card(
                  clipBehavior:
                  Clip.antiAliasWithSaveLayer,
                  color: Color(0xFFF5F5F5),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Stack(
                        alignment:
                        AlignmentDirectional(0, 1),
                        children: [
                          Image.network(
                            'https://picsum.photos/seed/624/600',
                            width: double.infinity,
                            height: 100,
                            fit: BoxFit.cover,
                          ),

                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional
                            .fromSTEB(8, 8, 8, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Baju Batik Oke',
                              style: FlutterFlowTheme
                                  .bodyText1
                                  .override(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional
                                  .fromSTEB(
                                  0, 4, 0, 0),
                              child: Row(
                                mainAxisSize:
                                MainAxisSize.max,
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text(
                                    'Rp100.000',
                                    style:
                                    FlutterFlowTheme
                                        .bodyText1
                                        .override(
                                      fontFamily:
                                      'Poppins',
                                      fontSize: 11,
                                    ),
                                  ),
                                  Text(
                                    'Rp10.000',
                                    style:
                                    FlutterFlowTheme
                                        .bodyText1
                                        .override(
                                      fontFamily:
                                      'Poppins',
                                      fontSize: 11,
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
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
