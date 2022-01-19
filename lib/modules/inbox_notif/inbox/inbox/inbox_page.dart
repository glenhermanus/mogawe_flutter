import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/modules/inbox_notif/inbox/chat/chat_page.dart';

class InboxPage extends StatefulWidget {
  InboxPage({Key? key}) : super(key: key);

  @override
  _InboxPageState createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _loadingButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.secondaryColor,
        iconTheme: IconThemeData(color: FlutterFlowTheme.tertiaryColor),
        automaticallyImplyLeading: true,
        title: Text(
          'Inbox',
          style: FlutterFlowTheme.subtitle1.override(
            fontFamily: 'Poppins',
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ListInbox(),
                    ListInbox(),
                    ListInbox(),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.40,),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(50, 30, 50, 16),
                        child: FFButtonWidget(
                          onPressed: () async{

                          },
                          text: 'New Conversation',
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 56,
                            color: FlutterFlowTheme.primaryColor,
                            textStyle: FlutterFlowTheme.subtitle2.override(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                            ),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: 30,
                          ),
                          loading: _loadingButton,
                        ),
                      ),
                    )
                    // Column(
                    //   mainAxisSize: MainAxisSize.max,
                    //   children: [
                    //     Row(
                    //       mainAxisSize: MainAxisSize.max,
                    //       children: [
                    //         Container(
                    //           width: 48,
                    //           height: 48,
                    //           clipBehavior: Clip.antiAlias,
                    //           decoration: BoxDecoration(
                    //             shape: BoxShape.circle,
                    //           ),
                    //           child: Image.network(
                    //             'https://picsum.photos/seed/401/600',
                    //           ),
                    //         ),
                    //         Expanded(
                    //           child: Padding(
                    //             padding:
                    //                 EdgeInsetsDirectional.fromSTEB(
                    //                     16, 0, 0, 0),
                    //             child: Column(
                    //               mainAxisSize: MainAxisSize.max,
                    //               crossAxisAlignment:
                    //                   CrossAxisAlignment.start,
                    //               children: [
                    //                 Row(
                    //                   mainAxisSize: MainAxisSize.max,
                    //                   children: [
                    //                     Expanded(
                    //                       child: Text(
                    //                         'Gawean IDM Asem Baris',
                    //                         style: FlutterFlowTheme
                    //                             .bodyText1
                    //                             .override(
                    //                           fontFamily: 'Poppins',
                    //                           fontWeight:
                    //                               FontWeight.w600,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                     Text(
                    //                       '26/08/2021',
                    //                       style: FlutterFlowTheme
                    //                           .bodyText1
                    //                           .override(
                    //                         fontFamily: 'Poppins',
                    //                         color: Color(0xFF777777),
                    //                         fontSize: 11,
                    //                         fontWeight:
                    //                             FontWeight.normal,
                    //                       ),
                    //                     )
                    //                   ],
                    //                 ),
                    //                 Padding(
                    //                   padding: EdgeInsetsDirectional
                    //                       .fromSTEB(0, 4, 0, 0),
                    //                   child: Text(
                    //                     'Admin : Sudah bisa dicoba ya',
                    //                     style: FlutterFlowTheme
                    //                         .bodyText1
                    //                         .override(
                    //                       fontFamily: 'Poppins',
                    //                       color: Color(0xFF7E7E7E),
                    //                       fontSize: 12,
                    //                     ),
                    //                   ),
                    //                 )
                    //               ],
                    //             ),
                    //           ),
                    //         )
                    //       ],
                    //     ),
                    //     Divider()
                    //   ],
                    // ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ListInbox extends StatelessWidget {
  const ListInbox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
      child: InkWell(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                        'https://picsum.photos/seed/401/600',
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Gawean IDM Asem Baris',
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Text(
                                  '26/08/2021',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF777777),
                                    fontSize: 11,
                                    fontWeight: FontWeight.normal,
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                              child: Text(
                                'Admin : Sudah bisa dicoba ya',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF7E7E7E),
                                  fontSize: 12,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                // Divider()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
