import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mogawe/core/data/response/qiscus/chat_message_list_response.dart';
import 'package:mogawe/core/data/response/qiscus/chat_respnse.dart';
import 'package:mogawe/core/data/response/qiscus/chat_room_list_response.dart';
import 'package:mogawe/core/data/response/qiscus/unread_response.dart';
import 'package:mogawe/core/data/response/user_profile_response.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/repositories/chat_qiscus_repositories.dart';
import 'package:mogawe/modules/inbox_notif/inbox/chat/chat_page.dart';
import 'package:mogawe/modules/inbox_notif/inbox/inbox/inbox_page.dart';
import 'package:mogawe/modules/inbox_notif/notification/widgets/build_loading_chat.dart';
import 'package:delayed_display/delayed_display.dart';

class ListInbox extends StatefulWidget {
  ChatRoomList? chatRoomList;
  ChatResponse? chatResponse;
  ModelUnread? modelUnread;
  final int indexChat;
  bool? view;
  UserProfileResponse? userProfileResponse;
  List<Map<dynamic, dynamic>>? chatRoomMessage;
  ListInbox({this.chatResponse, this.chatRoomList, this.chatRoomMessage, this.userProfileResponse, this.view, this.modelUnread, required this.indexChat});

  @override
  State<ListInbox> createState() => _ListInboxState();
}

class _ListInboxState extends State<ListInbox> {
  bool klik = false;
  ChatRoomMessage? chatRoomMessage;
  ModelUnread? unreadCount;
  bool loading = false;
  List<ChatRoomMessage?> isichat = [];
  List<ModelUnread?> isiCount = [];
  Timer? timer;
  int j =0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), (){

        loading = true;


    });
    getData();
   // callMehtod();
  }

  getData()async{


    if(mounted){
      if(widget.chatRoomList != null){
        for(var i = 0; i < widget.chatRoomList!.results.rooms.length; i++){
          var room = widget.chatRoomList?.results.rooms[i].roomId;
          print(room);
          unreadCount = await ChatQiscusRepo().getUnread(widget.userProfileResponse?.email, room).then((value) {

            isiCount.add(value);
          });
          chatRoomMessage = await ChatQiscusRepo().getMessageList(room).then((value) {
            isichat.add(value);
          });


          //print(chatRoomMessage?.results.comments.length);
        }
      }setState(() {
        loading = false;
      });

    }


  }


  void deleteMessageQ(room, user) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Konfirmasi"),
        content: const Text("Anda yakin ingin hapus pesan ?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async{

              try {
                await ChatQiscusRepo().deleteroom(room, user);
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (_, __, ___) => InboxPage(userProfileResponse: widget.userProfileResponse,),
                      transitionDuration: Duration(seconds: 0),
                      reverseTransitionDuration: Duration(seconds: 0)
                  ),
                );
              }catch(e){
                print('gagal');
              }
            },
            child: const Text('OK'),
          ),
        ],

      ),
    );
  }

 
  @override 
  Widget build(BuildContext context) {
    return loading? buildLoadingChat() : widget.chatRoomList != null ?  DelayedDisplay(
      fadeIn: true,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 35),
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.chatRoomList?.results.rooms.length,
          itemBuilder: (context, snap){
            var pesan, unread, date, time;
            final list = widget.chatRoomList?.results.rooms[snap];
                pesan =  isichat[snap];
                unread = isiCount[snap];

              date = DateFormat("dd/MM/yyyy").format(pesan?.results.comments.first.timestamp as DateTime);
              time = DateFormat("HH:mm").format((pesan?.results.comments.first.timestamp as DateTime));

            var now = DateTime.now();
            var today =  DateTime(now.year, now.month, now.day);

//        final message = widget.chatRoomMessage?.results.comments.length;
            return InkWell(
              onTap: () {
                klik = true;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(room_name: list?.roomName, avatar: list?.roomAvatarUrl, pesan: pesan, userProfileResponse: widget.userProfileResponse, id: list?.roomId,),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(

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
                                '${pesan?.results.comments.first.user.avatarUrl}',
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
                                            '${list?.roomName}',
                                            style: FlutterFlowTheme.bodyText1.override(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              pesan?.results.comments.first.timestamp != DateTime(now.year, now.month, now.day) ? '$date' : '$time',
                                              style: FlutterFlowTheme.bodyText1.override(
                                                fontFamily: 'Poppins',
                                                color: Color(0xFF777777),
                                                fontSize: 11,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),

                                          ],
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                      child: pesan?.results.comments.first.type == 'text' ? Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              pesan?.results.comments.first.user.userId == widget.userProfileResponse?.email ? 'You: ${pesan?.results.comments.first.message} ' :
                                              '${pesan?.results.comments.first.user.username.split(' ').first}: ${pesan?.results.comments.first.message} ',
                                              style: unread?.results.unreadCounts.first.unreadCount == 0 ? FlutterFlowTheme.bodyText1.override(
                                                fontFamily: 'Poppins',
                                                color: Color(0xFF7E7E7E),
                                                fontSize: 12,
                                              ) : FlutterFlowTheme.title1.override(
                                                fontFamily: 'Poppins',
                                                color: Colors.black87,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          unread?.results.unreadCounts.first.unreadCount != 0 ? Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(2),
                                              child: Center(child: Text('${unread?.results.unreadCounts.first.unreadCount}', style: FlutterFlowTheme.bodyText3.copyWith(color: Colors.white),)),
                                            ),
                                          ) : Container()
                                        ],
                                      ) : Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(

                                            children: [
                                              Text(
                                                pesan?.results.comments.first.user.userId == widget.userProfileResponse?.email ? 'You: ' :
                                                '${pesan?.results.comments.first.user.username.split(' ').first}: ',
                                                style: FlutterFlowTheme.bodyText1.override(
                                                  fontFamily: 'Poppins',
                                                  color: Color(0xFF7E7E7E),
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Icon(Icons.camera_alt),
                                              Text(' send an image', style:unread?.results.unreadCounts.first.unreadCount == 0 ? FlutterFlowTheme.bodyText1.override(
                                                fontFamily: 'Poppins',
                                                color: Color(0xFF7E7E7E),
                                                fontSize: 12,
                                              ) : FlutterFlowTheme.title1.override(
                                                fontFamily: 'Poppins',
                                                color: Colors.black87,
                                                fontSize: 12,
                                              ), )
                                            ],
                                          ),
                                          unread?.results.unreadCounts.first.unreadCount != 0 ? Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(2),
                                              child: Center(child: Text('${unread?.results.unreadCounts.first.unreadCount}', style: FlutterFlowTheme.bodyText3.copyWith(color: Colors.white),)),
                                            ),
                                          ) : Container()
                                        ],),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            widget.view == true ? Row(
                              children: [

                                InkWell(
                                    onTap: () {
                                      deleteMessageQ(list?.roomId,
                                          widget.userProfileResponse?.email);

                                    },
                                    child: Icon(Icons.clear))
                              ],
                            ) : Container()
                          ],
                        ),
                        // Divider()
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ) : Container();
  }
}