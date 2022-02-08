import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mogawe/core/data/response/qiscus/chat_message_list_response.dart';
import 'package:mogawe/core/data/response/qiscus/chat_respnse.dart';
import 'package:mogawe/core/data/response/qiscus/createm_room_response.dart';
import 'package:mogawe/core/data/response/qiscus/get_uuid_user.dart';
import 'package:mogawe/core/data/response/qiscus/participants_response.dart';
import 'package:mogawe/core/data/response/user_profile_response.dart';
import 'package:mogawe/core/data/sources/network/user_network_service.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/core/repositories/chat_qiscus_repositories.dart';
import 'package:mogawe/modules/inbox_notif/inbox/chat/widget/card_received.dart';
import 'package:mogawe/modules/inbox_notif/inbox/chat/widget/card_sender.dart';
import 'package:dio/dio.dart';
import 'package:mogawe/modules/inbox_notif/notification/notif.dart';
import 'package:rxdart/rxdart.dart';

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
  final _navigatorKey = GlobalKey<NavigatorState>();
  PersistentBottomSheetController? _controller;
  TextEditingController kirimpesan = new TextEditingController();
  TextEditingController caption = new TextEditingController();
  ScrollController _scrollController = new ScrollController();
  final picker = ImagePicker();
  File? photo;
  String? path;
  UserProfileResponse? userdata;
  var token;
  var loadpesan, loadpesans1;
  var filePick;
  Timer? timer, timer2;
  ParticipantsModel? participantsModel;
  List email_user =[];
  ModelGetUuid? modelGetUuid;
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
  final FileType pickingType = FileType.any;
  var type;
  bool view = false;
  final FirebaseMessaging message = FirebaseMessaging.instance;
  var initsetting;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  BehaviorSubject<ReceiveNotification> get didReceiveLocalNotificationSubject =>
      BehaviorSubject<ReceiveNotification>();
  List uuidValue = [];

  Future getImageGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      photo = File(pickedFile.path);
      path = photo?.path.split('/').last;
      type ='image';
      Navigator.pop(context);
      viewImage();
    } else {
      Fluttertoast.showToast(msg: "Tidak ada foto yang dipilih");
    }
  }

  Future getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false, type: pickingType);

    if (result != null) {
      photo = File(result.files.single.path!);
      path = photo?.path.split('/').last;
      type = 'pdf';
      Navigator.pop(context);
      viewFile(path);
    } else {
      Fluttertoast.showToast(msg: "Tidak ada foto yang dipilih");
    }
  }

  Future getImageCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      photo = File(pickedFile.path);
      path = photo!.path.split('/').last;
      type ='image';
      Navigator.pop(context);
      viewImage();

    } else {
      Fluttertoast.showToast(msg: "Tidak ada foto yang dipilih");
    }
  }

  getData()async{
    token = await AuthRepository().readSecureData('token');
    participantsModel = await ChatQiscusRepo().getParticipants(widget.id == null ? widget.qiscusRoomResponse?.results.room.roomId : widget.id);
    userdata = await AuthRepository().getProfile(token);
    Future.delayed(Duration.zero, () {
      _scrollController.animateTo( _scrollController.position.maxScrollExtent,
          duration: const Duration(microseconds: 1),curve: Curves.easeOut);
    });
    for(var i= 0; i< participantsModel!.results.participants.length; i++){
      if(participantsModel!.results.participants[i].userId != widget.userProfileResponse?.email){
        email_user.add(participantsModel!.results.participants[i].userId);
      }

    }

    for(var j =0; j<email_user.length; j++){
      modelGetUuid = await ChatQiscusRepo().getUuiduser(email_user[j]);
      if(modelGetUuid!.object.isNotEmpty){
        uuidValue.add(modelGetUuid?.object.first.uuid);
      }

    }

  }

  getLoadPesan()async{
    if(mounted){
      setState(() {
        Widget listChat (BuildContext context){
          return FutureBuilder(
              future: ChatQiscusRepo().getMessageList(widget.id == null ? widget.qiscusRoomResponse?.results.room.roomId : widget.id),
              builder: (context, snapshot){

                loadpesans1 = snapshot.data;

                ChatQiscusRepo().notificationSend(loadpesans1.results.comments.first.message, loadpesans1.results.comments.first.user.username, widget.userProfileResponse?.uuid, token);
                if(snapshot.hasData){
                  print('aa ${loadpesans1.results.comments.first.message}');
                  return CardReceived( pesan: widget.chatResponse != null ? null : loadpesans1, userProfileResponse: widget.userProfileResponse, );

                }
                return CardReceived(chatResponse: widget.chatResponse, pesan: widget.pesan == null ?  loadpesan : widget.pesan, userProfileResponse: widget.userProfileResponse);

              });
        }

      });
    }


  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    callMehtod();

  }


  Future<void> callMehtod() async {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        getLoadPesan();
      });

    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
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

  void viewImage(){
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
        initialChildSize: 1,
        maxChildSize: 1,
        minChildSize: 1,
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
                          color: Colors.white,
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
                                      Navigator.pop(context);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.arrow_back, size: 34,),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Image.file(photo!),

                                ],
                              ),
                            ),

                          ),
                        )
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 2,
                            color: Colors.black12,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [

                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                                  child: TextFormField(
                                    controller: caption,
                                    decoration: InputDecoration(
                                      hintText: 'Add caption',
                                      enabledBorder:  UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black12,
                                          width: 1,
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

                                  var body = {
                                    'file' : photo
                                  };
                                  try{
                                    var uploadfile = await ChatQiscusRepo().uploadFileChat(body, token, type);
                                    loadingAlert('Mohon tunggu sebentar', null, true);
                                    var res = await ChatQiscusRepo().kirimPesanFile(widget.id == null ? widget.qiscusRoomResponse?.results.room.roomId : widget.id, caption.text, widget.userProfileResponse?.email == null ? widget.chatResponse?.results.comment.user.userId : widget.userProfileResponse?.email, uploadfile.object);
                                    loadpesan = await ChatQiscusRepo().getMessageList(widget.id == null ? widget.qiscusRoomResponse?.results.room.roomId : widget.id);
                                    await ChatQiscusRepo().notificationSend(res.results.comment.message, res.results.comment.user.username,
                                        uuidValue, token);

                                    //    Navigator.pop(context);
                                    stateSetter(() {

                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pushReplacement(
                                        PageRouteBuilder(
                                            pageBuilder: (_, __, ___) => ChatPage(room_name: widget.room_name == null? widget.qiscusRoomResponse?.results.room.roomName : widget.room_name, avatar: widget.avatar== null? widget.qiscusRoomResponse?.results.room.roomAvatarUrl : widget.avatar, chatResponse: null, pesan: loadpesan, userProfileResponse: widget.userProfileResponse == null ? userdata : widget.userProfileResponse, id: widget.id == null ? widget.qiscusRoomResponse?.results.room.roomId : widget.id, ),
                                            transitionDuration: Duration(seconds: 0),
                                            reverseTransitionDuration: Duration(seconds: 0)
                                        ),
                                      );
                                      Navigator.of(context).pushReplacement(
                                        PageRouteBuilder(
                                            pageBuilder: (_, __, ___) => ChatPage(room_name: widget.room_name == null? widget.qiscusRoomResponse?.results.room.roomName : widget.room_name, avatar: widget.avatar== null? widget.qiscusRoomResponse?.results.room.roomAvatarUrl : widget.avatar, chatResponse: null, pesan: loadpesan, userProfileResponse: widget.userProfileResponse == null ? userdata : widget.userProfileResponse, id: widget.id == null ? widget.qiscusRoomResponse?.results.room.roomId : widget.id, ),
                                            transitionDuration: Duration(seconds: 0),
                                            reverseTransitionDuration: Duration(seconds: 0)
                                        ),
                                      );
                                      _controller?.closed;
                                    });

                                  }catch(e){
                                    loadingAlert('$e', false, false);
                                  }
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
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
        ),
      ),
    );
  }

  void viewFile(name){
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
        initialChildSize: 0.5,
        maxChildSize: 0.5,
        minChildSize: 0.5,
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
                          color: Colors.white,
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
                                      Navigator.pop(context);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.arrow_back, size: 34,),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Center(child: Icon(Icons.file_copy, size: 50,)),
                                  SizedBox(height: 10,),
                                  Center(child: Text(name)),

                                ],
                              ),
                            ),

                          ),
                        )
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 2,
                            color: Colors.black12,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [

                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                                  child: TextFormField(
                                    controller: caption,
                                    decoration: InputDecoration(
                                      hintText: 'Add caption',
                                      enabledBorder:  UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black12,
                                          width: 1,
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

                                  var body = {
                                    'file' : photo
                                  };
                                  try{
                                    var uploadfile = await ChatQiscusRepo().uploadFileChat(body, token, type);
                                    loadingAlert('Mohon tunggu sebentar', null, true);
                                    var res = await ChatQiscusRepo().kirimPesanFile(widget.id == null ? widget.qiscusRoomResponse?.results.room.roomId : widget.id, caption.text, widget.userProfileResponse?.email == null ? widget.chatResponse?.results.comment.user.userId : widget.userProfileResponse?.email, uploadfile.object);
                                    await ChatQiscusRepo().notificationSend(res.results.comment.message, res.results.comment.user.username,
                                        uuidValue, token);

                                    loadpesan = await ChatQiscusRepo().getMessageList(widget.id == null ? widget.qiscusRoomResponse?.results.room.roomId : widget.id);

                                    Navigator.pop(context);
                                    Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                          pageBuilder: (_, __, ___) => ChatPage(room_name: widget.room_name == null? widget.qiscusRoomResponse?.results.room.roomName : widget.room_name, avatar: widget.avatar== null? widget.qiscusRoomResponse?.results.room.roomAvatarUrl : widget.avatar, chatResponse: null, pesan: loadpesan, userProfileResponse: widget.userProfileResponse == null ? userdata : widget.userProfileResponse, id: widget.id == null ? widget.qiscusRoomResponse?.results.room.roomId : widget.id, ),
                                          transitionDuration: Duration(seconds: 0),
                                          reverseTransitionDuration: Duration(seconds: 0)
                                      ),
                                    );
                                  }catch(e){
                                    loadingAlert('$e', false, false);
                                  }
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
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
        ),
      ),
    );
  }

  void SelectedItem(BuildContext context, item) {
    switch (item) {
      case 0:
        view = true;
        break;

    }
  }

  Widget listChat (BuildContext context){

    return FutureBuilder(
        future: ChatQiscusRepo().getMessageList(widget.id == null ? widget.qiscusRoomResponse?.results.room.roomId : widget.id),
        builder: (context, snapshot){

          final loadpesans1 = snapshot.data;
          print(loadpesans1);
          if(snapshot.hasData){
            return CardReceived(chatResponse: widget.chatResponse, pesan: loadpesans1, userProfileResponse: widget.userProfileResponse,);

          }
          return CardReceived(chatResponse: widget.chatResponse, pesan: widget.pesan == null ?  loadpesan : widget.pesan, userProfileResponse: widget.userProfileResponse,);

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
        actions: [

        ],
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
                controller: _scrollController,
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
                            widget.chatResponse != null ?  CardReceived(chatResponse: widget.chatResponse, pesan: widget.pesan == null ?  loadpesan : widget.pesan, userProfileResponse: widget.userProfileResponse,)
                                : listChat(context)
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

                        try{
                          var res = await ChatQiscusRepo().kirimPesan(widget.id == null ? widget.qiscusRoomResponse?.results.room.roomId : widget.id, kirimpesan.text, widget.userProfileResponse?.email == null ? widget.chatResponse?.results.comment.user.userId : widget.userProfileResponse?.email);

                          loadpesan = await ChatQiscusRepo().getMessageList(widget.id == null ? widget.qiscusRoomResponse?.results.room.roomId : widget.id);
                          await ChatQiscusRepo().notificationSend(res.results.comment.message, res.results.comment.user.username,
                              uuidValue, token);

                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (_, __, ___) => ChatPage(room_name: widget.room_name == null? widget.qiscusRoomResponse?.results.room.roomName : widget.room_name, avatar: widget.avatar== null? widget.qiscusRoomResponse?.results.room.roomAvatarUrl : widget.avatar, pesan: loadpesan, userProfileResponse: widget.userProfileResponse == null ? userdata : widget.userProfileResponse, id: widget.id == null ? widget.qiscusRoomResponse?.results.room.roomId : widget.id, ),
                                transitionDuration: Duration(seconds: 0),
                                reverseTransitionDuration: Duration(seconds: 0)
                            ),
                          );
                        }catch(e){

                        }


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
