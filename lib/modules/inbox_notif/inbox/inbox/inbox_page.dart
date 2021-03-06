import 'dart:async';

import 'package:intl/intl.dart';
import 'package:mogawe/core/data/response/qiscus/chat_message_list_response.dart';
import 'package:mogawe/core/data/response/qiscus/chat_respnse.dart';
import 'package:mogawe/core/data/response/qiscus/chat_room_list_response.dart';
import 'package:mogawe/core/data/response/qiscus/get_uuid_user.dart';
import 'package:mogawe/core/data/response/qiscus/participants_response.dart';
import 'package:mogawe/core/data/response/qiscus/unread_response.dart';
import 'package:mogawe/core/data/response/user_profile_response.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/core/repositories/chat_qiscus_repositories.dart';
import 'package:mogawe/modules/inbox_notif/inbox/chat/chat_page.dart';
import 'package:mogawe/modules/inbox_notif/inbox/inbox/list_chat.dart';
import 'package:mogawe/modules/inbox_notif/notification/widgets/build_loading_chat.dart';

class InboxPage extends StatefulWidget {
  final UserProfileResponse? userProfileResponse;
  InboxPage({this.userProfileResponse});

  @override
  _InboxPageState createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _loadingButton = false;
  var chat;
  ParticipantsModel? participantsModel;
  bool view = false;
  TextEditingController judul = new TextEditingController();
  TextEditingController pertanyaan = new TextEditingController();
  var token;
  bool loading =false;
  ChatRoomList? chatRoomList;
  ChatRoomMessage? chatRoomMessage, chatRoomMessage2;
  var room, loadRoom1;
  var pesan =[{}];
  var pesan2 =[{}];
  List uuidValue = [];
  List emailUser = [];
  ModelGetUuid? modelGetUuid;
  Timer? timer;
  ModelUnread? unreadCount;

  void getToken() async {
    setState(() {
      loading = true;
    });
    token = await AuthRepository().readSecureData('token');
    await ChatQiscusRepo().createUserorLogin(widget.userProfileResponse?.email, widget.userProfileResponse?.password, widget.userProfileResponse?.full_name, widget.userProfileResponse?.profil_picture);

    print("OUT >> hey");
    print(token);

    chatRoomList = await ChatQiscusRepo().getRoomList(widget.userProfileResponse?.email);

    if(chatRoomList?.status == 200){
      for(var i = 0; i < chatRoomList!.results.rooms.length; i++){
        room = chatRoomList?.results.rooms[i].roomId;
        print(room);
        unreadCount = await ChatQiscusRepo().getUnread(widget.userProfileResponse?.email, room);
        chatRoomMessage = await ChatQiscusRepo().getMessageList(room);


        //print(chatRoomMessage?.results.comments.length);
        var pesanbaru = {
          'pesan' : chatRoomMessage,
          'unread' : unreadCount
        };
        pesan.add(pesanbaru);
      }
    }


    setState(() {
      loading = false;
      pesan.removeAt(0);
      print(pesan);

    });
  }

  loadingAlert(title, status, loading) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => StatefulBuilder(
            builder: (BuildContext context, StateSetter stateSetter) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                contentPadding: EdgeInsets.only(top: 0.0, bottom: 20),
                content: Container(
                  width: MediaQuery.of(context).size.width * 0.5,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[

                      Divider(
                        color: Colors.grey,
                        height: 1.0,
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(19.0),
                          ),
                        ),
                        child: Column(
                          children: [
                            status != null ? status == true ? Icon(Icons.check, size: 30,) : Icon(Icons.clear, size: 30,) : Container(),
                            SizedBox(height: 15,),
                            Text('$title', style: FlutterFlowTheme.bodyText2,),
                            SizedBox(height: 15,),
                            loading == true ? CircularProgressIndicator(color: Colors.red,) : Container(),
                            SizedBox(height: 10,),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }

  void bottomNew(){
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
                      onPressed: ()async{

                        try{
                          loadingAlert('Mohon tunggu sebentar', null, true);
                          var res = await ChatQiscusRepo().createRoom(judul.text, widget.userProfileResponse?.email, '');
                          participantsModel = await ChatQiscusRepo().getParticipants(res.results.room.roomId);
                          for(var i= 0; i< participantsModel!.results.participants.length; i++){
                            if(participantsModel!.results.participants[i].userId != widget.userProfileResponse?.email){
                              emailUser.add(participantsModel!.results.participants[i].userId);
                            }

                          }
                          print(emailUser);

                          for(var j =0; j<emailUser.length; j++){
                            modelGetUuid = await ChatQiscusRepo().getUuiduser(emailUser[j]);
                            if(modelGetUuid!.object.isNotEmpty){
                              uuidValue.add(modelGetUuid?.object.first.uuid);
                            }

                          }
                          print(uuidValue);
                          chat = await ChatQiscusRepo().kirimPesan(res.results.room.roomId, pertanyaan.text, widget.userProfileResponse?.email);
                          await ChatQiscusRepo().notificationSend(chat.results.comment.message, chat.results.comment.user.username,
                              uuidValue, token);
                          var load = await ChatQiscusRepo().getMessageList(res.results.room.roomId);
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatPage( qiscusRoomResponse: res, pesan: load, userProfileResponse: widget.userProfileResponse,),
                            ),
                          );
                        }catch(e){
                          loadingAlert('$e', false, false);
                          print(e);

                        }

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

  getRoomList()async{
    if(mounted){

      setState(() {
        Widget listRoom (BuildContext context){

          return FutureBuilder(
              future: ChatQiscusRepo().getRoomList(widget.userProfileResponse?.email),
              builder: (context, snapshot){
                loadRoom1 = snapshot.data;

                if(snapshot.hasData){
                  return ListInbox(chatResponse: chat, chatRoomList: loadRoom1, indexChat: 1, userProfileResponse: widget.userProfileResponse, view: view,);

                }
                return ListInbox(chatResponse: chat, chatRoomList: chatRoomList, chatRoomMessage: pesan, userProfileResponse: widget.userProfileResponse, view: view, indexChat: 0,);

              });
        }
      });
    }
  }

  void selectedItem(BuildContext context, item) {
    switch (item) {
      case 0:
        setState(() {
          view = true;
        });

        break;
      case 1:
        setState(() {
          view = false;
        });

        break;
    }
  }

  Future<void> callMehtod() async {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {

      setState(() {
        getRoomList();
      });

    });
  }

  @override
  void initState() {
    super.initState();
    getToken();
    callMehtod();
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  Widget listRoom (BuildContext context){

    return FutureBuilder(
        future: ChatQiscusRepo().getRoomList(widget.userProfileResponse?.email),
        builder: (context, snapshot){

          loadRoom1 = snapshot.data;

          if(snapshot.hasData){
            return ListInbox(chatResponse: chat, chatRoomList: loadRoom1, indexChat: 1, userProfileResponse: widget.userProfileResponse, view: view,);

          }
          return ListInbox(chatResponse: chat, chatRoomList: chatRoomList, indexChat: 0, chatRoomMessage: pesan, userProfileResponse: widget.userProfileResponse, view: view,);

        });
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
        actions: [
          PopupMenuButton<int>(
            color: Colors.white,
            icon: Icon(Icons.more_vert_rounded, color: Colors.black,),
            itemBuilder: (context) => [
              PopupMenuItem<int>(value: 0, child: Row(
                children: [
                  Icon(Icons.edit, color: Colors.black,),
                  SizedBox(width: 20,),
                  Text('Edit'),
                ],
              )),
              view == true? PopupMenuItem<int>(value: 1, child: Row(
                children: [
                  Icon(Icons.arrow_back, color: Colors.black,),
                  SizedBox(width: 20,),
                  Text('Cancel'),
                ],
              )) : PopupMenuItem<int>(value: 1, child: Row(
                children: [
                  Container()
                ],
              )),
            ],
            onSelected: (item) => selectedItem(context, item),
          )
        ],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child:RefreshIndicator(
          onRefresh: () async {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                  pageBuilder: (_, __, ___) => InboxPage(userProfileResponse: widget.userProfileResponse,),
                  transitionDuration: Duration(seconds: 0),
                  reverseTransitionDuration: Duration(seconds: 0)
              ),
            );
          },
          child: Stack(
            children: [
              loading ? buildLoadingChat()  : ListView(
                children: [
                  // ListInbox(chatResponse: chat, chatRoomList: chatRoomList, chatRoomMessage: pesan, userProfileResponse: widget.userProfileResponse, view: view,),
                  // :
                  listRoom(context),
                  SizedBox(height: 50,),

                ],
              ),Align(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}