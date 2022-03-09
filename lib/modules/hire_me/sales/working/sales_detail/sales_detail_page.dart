import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:intl/intl.dart';
import 'package:mogawe/core/data/response/hire_me/sales_detail_response.dart';
import 'package:mogawe/core/data/response/qiscus/chat_message_list_response.dart';
import 'package:mogawe/core/data/response/qiscus/chat_room_list_response.dart';
import 'package:mogawe/core/data/response/qiscus/get_uuid_user.dart';
import 'package:mogawe/core/data/response/qiscus/participants_response.dart';
import 'package:mogawe/core/data/response/qiscus/unread_response.dart';
import 'package:mogawe/core/data/response/user_profile_response.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_icon_button.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/core/repositories/chat_qiscus_repositories.dart';
import 'package:mogawe/modules/hire_me/sales/working/sales_shipment/sales_shipment_page.dart';
import 'package:mogawe/modules/inbox_notif/inbox/chat/chat_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';

class SalesDetailPage extends StatefulWidget {
  String uuid;
  SalesDetailPage({required this.uuid});

  @override
  _SalesDetailPageState createState() => _SalesDetailPageState();
}

class _SalesDetailPageState extends State<SalesDetailPage> {
  bool _loadingButton1 = false;
  bool _loadingButton2 = false;
  bool _loadingButton3 = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  SalesDetailResponses? salesDetailResponses;
  UserProfileResponse? userProfileResponse;
  bool loading =false;
  var token;
  var price, komisi;
  String _message = "";
  String _path = "";
  String _size = "";
  String _mimeType = "";
  File? _imageFile;
  int _progress = 0;
  var image;
  ParticipantsModel? participantsModel;
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

  Future getData()async{
    setState(() {
      loading = true;

    });

    token = await AuthRepository().readSecureData('token');
    userProfileResponse = await AuthRepository().getProfile(token);
    salesDetailResponses = await AuthRepository().getDetailsales(token, widget.uuid);
    var currencyFormatter = NumberFormat.currency(locale: 'ID');
    price = currencyFormatter.format(salesDetailResponses?.price);
    komisi = currencyFormatter.format(salesDetailResponses?.commission);
    setState(() {
      loading = false;
    });
  }

  Future<void> _downloadImage(
      String url, {
        AndroidDestinationType? destination,
        bool whenError = false,
        String? outputMimeType,
      }) async {
    String? fileName;
    String? path;
    int? size;
    String? mimeType;
    try {
      String? imageId;

      if (whenError) {
        imageId = await ImageDownloader.downloadImage(url,
            outputMimeType: outputMimeType)
            .catchError((error) {
          if (error is PlatformException) {
            String? path = "";
            if (error.code == "404") {
              print("Not Found Error.");
            } else if (error.code == "unsupported_file") {
              print("UnSupported FIle Error.");
              path = error.details["unsupported_file_path"];
            }
            setState(() {
              _message = error.toString();
              _path = path ?? '';
            });
          }

          print(error);
        }).timeout(Duration(seconds: 10), onTimeout: () {
          print("timeout");
          return;
        });
      } else {
        if (destination == null) {
          imageId = await ImageDownloader.downloadImage(
            url,
            outputMimeType: outputMimeType,
          );
        } else {
          imageId = await ImageDownloader.downloadImage(
            url,
            destination: destination,
            outputMimeType: outputMimeType,
          );
        }
      }

      if (imageId == null) {
        return;
      }
      fileName = await ImageDownloader.findName(imageId);
      path = await ImageDownloader.findPath(imageId);
      size = await ImageDownloader.findByteSize(imageId);
      mimeType = await ImageDownloader.findMimeType(imageId);
      Fluttertoast.showToast(
          msg: "Image Saved",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0
      );
    } on PlatformException catch (error) {
      setState(() {
        _message = error.message ?? '';
      });
      return;
    }

    if (!mounted) return;

    setState(() {
      var location = Platform.isAndroid ? "Directory" : "Photo Library";
      _message = 'Saved as "$fileName" in $location.\n';
      _size = 'size:     $size';
      _mimeType = 'mimeType: $mimeType';
      _path = path ?? '';

      if (!_mimeType.contains("video")) {
        _imageFile = File(path!);
      }
      return;
    });
  }

  goToChat()async{
    try{
      loadingAlert('Mohon tunggu sebentar', null, true);
      var res = await ChatQiscusRepo().createRoom(salesDetailResponses?.name, userProfileResponse?.email, salesDetailResponses?.images[0].value);
      participantsModel = await ChatQiscusRepo().getParticipants(res.results.room.roomId);
      for(var i= 0; i< participantsModel!.results.participants.length; i++){
        if(participantsModel!.results.participants[i].userId != userProfileResponse?.email){
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
      var chat = await ChatQiscusRepo().kirimPesan(res.results.room.roomId, 'Halo admin, saya ingin bertanya tentang barang ${salesDetailResponses?.name} dong!', userProfileResponse?.email);
      await ChatQiscusRepo().notificationSend(chat.results.comment.message, chat.results.comment.user.username,
          uuidValue, token);
      var load = await ChatQiscusRepo().getMessageList(res.results.room.roomId);
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatPage( qiscusRoomResponse: res, pesan: load, userProfileResponse: userProfileResponse,),
        ),
      );
    }catch(e){

    }


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ImageDownloader.callback(onProgressUpdate: (String? imageId, int progress) {
      setState(() {
        _progress = progress;
      });
    });
    getData();
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
          'Informasi Produk',
          style: FlutterFlowTheme.subtitle1.override(
            fontFamily: 'Poppins',
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
            child: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30,
              borderWidth: 1,
              buttonSize: 48,
              icon: Icon(
                Icons.chat_rounded,
                color: FlutterFlowTheme.primaryColor,
                size: 24,
              ),
              onPressed: () async {
                goToChat();
              },
            ),
          )
        ],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: FlutterFlowTheme.secondaryColor,
      body: SafeArea(
        child: ListView(

          children: [
            loading? Container(
              width: MediaQuery.of(context).size.width,
              height: 240,
              child: Shimmer.fromColors(
                baseColor: Color(0xffD8D8D8),
                highlightColor: Color(0xffEDEDED),
                enabled: true,
                child: Container(
                  color: Colors.white,
                  width: 100,
                  height: 10,),
              ),
            ) :  Container(
              width: MediaQuery.of(context).size.width,
              height: 240,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: salesDetailResponses?.images.length,
                  itemBuilder: (context, snap){
                    final listImage = salesDetailResponses?.images[snap];
                    image = salesDetailResponses?.images[0].value;

                    return Row(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional(1, 1),
                          children: [
                            Image.network(
                              '${listImage?.value}',
                              width: MediaQuery.of(context).size.width,
                              height: 240,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 10, 16, 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.54,
                                height: 240,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: salesDetailResponses?.images.length,
                                  itemBuilder: (context, snaps){
                                    return Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        width: 8.0,
                                        height: 8.0,
                                        margin: EdgeInsets.symmetric(
                                            vertical: 5.0, horizontal: 2.0),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: snap == snaps
                                                ? Colors.white
                                                : Colors.black26
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 16),
                              child: FFButtonWidget(
                                onPressed: () {
                                  Fluttertoast.showToast(
                                      msg: "Saving Image...",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                  _downloadImage(listImage?.value as String);
                                },
                                text: 'Download',
                                icon: Icon(
                                  Icons.download_sharp,
                                  size: 15,
                                ),
                                options: FFButtonOptions(
                                  width: 148,
                                  height: 40,
                                  color: FlutterFlowTheme.secondaryColor,
                                  textStyle: FlutterFlowTheme.subtitle2.override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.tertiaryColor,
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: 12,
                                ),
                                loading: _loadingButton1,
                              ),
                            ),


                          ],
                        ),
                        SizedBox(width: 10,)
                      ],
                    );
                  }),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: loading? Shimmer.fromColors(
                              baseColor: Color(0xffD8D8D8),
                              highlightColor: Color(0xffEDEDED),
                              enabled: true,
                              child: Container(
                                color: Colors.white,
                                width: 100,
                                height: 10,),
                            ) : Text(
                              '${salesDetailResponses?.name}',
                              style: FlutterFlowTheme.title3.override(
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          FFButtonWidget(
                            onPressed: () async{
                              print('Button pressed ...');
                              final url = Uri.parse('$image');
                              final res = await http.get(url);
                              final bytes = res.bodyBytes;
                              final temp = await getTemporaryDirectory();
                              final path = '${temp.path}/image.jpg';
                              File(path).writeAsBytesSync(bytes);
                              await Share.shareFiles([path],text: 'Mau Beli paket ${salesDetailResponses?.name} seharga Rp${price.replaceAll('IDR', '').replaceAll(',00', '')} ?\n\nDM ke saya aja ya!' );
                            },
                            text: 'Share',
                            icon: Icon(
                              Icons.share_sharp,
                              size: 16,
                            ),
                            options: FFButtonOptions(
                              width: 130,
                              height: 40,
                              color: FlutterFlowTheme.secondaryColor,
                              textStyle: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Poppins',
                                color: FlutterFlowTheme.primaryColor,
                                fontSize: 12,
                              ),
                              elevation: 0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: 12,
                            ),
                            loading: _loadingButton2,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Terjual',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              Text(
                                '28',
                                style: FlutterFlowTheme.subtitle1.override(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Kamu Menjual',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                Text(
                                  '1',
                                  style: FlutterFlowTheme.subtitle1.override(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Harga rekomendasi',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                            ),
                          ),
                          loading? Shimmer.fromColors(
                            baseColor: Color(0xffD8D8D8),
                            highlightColor: Color(0xffEDEDED),
                            enabled: true,
                            child: Container(
                              color: Colors.white,
                              width: 100,
                              height: 10,),
                          ) : Text(
                            'Rp${price.replaceAll('IDR', '').replaceAll(',00', '')}',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Komisi Penjualan',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.moGaweGreen,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          loading? Shimmer.fromColors(
                            baseColor: Color(0xffD8D8D8),
                            highlightColor: Color(0xffEDEDED),
                            enabled: true,
                            child: Container(
                              color: Colors.white,
                              width: 100,
                              height: 10,),
                          ) : Text(
                            'Rp${komisi.replaceAll('IDR', '').replaceAll(',00', '')}',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.moGaweGreen,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Informasi Produk',
                            style: FlutterFlowTheme.subtitle1.override(
                              fontFamily: 'Poppins',
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: loading? Shimmer.fromColors(
                            baseColor: Color(0xffD8D8D8),
                            highlightColor: Color(0xffEDEDED),
                            enabled: true,
                            child: Container(
                              color: Colors.white,
                              width: 100,
                              height: 10,),
                          ) : Text(
                            '${salesDetailResponses?.desc}',
                            style: FlutterFlowTheme.bodyText2.override(
                              fontFamily: 'Poppins',
                              color: Color(0xFF9F9F9F),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.15,),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 5),
              child: FFButtonWidget(
                onPressed: () {
                  AuthRepository().deleteSecureData('alamat');
                  AuthRepository().deleteSecureData('detail');
                  AuthRepository().deleteSecureData('lat');
                  AuthRepository().deleteSecureData('long');
                  AuthRepository().deleteSecureData('nameEkspedisi');
                  AuthRepository().deleteSecureData('serviceEkspedisi');
                  AuthRepository().deleteSecureData('checkbox3');
                  AuthRepository().deleteSecureData('value');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SalesShipmentPage(uuid: widget.uuid,),
                    ),
                  );
                },
                text: 'Checkout',
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 56,
                  color: FlutterFlowTheme.primaryColor,
                  textStyle: FlutterFlowTheme.subtitle1.override(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 18
                  ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: 12,
                ),
                loading: _loadingButton3,
              ),
            )
          ],
        ),
      ),
    );
  }
}
