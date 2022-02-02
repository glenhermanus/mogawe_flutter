import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mogawe/core/data/response/qiscus/chat_message_list_response.dart';
import 'package:mogawe/core/data/response/qiscus/chat_respnse.dart';
import 'package:mogawe/core/data/response/user_profile_response.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';

class CardReceived extends StatelessWidget {
  dynamic? pesan;
  ChatRoomMessage? chatRoomMessage;
  UserProfileResponse? userProfileResponse;
  ChatResponse? chatResponse;
  CardReceived({this.pesan, this.userProfileResponse, this.chatResponse, this.chatRoomMessage});

  @override
  Widget build(BuildContext context) {
    String? time2;
    String? date;
    var typeFile, typeFile2;
    if(pesan !=null){
        date = DateFormat.yMMMMEEEEd("id").format(this.pesan?.results.comments.last.timestamp);
    }

    if(chatResponse != null){
       time2 = DateFormat("HH:mm").format(chatResponse?.results.comment.timestamp as DateTime);
       typeFile = chatResponse?.results.comment.payload?.url.split('_').last.split('.').last;
       print('ab ${chatResponse?.results.comment.payload?.url.split('_').last.split('.').last}');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        pesan != null ? Center(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: Color(0xFFE3E3E3),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
              child: Text(
                '$date',
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  fontSize: 11,
                ),
              ),
            ),
          ),
        ),
      ) : Container(),
       pesan != null ? ListView.builder(
          shrinkWrap: true,
          reverse: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: this.pesan?.results.comments.length,
          itemBuilder: (context, snapshot){

            final list = this.pesan?.results.comments[snapshot];
           // DateTime dateTime = new DateFormat("HH:mm").parse(list?.timestamp);
            String time = DateFormat("HH:mm").format(list?.timestamp);
            typeFile2 = list?.payload?.url.split('_').last.split('.').last;
            print(list?.user.userId);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                list?.user.userId != this.userProfileResponse?.email ?  Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8, 10, 0, 0),
                child: Text(
                  '${list?.user.username}',
                  style: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Poppins',
                  ),
                ),
              ) : Container(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: list?.user.userId == this.userProfileResponse?.email ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [
                      list?.user.userId == this.userProfileResponse?.email ? Padding(
                        padding:
                        EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                        child: Text(
                          '$time',
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 11,
                          ),
                        ),
                      ) : Container(),
                      Expanded(
                        child: list?.type == 'text' ? Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: list?.user.userId == this.userProfileResponse?.email? Color(0xFFFFE0E0) : FlutterFlowTheme.secondaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16, 8, 16, 8),
                            child: Text(
                              '${list?.message}',
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ) : Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: list?.user.userId == this.userProfileResponse?.email? Color(0xFFFFE0E0) : FlutterFlowTheme.secondaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16, 8, 16, 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                typeFile2 == 'jpg' ? Image.network('${list?.payload?.url}') : typeFile2 == 'png' ? Image.network('${list?.payload?.url}')
                                    : typeFile2 == 'jpeg' ? Image.network('${list?.payload?.url}') : Row(
                                      children: [
                                        Icon(Icons.file_copy),
                                        Text('${list?.payload?.url.split('/').last}')
                                      ],
                                    ),
                                SizedBox(height: 5,),
                                list?.payload != null ? Text(
                                  '${list?.payload?.caption}',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                  ),
                                ) : Container(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      list?.user.userId != this.userProfileResponse?.email ? Padding(
                        padding:
                        EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                        child: Text(
                          '$time',
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 11,
                          ),
                        ),
                      ) : Container(),
                    ],
                  ),
                ),

              ],
            );
          },

        ) :  chatResponse != null ?  Row(
         mainAxisAlignment: MainAxisAlignment.end,
         children: [
           Padding(
             padding:
             EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
             child: Text(
               '$time2',
               style: FlutterFlowTheme.bodyText1.override(
                 fontFamily: 'Poppins',
                 fontSize: 11,
               ),
             ),
           ),
           Expanded(
             child: chatResponse?.results.comment.type == 'text' ? Card(
               clipBehavior: Clip.antiAliasWithSaveLayer,
               color: Color(0xFFFFE0E0),
               elevation: 0,
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(16),
               ),
               child: Padding(
                 padding: EdgeInsetsDirectional.fromSTEB(
                     16, 8, 16, 8),
                 child: Expanded(
                   child: Text(
                     '${chatResponse?.results.comment.message}',
                     style: FlutterFlowTheme.bodyText1.override(
                       fontFamily: 'Poppins',
                       fontSize: 14,
                     ),
                   ),
                 ),
               ),
             ) : Card(
               clipBehavior: Clip.antiAliasWithSaveLayer,
               color: Color(0xFFFFE0E0),
               elevation: 0,
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(16),
               ),
               child: Padding(
                 padding: EdgeInsetsDirectional.fromSTEB(
                     16, 8, 16, 8),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     typeFile == 'jpg' ? Image.network('${chatResponse?.results.comment.payload?.url}') : typeFile == 'png' ? Image.network('${chatResponse?.results.comment.payload?.url}')
                         : typeFile == 'jpeg' ? Image.network('${chatResponse?.results.comment.payload?.url}') : Icon(Icons.file_copy),
                     SizedBox(height: 5,),
                     chatResponse?.results.comment.payload != null ? Text(
                       '${chatResponse?.results.comment.payload?.caption}',
                       style: FlutterFlowTheme.bodyText1.override(
                         fontFamily: 'Poppins',
                         fontSize: 14,
                       ),
                     ) : Container(),
                   ],
                 ),
               ),
             ),
           ),
         ],
       ) : Container(), Container(),
        // chatRoomMessage != null ? ListView.builder(
        //   shrinkWrap: true,
        //   reverse: true,
        //   physics: NeverScrollableScrollPhysics(),
        //   itemCount: this.chatRoomMessage?.results.comments.length,
        //   itemBuilder: (context, snapshot){
        //
        //     final list = this.chatRoomMessage?.results.comments[snapshot];
        //     // DateTime dateTime = new DateFormat("HH:mm").parse(list?.timestamp);
        //     String time = DateFormat("HH:mm").format(list?.timestamp as DateTime);
        //
        //     print(list?.user.userId);
        //
        //     return Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       mainAxisAlignment: MainAxisAlignment.end,
        //       children: [
        //
        //         list?.user.userId != this.userProfileResponse?.email ?  Padding(
        //           padding: EdgeInsetsDirectional.fromSTEB(8, 10, 0, 0),
        //           child: Text(
        //             '${list?.user.username}',
        //             style: FlutterFlowTheme.bodyText1.override(
        //               fontFamily: 'Poppins',
        //             ),
        //           ),
        //         ) : Container(),
        //         Padding(
        //           padding: const EdgeInsets.only(bottom: 10),
        //           child: Row(
        //             mainAxisAlignment: list?.user.userId == this.userProfileResponse?.email ? MainAxisAlignment.end : MainAxisAlignment.start,
        //             children: [
        //               list?.user.userId == this.userProfileResponse?.email ? Padding(
        //                 padding:
        //                 EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
        //                 child: Text(
        //                   '$time',
        //                   style: FlutterFlowTheme.bodyText1.override(
        //                     fontFamily: 'Poppins',
        //                     fontSize: 11,
        //                   ),
        //                 ),
        //               ) : Container(),
        //               Expanded(
        //                 child: Card(
        //                   clipBehavior: Clip.antiAliasWithSaveLayer,
        //                   color: list?.user.userId == this.userProfileResponse?.email? Color(0xFFFFE0E0) : FlutterFlowTheme.secondaryColor,
        //                   elevation: 0,
        //                   shape: RoundedRectangleBorder(
        //                     borderRadius: BorderRadius.circular(16),
        //                   ),
        //                   child: Padding(
        //                     padding: EdgeInsetsDirectional.fromSTEB(
        //                         16, 8, 16, 8),
        //                     child: Text(
        //                       '${list?.message}',
        //                       style: FlutterFlowTheme.bodyText1.override(
        //                         fontFamily: 'Poppins',
        //                         fontSize: 14,
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //               list?.user.userId != this.userProfileResponse?.email ? Padding(
        //                 padding:
        //                 EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
        //                 child: Text(
        //                   '$time',
        //                   style: FlutterFlowTheme.bodyText1.override(
        //                     fontFamily: 'Poppins',
        //                     fontSize: 11,
        //                   ),
        //                 ),
        //               ) : Container(),
        //             ],
        //           ),
        //         ),
        //
        //       ],
        //     );
        //   },
        //
        // ) : Container(),

      ],
    );
  }
}
