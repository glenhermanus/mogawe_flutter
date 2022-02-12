import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mogawe/core/data/response/profile/profile_response.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:convert' as codex;


class IdCardProfile extends StatefulWidget {

  final ObjectData? data;

  const IdCardProfile({Key? key, this.data}) : super(key: key);

  @override
  _IdCardProfileState createState() => _IdCardProfileState();
}

class _IdCardProfileState extends State<IdCardProfile> {

  String mogawe = "MoGawe (Your Data Your Control";
  String address = "Jl. M Kavling No.8, Kebon Baru, Tebet, Jakarta Timur";
  bool loading = false;
  var _token;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getToken();
    widget.data == null ? loading = true :loading = false;
  }

  Future<void> _getToken() async {
    if(mounted){
      _token = await AuthRepository().readSecureData('token');
      setState(() {
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SCAN ME!", style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 16
        )),
        centerTitle: true,
        backgroundColor: FlutterFlowTheme.primaryColor,
        toolbarHeight: 48,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 24,
                    width: double.infinity,
                    color: Color(0xffBBBDBB),
                    child: Center(
                      child: Text("Data Collector", style: TextStyle(
                       color: Colors.white,
                        fontWeight: FontWeight.w600
                      )),
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: widget.data?.profilePicture == null ? Image.asset('assets/images/im_ambar_good_bgwhite.jpg').image : NetworkImage(widget.data?.profilePicture ?? ""),
                      radius: 48,
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: Text(widget.data!.fullName!, style: TextStyle(
                      fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600
                    )),
                  ),
                  SizedBox(height: 32),
                  Center(
                    child: QrImage(
                      data: _generateQRCode(),
                      size: 250,
                      version: QrVersions.auto,
                    ),
                  )
                ],
              ),
            ),
          ),
          Column(
            children: [
              Container(
                height: 12,
                width: double.infinity,
                color: FlutterFlowTheme.primaryColor,
                child: Center(
                  child: Text(
                    "https://mogawe.com/",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset("assets/images/img.png", height: 48),
                SizedBox(width: 16),
                Column(children: [
                  Text(mogawe, style: TextStyle(
                      color: Color(0xff999999),
                      fontWeight: FontWeight.w700,
                    fontSize: 12
                  )),
                  SizedBox(height: 4),
                  Text(address, style: TextStyle(
                      color: Color(0xff999999),
                      fontWeight: FontWeight.w600,
                      fontSize: 10
                  )),
                ])
              ]),
              SizedBox(height: 16)
            ],
          )
        ],
      ),
    );
  }

  Widget rowItem(String title, Widget child) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            child
          ],
        ),
        SizedBox(height: 12)
      ],
    );
  }

  String _generateQRCode(){
    codex.Codec<String, String> stringToBase64 = codex.utf8.fuse(codex.base64);
    String encodedToken = stringToBase64.encode(_token);
    String salt = "eymgw" + encodedToken + "prfdtl";
    String saltedToken = stringToBase64.encode(salt);

    String url = "https://bisnis.mogawe.com/personal-data?" + saltedToken;
    String qrCode = url.replaceAll("\n", "").replaceAll("\r", "");
    return qrCode;
  }
}
