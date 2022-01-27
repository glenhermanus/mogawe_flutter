import 'package:mogawe/core/data/response/qiscus/chat_message_list_response.dart';
import 'package:mogawe/core/data/response/qiscus/chat_respnse.dart';
import 'package:mogawe/core/data/response/qiscus/chat_room_list_response.dart';
import 'package:mogawe/core/data/response/user_profile_response.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/core/repositories/chat_qiscus_repositories.dart';
import 'package:mogawe/modules/inbox_notif/inbox/chat/chat_page.dart';

class InboxPage extends StatefulWidget {
  UserProfileResponse? userProfileResponse;
  InboxPage({this.userProfileResponse});

  @override
  _InboxPageState createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _loadingButton = false;
  var chat;

  TextEditingController judul = new TextEditingController();
  TextEditingController pertanyaan = new TextEditingController();
  var token;
  bool loading =false;
  ChatRoomList? chatRoomList;
  ChatRoomMessage? chatRoomMessage, chatRoomMessage2;
  var room;
  var pesan =[{}];

  void getToken() async {
    setState(() {
      loading = true;
    });
    token = await AuthRepository().readSecureData('token');

    print("OUT >> hey");
    print(token);

    chatRoomList = await ChatQiscusRepo().getRoomList(widget.userProfileResponse?.email);
    for(var i = 0; i < chatRoomList!.results.rooms.length; i++){
      room = chatRoomList?.results.rooms[i].roomId;
      print(room);

      chatRoomMessage = await ChatQiscusRepo().getMessageList(room);

      //print(chatRoomMessage?.results.comments.length);
      var pesanbaru = {
        'pesan' : chatRoomMessage
      };
      pesan.add(pesanbaru);
    }

    setState(() {
      loading = false;
      pesan.removeAt(0);
      print(pesan);

    });
  }

  void bottomNew(){
    final node = FocusScope.of(context);
    var isipesan;
    print('a');
    print(pesan);
    for(var i =0; i < chatRoomList!.results.rooms.length; i++){
       isipesan = pesan[i]['pesan'];
    }
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
                          var res = await ChatQiscusRepo().createRoom(judul.text, widget.userProfileResponse?.email);
                          chat = await ChatQiscusRepo().kirimPesan(res.results.room.roomId, pertanyaan.text, widget.userProfileResponse?.email);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatPage(chatResponse: chat, qiscusRoomResponse: res,),
                            ),
                          );
                        }catch(e){
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
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
        child:Stack(
          children: [
            loading ? Align(
              alignment: Alignment.topCenter,
                child: CircularProgressIndicator()) : ListView(
              children: [
                 ListInbox(chatResponse: chat, chatRoomList: chatRoomList, chatRoomMessage: pesan, userProfileResponse: widget.userProfileResponse,),


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
    );
  }
}

class ListInbox extends StatefulWidget {
  ChatRoomList? chatRoomList;
  ChatResponse? chatResponse;
  UserProfileResponse? userProfileResponse;
  List<Map<dynamic, dynamic>>? chatRoomMessage;
  ListInbox({this.chatResponse, this.chatRoomList, this.chatRoomMessage, this.userProfileResponse});

  @override
  State<ListInbox> createState() => _ListInboxState();
}

class _ListInboxState extends State<ListInbox> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.chatRoomList?.results.rooms.length,
      itemBuilder: (context, snap){
        final list = widget.chatRoomList?.results.rooms[snap];
        final pesan = widget.chatRoomMessage?[snap]['pesan'];
        print(pesan);
//        final message = widget.chatRoomMessage?.results.comments.length;
        return InkWell(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(room_name: list?.roomName, avatar: list?.roomAvatarUrl, chatResponse: widget.chatResponse, pesan: pesan, userProfileResponse: widget.userProfileResponse, id: list?.roomId,),
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
                            '${list?.roomAvatarUrl}',
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
                                    '${pesan.results.comments.first.message} ',
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
      },
    );
  }
}
