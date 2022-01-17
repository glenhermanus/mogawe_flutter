import 'package:mogawe/core/data/response/notification/notification_response.dart';
import 'package:mogawe/core/data/sources/network/user_network_service.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/modules/inbox_notif/notification/notification_card.dart';

class NotificationListPage extends StatefulWidget {
  NotificationListPage({Key? key}) : super(key: key);

  @override
  _NotificationListPageState createState() =>
      _NotificationListPageState();
}

class _NotificationListPageState extends State<NotificationListPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  var token;
  NotificationResponse? notificationResponse;
  bool loading = false;

  getData()async{
    setState(() {
      loading = true;
    });
    token = await AuthRepository().readSecureData('token');


    print("OUT >> hey");
    print(token);

    notificationResponse = await UserNetworkService().getListNotification(token);

    setState(() {
      loading = false;

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
          'Notifikasi',
          style: FlutterFlowTheme.subtitle1.override(
            fontFamily: 'Poppins',
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 8,),
              loading? Align(
                  alignment: Alignment.topCenter,
                  child: CircularProgressIndicator()) : CardNotification(notificationResponse: notificationResponse,)
            ],
          ),
        ),
      ),
    );
  }
}
