import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mogawe/core/data/response/qiscus/chat_message_list_response.dart';
import 'package:mogawe/core/data/response/qiscus/chat_respnse.dart';
import 'package:mogawe/core/data/response/qiscus/createm_room_response.dart';
import 'package:mogawe/core/data/response/user_profile_response.dart';
import 'package:mogawe/core/data/sources/network/user_network_service.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
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
  final picker = ImagePicker();
  File? photo;
  String? path;
  UserProfileResponse? userdata;
  var token;
  var loadpesan;

  void chooseImage() {
    showDialog(
        context: context,
        builder: (ctx) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Material(
              borderRadius: BorderRadius.circular(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () => getImageCamera(),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(children: [
                        Icon(Icons.photo_camera, size: 24, color: Colors.black),
                        SizedBox(width: 16),
                        Text("Ambil Foto", style: TextStyle(
                            fontSize: 16
                        ))
                      ]),
                    ),
                  ),
                  InkWell(
                    onTap: () => getImageGallery(),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(children: [
                        Icon(Icons.image, size: 24, color: Colors.black),
                        SizedBox(width: 16),
                        Text("Dari Galeri", style: TextStyle(
                            fontSize: 16
                        ))
                      ]),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }

  Future getImageGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      photo = File(pickedFile.path);
      path = photo?.path.split('/').last;

    } else {
      Fluttertoast.showToast(msg: "Tidak ada foto yang dipilih");
    }
  }

  Future getFile() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      photo = File(pickedFile.path);
      path = photo?.path.split('/').last;

    } else {
      Fluttertoast.showToast(msg: "Tidak ada foto yang dipilih");
    }
  }

  Future getImageCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      photo = File(pickedFile.path);
      path = photo!.path.split('/').last;

    } else {
      Fluttertoast.showToast(msg: "Tidak ada foto yang dipilih");
    }
  }

  getData()async{
    token = await AuthRepository().readSecureData('token');
    userdata = await AuthRepository().getProfile(token);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void bottomFile(){
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
        initialChildSize: 0.25,
        maxChildSize: 0.25,
        minChildSize: 0.25,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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

                    SizedBox(height: 10,),
                    Expanded(
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16, right: 16),
                              child: ListView(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      getImageCamera();
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.camera_alt),
                                        SizedBox(width: 15,),
                                        Text('Take Photo'),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 16,),
                                  InkWell(
                                    onTap:(){
                                      getImageGallery();
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.image),
                                        SizedBox(width: 15,),
                                        Text('Image From Gallery'),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 16,),
                                  InkWell(
                                    onTap: (){
                                      getFile();
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.file_copy),
                                        SizedBox(width: 15,),
                                        Text('File / Document'),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 16,),
                                  InkWell(
                                    onTap: ()=> Navigator.pop(context),
                                    child: Row(
                                      children: [
                                        Icon(Icons.clear),
                                        SizedBox(width: 15,),
                                        Text('Cancel', style: TextStyle(color: Colors.red),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ),
                        )
                    )
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
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(
                  widget.qiscusRoomResponse?.results.room.roomName != null ? '${widget.qiscusRoomResponse?.results.room.roomName}' :
                  '${widget.room_name}',
                  style: FlutterFlowTheme.subtitle2.override(
                    fontFamily: 'Poppins',
                  ),
                  maxLines: 2,
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
                            CardReceived(chatResponse: widget.chatResponse, pesan: widget.pesan == null ? loadpesan : widget.pesan, userProfileResponse: widget.userProfileResponse,),
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
                    InkWell(
                      onTap:(){
                        bottomFile();
                      },
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                        child: Icon(
                          Icons.attach_file,
                          color: Color(0xFF777777),
                          size: 24,
                        ),
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

                        var res = await ChatQiscusRepo().kirimPesan(widget.id == null ? widget.qiscusRoomResponse?.results.room.roomId : widget.id, kirimpesan.text, widget.userProfileResponse?.email == null ? widget.chatResponse?.results.comment.user.userId : widget.userProfileResponse?.email);
                        if (widget.id == null){
                         loadpesan = await ChatQiscusRepo().getMessageList(widget.id == null ? widget.qiscusRoomResponse?.results.room.roomId : widget.id);
                        }

                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => ChatPage(room_name: widget.room_name == null? widget.qiscusRoomResponse?.results.room.roomName : widget.room_name, avatar: widget.avatar== null? widget.qiscusRoomResponse?.results.room.roomAvatarUrl : widget.avatar, chatResponse: res, pesan: widget.pesan == null ? loadpesan : widget.pesan, userProfileResponse: widget.userProfileResponse == null ? userdata : widget.userProfileResponse, id: widget.id == null ? widget.qiscusRoomResponse?.results.room.roomId : widget.id, ),
                            transitionDuration: Duration(seconds: 0),
                            reverseTransitionDuration: Duration(seconds: 0)
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
