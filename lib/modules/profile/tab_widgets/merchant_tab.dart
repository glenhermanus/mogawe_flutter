import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mogawe/core/data/response/merchant/shipment_courier.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/data/response/merchant/merchant_profile_response.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/core/repositories/profile_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MerchantTab extends StatefulWidget {
  final Object? dataMerchant;
  final List<ObjectShipment>? objectShipment;
  final Function(Map<String, String> map)? updateShipmet;
  final Function(File photo)? onFotoChangedMerchant;
  final Function(int selfPick)? parseRadius;
  const MerchantTab({Key? key, required this.dataMerchant, this.objectShipment, this.updateShipmet, this.onFotoChangedMerchant, this.parseRadius }) : super(key: key);

  @override
  State<MerchantTab> createState() => _MerchantTabState();
}

class _MerchantTabState extends State<MerchantTab> {

  bool loading = false;
  final picker = ImagePicker();
  File? photo;
  String? path;
  bool valueswitchDiantar = false;
  bool valueswitchKurir = false;
  bool valuesShipment = false;
  double slidervalue = 1;
  double valueAwal=1;
  String rangeSlide ='1';
  int totalvalueAwal=1;
  int valueSlideAwal =1;
  double convertSlide = 1;
  int parseInt = 1;
  String valueOngkir='';
  String diantar ='';
  String kurir ='';
  List selectShipment = [];
  List selectShipmentBool = [];
  List selectShipmentName = [];
  String textShipment ='';
  Map<String, String> map = Map();

  Future getImageGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      photo = File(pickedFile.path);
      path = photo?.path.split('/').last;
      widget.onFotoChangedMerchant!(photo!);
    } else {
      Fluttertoast.showToast(msg: "Tidak ada foto yang dipilih");
    }
  }

  Future getImageCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      photo = File(pickedFile.path);
      path = photo!.path.split('/').last;
      widget.onFotoChangedMerchant!(photo!);
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

  void setShipment(shipment) async{
    SharedPreferences shipmentValue = await SharedPreferences.getInstance();
    shipmentValue.setString('shipment', shipment);
  }

  void setShipmentBool(shipment) async{
    SharedPreferences shipmentValue = await SharedPreferences.getInstance();
    shipmentValue.setBool('shipmentBool', shipment);
  }

  Future<bool> getShipmentValueBool()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('shipmentBool') ?? false;
  }

  Future<String> getShipmentValue()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('shipment') ?? '';
  }

  Future<bool> getcekKurirToko()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('kurirtoko') ?? false;
  }

  Future<bool> getcekAntar()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('diantar') ?? false;
  }

  void shipmentSelected(bool selected, code) {
    if (selected == true) {
      setState(() {
        selectShipment.add(code);
      });
    } else {
      setState(() {
        selectShipment.remove(code);
      });
    }
  }

  void shipmentSelectedBool(bool selected, code) {
    if (selected == true) {
      setState(() {
        selectShipmentBool.add(selected);
      });
    } else {
      setState(() {
        selectShipmentBool.remove(selected);
      });
    }
  }

  void getShipmentName(bool selected, name) {
    if (selected == true) {
      setState(() {
        selectShipmentName.add(name);
      });
    } else {
      setState(() {
        selectShipmentName.remove(name);
      });
    }
  }

  void cekValue(){
    var codeValue;

    for(var i =0; i < widget.objectShipment!.length!; i++){
      valuesShipment = selectShipment.contains(widget.objectShipment?[i].code);
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.dataMerchant == null ? loading = true :loading = false;
    widget.dataMerchant?.selfPickupRadius != null ? valueSlideAwal = widget.dataMerchant?.selfPickupRadius as int
        : 0;
    valueAwal = valueSlideAwal / 1000;
    totalvalueAwal = (valueSlideAwal / 1000).round();
    rangeSlide = totalvalueAwal.toString();
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
    getShipmentValue().then((value) {
      textShipment = value;

    });
    // cekValue();
  }


  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(
              16, 24, 16, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Informasi Toko',
                style:
                FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  color: FlutterFlowTheme.primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    0, 16, 0, 16),
                child: InkWell(
                    onTap: (){chooseImage();},
                    child: Center(child: widget.dataMerchant == null? Container(): Image.network(
                      widget.dataMerchant?.storePicture ?? "https://sbu.co.id/info/wp-content/themes/easymag/images/no-image.png",
                      height: 120,
                    ),)),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    0, 16, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        'Nama Toko',
                        style: FlutterFlowTheme.bodyText1
                            .override(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    Text(
                      widget.dataMerchant != null? ' ${widget.dataMerchant!.storeName}': "",
                      style: FlutterFlowTheme.bodyText1
                          .override(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.black,
                      size: 24,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    0, 16, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        'Alamat Pickup',
                        style: FlutterFlowTheme.bodyText1
                            .override(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        widget.dataMerchant != null? ' ${widget.dataMerchant!.storeAddress}': "",
                        style: FlutterFlowTheme.bodyText1
                            .override(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.right,
                        maxLines: 5,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.black,
                      size: 24,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    0, 24, 0, 16),
                child: Text(
                  'Metode Pengiriman',
                  style:
                  FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Poppins',
                    color: FlutterFlowTheme.primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  openAlertBox();
                },
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text('Gratis Ongkir',
                        style: FlutterFlowTheme.bodyText1
                            .override(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    Text(
                      '$kurir $diantar',
                      style: FlutterFlowTheme.bodyText1
                          .override(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.black,
                      size: 24,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    0, 16, 0, 0),
                child: InkWell(
                  onTap: (){
                    openAlertBoxShipment();
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          'Ekspedisi',
                          style: FlutterFlowTheme.bodyText1
                              .override(
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      Text(
                        '$textShipment',
                        style: FlutterFlowTheme.bodyText1
                            .override(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.black,
                        size: 24,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(
              16, 24, 16, 0),
          child: Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Produk',
                      style: FlutterFlowTheme.bodyText1
                          .override(
                        fontFamily: 'Poppins',
                        color:
                        FlutterFlowTheme.primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Semua Produk',
                      style: FlutterFlowTheme.bodyText1
                          .override(
                        fontFamily: 'Poppins',
                        color:
                        FlutterFlowTheme.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        // Expanded(
        //   child: Padding(
        //     padding: EdgeInsetsDirectional.fromSTEB(
        //         16, 16, 16, 0),
        //     child: GridView(
        //       padding: EdgeInsets.zero,
        //       gridDelegate:
        //       SliverGridDelegateWithFixedCrossAxisCount(
        //         crossAxisCount: 2,
        //         crossAxisSpacing: 10,
        //         mainAxisSpacing: 10,
        //         childAspectRatio: 1,
        //       ),
        //       scrollDirection: Axis.vertical,
        //       children: [
        //         Card(
        //           clipBehavior:
        //           Clip.antiAliasWithSaveLayer,
        //           color: Color(0xFFF5F5F5),
        //           shape: RoundedRectangleBorder(
        //             borderRadius:
        //             BorderRadius.circular(16),
        //           ),
        //           child: Column(
        //             mainAxisSize: MainAxisSize.max,
        //             children: [
        //               Stack(
        //                 alignment:
        //                 AlignmentDirectional(0, 1),
        //                 children: [
        //                   Image.network(
        //                     'https://picsum.photos/seed/624/600',
        //                     width: double.infinity,
        //                     height: 100,
        //                     fit: BoxFit.cover,
        //                   ),
        //                 ],
        //               ),
        //               Padding(
        //                 padding: EdgeInsetsDirectional
        //                     .fromSTEB(8, 8, 8, 0),
        //                 child: Column(
        //                   mainAxisSize: MainAxisSize.max,
        //                   crossAxisAlignment:
        //                   CrossAxisAlignment.start,
        //                   children: [
        //                     Text(
        //                       'Baju Batik Oke',
        //                       style: FlutterFlowTheme
        //                           .bodyText1
        //                           .override(
        //                         fontFamily: 'Poppins',
        //                         fontSize: 12,
        //                       ),
        //                     ),
        //                     Padding(
        //                       padding:
        //                       EdgeInsetsDirectional
        //                           .fromSTEB(
        //                           0, 4, 0, 0),
        //                       child: Row(
        //                         mainAxisSize:
        //                         MainAxisSize.max,
        //                         mainAxisAlignment:
        //                         MainAxisAlignment
        //                             .spaceBetween,
        //                         children: [
        //                           Text(
        //                             'Rp100.000',
        //                             style:
        //                             FlutterFlowTheme
        //                                 .bodyText1
        //                                 .override(
        //                               fontFamily:
        //                               'Poppins',
        //                               fontSize: 11,
        //                             ),
        //                           ),
        //                           Text(
        //                             'Rp10.000',
        //                             style:
        //                             FlutterFlowTheme
        //                                 .bodyText1
        //                                 .override(
        //                               fontFamily:
        //                               'Poppins',
        //                               fontSize: 11,
        //                             ),
        //                           )
        //                         ],
        //                       ),
        //                     )
        //                   ],
        //                 ),
        //               )
        //             ],
        //           ),
        //         ),
        //         Card(
        //           clipBehavior:
        //           Clip.antiAliasWithSaveLayer,
        //           color: Color(0xFFF5F5F5),
        //           shape: RoundedRectangleBorder(
        //             borderRadius:
        //             BorderRadius.circular(16),
        //           ),
        //           child: Column(
        //             mainAxisSize: MainAxisSize.max,
        //             children: [
        //               Stack(
        //                 alignment:
        //                 AlignmentDirectional(0, 1),
        //                 children: [
        //                   Image.network(
        //                     'https://picsum.photos/seed/624/600',
        //                     width: double.infinity,
        //                     height: 100,
        //                     fit: BoxFit.cover,
        //                   ),
        //
        //                 ],
        //               ),
        //               Padding(
        //                 padding: EdgeInsetsDirectional
        //                     .fromSTEB(8, 8, 8, 0),
        //                 child: Column(
        //                   mainAxisSize: MainAxisSize.max,
        //                   crossAxisAlignment:
        //                   CrossAxisAlignment.start,
        //                   children: [
        //                     Text(
        //                       'Baju Batik Oke',
        //                       style: FlutterFlowTheme
        //                           .bodyText1
        //                           .override(
        //                         fontFamily: 'Poppins',
        //                         fontSize: 12,
        //                       ),
        //                     ),
        //                     Padding(
        //                       padding:
        //                       EdgeInsetsDirectional
        //                           .fromSTEB(
        //                           0, 4, 0, 0),
        //                       child: Row(
        //                         mainAxisSize:
        //                         MainAxisSize.max,
        //                         mainAxisAlignment:
        //                         MainAxisAlignment
        //                             .spaceBetween,
        //                         children: [
        //                           Text(
        //                             'Rp100.000',
        //                             style:
        //                             FlutterFlowTheme
        //                                 .bodyText1
        //                                 .override(
        //                               fontFamily:
        //                               'Poppins',
        //                               fontSize: 11,
        //                             ),
        //                           ),
        //                           Text(
        //                             'Rp10.000',
        //                             style:
        //                             FlutterFlowTheme
        //                                 .bodyText1
        //                                 .override(
        //                               fontFamily:
        //                               'Poppins',
        //                               fontSize: 11,
        //                             ),
        //                           )
        //                         ],
        //                       ),
        //                     )
        //                   ],
        //                 ),
        //               )
        //             ],
        //           ),
        //         ),
        //
        //       ],
        //     ),
        //   ),
        // )
      ],
    );
  }

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

  openAlertBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) => StatefulBuilder(
            builder: (BuildContext context, StateSetter stateSetter) {
              return AlertDialog(
                contentPadding: EdgeInsets.only(top: 0.0, bottom: 0.0),

                content: Container(
                  height: MediaQuery.of(context).size.height * 0.32,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
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
                                  stateSetter(() {
                                    valueswitchDiantar = v;
                                    setisDiantar(v);
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
                                  stateSetter(() {
                                    valueswitchKurir = v;
                                    setisKurirToko(v);
                                  });

                                }
                            ),
                          ],
                        ),
                        SizedBox(height: 16,),
                        Text('Radius Pengiriman :'),
                        Slider(
                          value: valueAwal,
                          onChanged: (value) {
                            stateSetter(() {
                              valueAwal = value;
                              rangeSlide =  valueAwal.round().toString();
                              parseInt = int.parse(rangeSlide) * 1000;
                            });
                          },
                          max: 150,
                          min: 1,
                          divisions: 150,
                        ),
                        Text('${rangeSlide.split('.').first}km'),

                      ],
                    ),
                  ),
                ),
                actions: [
                TextButton(
                    child: Text('CANCEL'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                TextButton(
                    child: Text('SIMPAN'),
                    onPressed: () {
                      widget.parseRadius!(parseInt);
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
                      // var token = await AuthRepository().readSecureData('token');
                      // await ProfileRepository().updateselPickup(realToken: token.toString(), radius: parseInt );
                    })
              ],
              );
            }));
  }

  openAlertBoxShipment() {
    return showDialog(
        context: context,
        builder: (BuildContext context) => StatefulBuilder(
            builder: (BuildContext context, StateSetter stateSetter) {
              return AlertDialog(
                contentPadding: EdgeInsets.only(top: 0.0, bottom: 0.0),

                content: Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          "Pilih Jasa Ekspedisi :", style: FlutterFlowTheme.bodyText1.copyWith(fontWeight: FontWeight.w600,
                            fontSize: 16),
                        ),
                         Expanded(
                           child: Container(
                             width: 300,
                             height:  MediaQuery.of(context).size.height * 0.6,
                             child: ListView.builder(
                                 itemCount: widget.objectShipment?.length,
                                 itemBuilder: (context, snap){
                                   final listValue = widget.objectShipment?[snap];
                                   valuesShipment = selectShipment.contains(listValue?.code);
                               return Container(
                                 width: 300,
                                 child: CheckboxListTile(
                                     value: valuesShipment,
                                   onChanged: (selected) {
                                       stateSetter(() {
                                         shipmentSelectedBool(selected!,
                                             listValue?.code);
                                         shipmentSelected(selected!,
                                             listValue?.code);
                                         getShipmentName(selected!,
                                             listValue?.name);
                                       });

                                   },
                                   title: Text('${listValue?.name}'),
                                 ),
                               );
                             }),
                           ),
                         )
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                      child: Text('CANCEL'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  TextButton(
                      child: Text('SIMPAN'),
                      onPressed: () {
                        String convertValue = selectShipment.toString();
                        String convertValueName = selectShipmentName.toString();
                        String convertnonfinal = convertValueName.replaceAll('[', '').replaceAll(']', '');
                        String convertValueFinal = convertValue.replaceAll('[', '').replaceAll(']', '').replaceAll(', ', ':');
                        print(convertValueFinal);
                        setShipmentBool(selectShipment.contains(convertValue));
                        setShipment(convertnonfinal);
                        getShipmentValue().then((value) {
                          textShipment = value;

                        });
                        // getShipmentValueBool().then((value) {
                        //   selectShipment = value;
                        //   print('ini isi');
                        //   print(selectShipment);
                        //
                        // });
                        var field = "shippingExpeditionServices";

                        map.clear();
                          if (field == "shippingExpeditionServices") {
                          map["shippingExpeditionServices"] = convertValueFinal;
                          widget.updateShipmet!(map);
                        }
                        // var token = await AuthRepository().readSecureData('token');
                        // await ProfileRepository().updateselPickup(realToken: token.toString(), radius: parseInt );
                      })
                ],
              );
            }));
  }

}
