import 'package:flutter/material.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';

class SettingTab extends StatelessWidget {

  final Function() logoutProfile;
  const SettingTab({Key? key, required this.logoutProfile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsetsDirectional.fromSTEB(16, 24, 16, 0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Text(
                    'Ajak Teman',
                    style:
                    FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                    ),
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
                      'Ubah Password',
                      style: FlutterFlowTheme.bodyText1
                          .override(
                        fontFamily: 'Poppins',
                      ),
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
                      'Notifikasi',
                      style: FlutterFlowTheme.bodyText1
                          .override(
                        fontFamily: 'Poppins',
                      ),
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
                      'FAQ',
                      style: FlutterFlowTheme.bodyText1
                          .override(
                        fontFamily: 'Poppins',
                      ),
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
                      'Bantuan',
                      style: FlutterFlowTheme.bodyText1
                          .override(
                        fontFamily: 'Poppins',
                      ),
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
                      'About App',
                      style: FlutterFlowTheme.bodyText1
                          .override(
                        fontFamily: 'Poppins',
                      ),
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
                      'Rate App',
                      style: FlutterFlowTheme.bodyText1
                          .override(
                        fontFamily: 'Poppins',
                      ),
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
              child: InkWell(
                onTap: () {
                  print("Logout pressed");
                  logoutProfile();
                },
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        'Keluar',
                        style: FlutterFlowTheme.bodyText1
                            .override(
                          fontFamily: 'Poppins',
                          color:
                          FlutterFlowTheme.primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                  0, 16, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                      EdgeInsetsDirectional.fromSTEB(
                          0, 24, 0, 0),
                      child: Text(
                        'Mogawe v 5.0.22 © 2021',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.bodyText1
                            .override(
                          fontFamily: 'Poppins',
                          color: FlutterFlowTheme
                              .tertiaryColor,
                          fontSize: 12,
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
    );
  }
}
