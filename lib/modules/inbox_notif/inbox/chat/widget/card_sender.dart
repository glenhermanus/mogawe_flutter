import 'package:flutter/material.dart';
import 'package:mogawe/core/data/response/qiscus/chat_message_list_response.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';

class ChatSender extends StatelessWidget {
  ChatRoomMessage? chatRoomMessage;
  dynamic? pesan;
  ChatSender({this.chatRoomMessage, this.pesan});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: this.pesan?.results.comments.length,
      itemBuilder: (context, snapshot){
        final list = this.pesan?.results.comments[snapshot];
        return Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: Color(0xFFFFE0E0),
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
        );
      },

    );
  }
}
