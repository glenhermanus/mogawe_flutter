import 'package:flutter/material.dart';
import 'package:mogawe/core/data/response/qiscus/chat_message_list_response.dart';
import 'package:mogawe/core/data/response/qiscus/chat_respnse.dart';
import 'package:mogawe/core/data/response/qiscus/createm_room_response.dart';
import 'package:mogawe/core/data/response/user_profile_response.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/repositories/chat_qiscus_repositories.dart';
import 'package:mogawe/modules/inbox_notif/inbox/chat/widget/card_received.dart';
import 'package:mogawe/modules/inbox_notif/inbox/chat/widget/card_sender.dart';

class ChatPage extends StatefulWidget {
  ChatResponse? chatResponse;
  String? room_name, avatar;
  QiscusRoomResponse? qiscusRoomResponse;
  UserProfileResponse? userProfileResponse;
  dynamic? pesan;
  String? id;
  ChatPage({this.chatResponse, this.qiscusRoomResponse, this.pesan, this.userProfileResponse, this.id, this.avatar, this.room_name});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController kirimpesan = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.secondaryColor,
        iconTheme: IconThemeData(color: FlutterFlowTheme.tertiaryColor),
        automaticallyImplyLeading: true,
        title: Row(
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
                widget.chatResponse?.results.comment.user.avatarUrl != null ? '${widget.chatResponse?.results.comment.user.avatarUrl}' :
                '${widget.avatar}',
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
              child: Text(
                widget.qiscusRoomResponse?.results.room.roomName != null ? '${widget.qiscusRoomResponse?.results.room.roomName}' :
                '${widget.room_name}',
                style: FlutterFlowTheme.subtitle1.override(
                  fontFamily: 'Poppins',
                ),
              ),
            )
          ],
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: FlutterFlowTheme.fieldColor,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: ListView(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CardReceived(chatResponse: widget.chatResponse, pesan: widget.pesan, userProfileResponse: widget.userProfileResponse,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 64,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.secondaryColor,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                      child: Icon(
                        Icons.attach_file,
                        color: Color(0xFF777777),
                        size: 24,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                        child: TextFormField(
                          controller: kirimpesan,
                          decoration: InputDecoration(
                            hintText: 'Masukkan Pesan',
                            enabledBorder:  UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 0,
                              ),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 0,
                              ),
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                          // 'Masukkan pesan',
                          // style: FlutterFlowTheme.bodyText1.override(
                          //   fontFamily: 'Poppins',
                          //   color: Color(0xFF777777),
                          // ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: ()async{
                        var res = await ChatQiscusRepo().kirimPesan(widget.id, kirimpesan.text, widget.userProfileResponse?.email);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatPage(room_name: widget.room_name, avatar: widget.avatar, chatResponse: res, pesan: widget.pesan, userProfileResponse: widget.userProfileResponse, id: widget.id, ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 24, 0),
                        child: Icon(
                          Icons.send,
                          color: FlutterFlowTheme.primaryColor,
                          size: 24,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
