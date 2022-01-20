import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/modules/profile/page_merchant/add_product_merchant.dart';
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
  bool valueswitchEkspedisi = false;
  bool loading = false;
  bool _loadingButton =false;
  final picker = ImagePicker();
  File? photo;
  String? path;
  var beratApi;
  String diantar ='';
  String kurir ='';
  String textShipment ='';

  getData()async{
    beratApi = await AuthRepository().readSecureData('beratApi');
    setState(() {
      textController.text = beratApi;
    });
  }

  void setisDiantarAdd(bool antar) async{
    SharedPreferences cekAntar = await SharedPreferences.getInstance();
    cekAntar.setBool('diantarAdd', antar);
  }

  void setisDiantar(bool antar) async{
    SharedPreferences cekAntar = await SharedPreferences.getInstance();
    cekAntar.setBool('diantar', antar);
  }

  void valueEkspedisi(bool ekspedisi) async{
    SharedPreferences cekAntar = await SharedPreferences.getInstance();
    cekAntar.setBool('valueEkspedisi', ekspedisi);
  }

  void setisKurirToko(bool antar) async{
    SharedPreferences cekKurirtoko = await SharedPreferences.getInstance();
    cekKurirtoko.setBool('kurirtoko', antar);
  }

  void setisKurirTokoAdd(bool antar) async{
    SharedPreferences cekKurirtoko = await SharedPreferences.getInstance();
    cekKurirtoko.setBool('kurirtokoAdd', antar);
  }

  Future<bool> getcekKurirToko()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('kurirtoko') ?? false;
  }

  Future<bool> getcekAntar()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('diantar') ?? false;
  }

  Future<String> getShipmentValue()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('shipment') ?? '';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    getcekAntar().then((value) {
      valueswitchDiantar = value;

    });
    getcekKurirToko().then((value) {
      valueswitchKurir = value;

    });
    getShipmentValue().then((value) {
      textShipment = value;
      setState(() {
        if (textShipment == null){
          valueswitchEkspedisi = false;
        }else{
          valueswitchEkspedisi = true;
        }
      });


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
                  Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(

                        children: [
                          Image.asset('assets/icon/ic_kurir_toko.png', width: 20,),
                          SizedBox(width: 10,),
                          Row(
                            children: [
                              Text('Ekspedisi', style: FlutterFlowTheme.bodyText1,),
                              SizedBox(width: 10,),
                              Text('$textShipment', style: FlutterFlowTheme.bodyText1.copyWith(fontSize: 12, color: Colors.red),)
                            ],
                          ),
                        ],
                      ),
                      Switch(
                          value: valueswitchEkspedisi,
                          onChanged: (v){
                            setState(() {
                              valueswitchEkspedisi = v;

                            });

                          }
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 30, 16, 16),
            child: FFButtonWidget(
              onPressed: () async{
                valueEkspedisi(valueswitchEkspedisi);
                await AuthRepository().writeSecureData('beratbarang', textController.text);
                setisDiantarAdd(valueswitchDiantar);
                setisKurirTokoAdd(valueswitchKurir);
                Navigator.pop(context);

              },
              text: 'Simpan',
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
                borderRadius: 12,
              ),
              loading: _loadingButton,
            ),
          )
        ],
      ),
    );
  }
}
