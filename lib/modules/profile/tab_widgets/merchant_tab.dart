import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/data/response/merchant/merchant_profile_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MerchantTab extends StatefulWidget {
  final Object? dataMerchant;
  final Function(File photo)? onFotoChangedMerchant;
  const MerchantTab({Key? key, required this.dataMerchant, this.onFotoChangedMerchant }) : super(key: key);

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
  double slidervalue = 1;
  String rangeSlide ='1';

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
    widget.dataMerchant == null ? loading = true :loading = false;
    getcekAntar().then((value) {
      valueswitchDiantar = value;
    });
    getcekKurirToko().then((value) {
      valueswitchKurir = value;
    });
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
                      ' Toko Gellaps',
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
                        'Ekspedisi',
                        style: FlutterFlowTheme.bodyText1
                            .override(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    Text(
                      ' Toko Gellaps',
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
                actions: [
                  TextButton(
                      child: Text('CANCEL'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  TextButton(
                      child: Text('SIMPAN'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      })
                ],
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
                          "Metode Gratis Ongkir :", style: FlutterFlowTheme.bodyText1.copyWith(fontWeight: FontWeight.w600),
                        ),
                        Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(

                              children: [
                                Icon(Icons.all_inbox),
                                SizedBox(width: 10,),
                                Text('Diantar Mogawers'),
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
                                Icon(Icons.all_inbox),
                                SizedBox(width: 10,),
                                Text('Kurir Toko'),
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
                        SizedBox(height: 10,),
                        Text('Radius Pengiriman :'),
                        Slider(
                          value: slidervalue,
                          onChanged: (value) {
                            stateSetter(() {
                              slidervalue = value;
                              rangeSlide = slidervalue.toString();
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
              );
            }));
  }

}
