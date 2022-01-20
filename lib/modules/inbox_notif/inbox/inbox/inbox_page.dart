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

  TextEditingController judul = new TextEditingController();
  TextEditingController pertanyaan = new TextEditingController();

  void bottomNew(){
    final node = FocusScope.of(context);
    showModalBottomSheet(
      isScrollControlled: true,

      context: context,
      backgroundColor: Colors.white,

      shape : RoundedRectangleBorder(
          borderRadius : BorderRadius.vertical( top: Radius.circular(30),)

      ),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.75,
        maxChildSize: 0.75,
        minChildSize: 0.75,
        builder: (context, scrollController) =>  StatefulBuilder(
            builder: (BuildContext context, StateSetter stateSetter) {

              return Container(

                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),
                  color: Colors.white,
                ),
                child: ListView(
                  controller: scrollController,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10, top: 10),
                        child: Container(
                          width: 25,
                          height: 3,
                          color: Color(0xffbfbfbf),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Judul Chat', style: FlutterFlowTheme.subtitle3.copyWith(color: Colors.black54, fontSize: 14),),
                          SizedBox(height: 10,),
                          TextFormField(
                            controller: judul,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: '',
                              hintStyle: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins', color: Colors.black38
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(0),
                              ),

                            ),
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                            ),
                            maxLength: 40,
                            onChanged: (s)async{
                              setState(() {

                              });

                            },
                          ),
                          SizedBox(height: 40,),
                          Text('Pertanyaan', style: FlutterFlowTheme.subtitle3.copyWith(color: Colors.black54, fontSize: 14),),
                          SizedBox(height: 10,),
                          TextFormField(
                            controller: pertanyaan,
                            obscureText: false,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '',
                              hintStyle: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins', color: Colors.black38
                              ),

                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(0),
                              ),

                            ),
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                            ),
                            maxLength: 294,
                            minLines: 1,
                            maxLines: 4,
                            keyboardType: TextInputType.text,
                            onChanged: (s)async{
                              setState(() {

                              });

                            },
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.28,),

                        ],
                      ),
                    ),
                    FFButtonWidget(
                      onPressed: (){
                        bottomNew();
                      },
                      text: 'Kirim Pesan',
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 56,
                        color: Colors.red,
                        textStyle: FlutterFlowTheme.subtitle2.override(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: 0,
                      ),
                      loading: _loadingButton,
                    ),
                  ],
                ),
              );
            }
        ),
      ),
    );
  }

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
                          onPressed: (){
                            bottomNew();
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
