import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AturPengiriman extends StatefulWidget {
  const AturPengiriman({Key? key}) : super(key: key);

  @override
  _AturPengirimanState createState() => _AturPengirimanState();
}

class _AturPengirimanState extends State<AturPengiriman> {

  TextEditingController textController = new TextEditingController();
  bool valueswitchDiantar = false;
  bool valueswitchKurir = false;
  bool loading = false;
  final picker = ImagePicker();
  File? photo;
  String? path;
  String diantar ='';
  String kurir ='';

  Future getImageGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      photo = File(pickedFile.path);
      path = photo?.path.split('/').last;
      //widget.onFotoChangedMerchant!(photo!);
    } else {
      Fluttertoast.showToast(msg: "Tidak ada foto yang dipilih");
    }
  }

  Future getImageCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      photo = File(pickedFile.path);
      path = photo!.path.split('/').last;
    //  widget.onFotoChangedMerchant!(photo!);
    } else {
      Fluttertoast.showToast(msg: "Tidak ada foto yang dipilih");
    }
  }

  void setisDiantar(bool antar) async{
    SharedPreferences cekAntar = await SharedPreferences.getInstance();
    cekAntar.setBool('diantar', antar);
  }

  void setisKurirToko(bool antar) async{
    SharedPreferences cekKurirtoko = await SharedPreferences.getInstance();
    cekKurirtoko.setBool('kurirtoko', antar);
  }

  Future<bool> getcekKurirToko()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('kurirtoko') ?? false;
  }

  Future<bool> getcekAntar()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('diantar') ?? false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcekAntar().then((value) {
      valueswitchDiantar = value;
      if(valueswitchDiantar == true) {
        diantar = 'Diantar Mogawers';
      }
      else{
        diantar = '';
      }
    });
    getcekKurirToko().then((value) {
      valueswitchKurir = value;
      if(valueswitchKurir == true){
        kurir = 'Kurir Toko,';
      }
      else{
        kurir = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.secondaryColor,
        iconTheme: IconThemeData(color: FlutterFlowTheme.tertiaryColor),
        automaticallyImplyLeading: true,
        title: Text(
          'Pengiriman',
          style: FlutterFlowTheme.subtitle1.override(
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: ListView(
        children: [
          SizedBox(height: 10,),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.work),
                      SizedBox(width: 10,),
                      Text('Berat *'),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width:100,
                        child: TextFormField(
                          controller: textController,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Atur Berat',
                            hintStyle: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins', color: Colors.black38
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 0,
                              ),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(0),
                            ),

                          ),
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                          ),
                          onChanged: (s)async{
                            setState(() {

                            });

                            setState(() {

                            });
                          },
                        ),
                      ),
                      Text('gr')
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Metode Gratis Ongkir :", style: FlutterFlowTheme.bodyText1.copyWith(fontWeight: FontWeight.w600,
                      fontSize: 16),
                  ),
                  Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(

                        children: [
                          Image.asset('assets/icon/ic_ambil_sendiri.png', width: 20,),
                          SizedBox(width: 10,),
                          Text('Diantar Mogawers', style: FlutterFlowTheme.bodyText1,),
                        ],
                      ),
                      Switch(
                          value: valueswitchDiantar,
                          onChanged: (v){
                            setState(() {
                              valueswitchDiantar = v;

                            });

                          }
                      ),
                    ],
                  ),
                  Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(

                        children: [
                          Image.asset('assets/icon/ic_kurir_toko.png', width: 20,),
                          SizedBox(width: 10,),
                          Text('Kurir Toko', style: FlutterFlowTheme.bodyText1,),
                        ],
                      ),
                      Switch(
                          value: valueswitchKurir,
                          onChanged: (v){
                            setState(() {
                              valueswitchKurir = v;

                            });

                          }
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
