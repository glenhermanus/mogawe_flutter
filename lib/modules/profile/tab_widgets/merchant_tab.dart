import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mogawe/core/data/response/merchant/merchant_profile_response.dart';
import 'package:intl/intl.dart';
import 'package:mogawe/core/data/response/merchant/shipment_courier.dart';
import 'package:mogawe/core/data/response/merchant/supplier_product.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/data/response/merchant/merchant_profile_response.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/core/repositories/profile_repository.dart';
import 'package:mogawe/modules/profile/page_merchant/add_product_merchant.dart';
import 'package:mogawe/modules/profile/page_merchant/edit_product_merchant.dart';
import 'package:mogawe/modules/profile/page_merchant/mulai_jualan.dart';
import 'package:mogawe/modules/profile/page_merchant/product_merchant.dart';
import 'package:mogawe/modules/profile/screens/address_pickup_screen.dart';
import 'package:mogawe/modules/profile/screens/mulai_jualan_screen.dart';
import 'package:mogawe/utils/ui/animation/bounce_tap.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MerchantTab extends StatefulWidget {
  final Object? dataMerchant;
  final List<ObjectShipment>? objectShipment;
  final Function(Map<String, String> map)? updateShipmet;
  final Function(File photo)? onFotoChangedMerchant;
  final Function(int selfPick)? parseRadius;
  final SupplierProduct? supplierProduct;
  final String uuidMogawers;
  const MerchantTab({Key? key, required this.uuidMogawers, required this.dataMerchant, this.supplierProduct, this.objectShipment, this.updateShipmet, this.onFotoChangedMerchant, this.parseRadius }) : super(key: key);

  @override
  State<MerchantTab> createState() => _MerchantTabState();
}

class _MerchantTabState extends State<MerchantTab> {
  bool _loadingButtonMulai = false;
  bool loading = false;
  final picker = ImagePicker();
  File? photo;
  String? path;
  bool valueswitchDiantar = false;
  bool valueswitchKurir = false;
  bool valuesShipment = false;
  double slidervalue = 1;
  double valueAwal= 1;
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
  String codeShipment ='';
  String codeNameShipment = '';
  List a =[];
  bool selectedV = false;
  String values = '';
  var token;

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

  void setRadius(int radius) async{
    SharedPreferences cekAntar = await SharedPreferences.getInstance();
    cekAntar.setInt('radius', radius);
  }

  void setisKurirToko(bool antar) async{
    SharedPreferences cekKurirtoko = await SharedPreferences.getInstance();
    cekKurirtoko.setBool('kurirtoko', antar);
  }

  void setShipment(shipment) async{
    SharedPreferences shipmentValue = await SharedPreferences.getInstance();
    shipmentValue.setString('shipment', shipment);
  }

  void setShipmentStringtoApi (shipment) async{
    SharedPreferences shipmentValue = await SharedPreferences.getInstance();
    shipmentValue.setString('shipmenttoApi', shipment);
  }

  void setShipmentBool(shipment) async{
    SharedPreferences shipmentValue = await SharedPreferences.getInstance();
    shipmentValue.setString('shipmentString', shipment);

  }

  void setShipmentSelect( select) async{
    SharedPreferences shipmentValue1 = await SharedPreferences.getInstance();
    shipmentValue1.setBool('selected', select);
  }

  Future<String> getShipmentValueBool2()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('shipmentString') ?? '';
  }

  Future<bool> getShipmentValueBool1()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('selected') ?? false;
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
    getShipmentValueBool1().then((value) {
      selectedV = value;

    });

    getShipmentValueBool2().then((value1) {
      values = value1;

    });
    if(selectedV == true){
      setState(() {
        selectShipment.add(values);
        print('abcd');
        print(selectShipment);
      });
    }
    else {
      setState(() {
        selectShipment.remove(values);
      });
    }

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.dataMerchant?.selfPickupRadius != null){
      valueSlideAwal = widget.dataMerchant?.selfPickupRadius as int;
    }
     else{
      valueSlideAwal =1000;
    }
    valueAwal = valueSlideAwal / 1000;
    totalvalueAwal = (valueSlideAwal / 1000).round();
    rangeSlide = totalvalueAwal.toString();
    if(widget.supplierProduct?.objectDatas == null ){
      loading = false;
    }else{
      loading = true;
    }

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
    cekValue();
  }


  @override
  Widget build(BuildContext context) {
    return widget.supplierProduct?.returnValue != '000' ? ListView(children: [
      Center(
        child: Column(
          children: [
            Image.asset('assets/images/im_no_job.png'),
            SizedBox(height: 10,),
            Text('Kamu belum buka toko nih, yuk jualin\ndagangan mu disini', textAlign: TextAlign.center, style: FlutterFlowTheme.bodyText2,),
            SizedBox(height: 10,),
            FFButtonWidget(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MulaiJualanScreen(uuidMogawers: widget.uuidMogawers,),
                  ),
                );
              },
              text: 'Mulai Jualan',
              options: FFButtonOptions(

                height: 32,
                color: FlutterFlowTheme.secondaryColor,
                textStyle: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  color: FlutterFlowTheme.primaryColor,
                  fontSize: 12,
                ),
                borderSide: BorderSide(
                  color: FlutterFlowTheme.primaryColor,
                  width: 1,
                ),
                borderRadius: 12,
              ),
              loading: _loadingButtonMulai,
            )
          ],
        ),
      )
    ],) : ListView(
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
                child: BounceTap(
                  onTap: (){},
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
              ),
              BounceTap(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddressPickupScreen(),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          'Alamat Pickup',
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.dataMerchant != null
                              ? ' ${widget.dataMerchant!.storeAddress}'
                              : "",
                          style: FlutterFlowTheme.bodyText1.override(
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
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 16),
                child: Text(
                  'Metode Pengiriman',
                  style: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Poppins',
                    color: FlutterFlowTheme.primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              BounceTap(
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
                child: BounceTap(
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

                  ],
                ),
                BounceTap(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddProductMerchant(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        0, 16, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Text('Tambah Produk',
                            style: FlutterFlowTheme.bodyText1
                                .override(
                              fontFamily: 'Poppins',
                            ),
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
                BounceTap(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductMerchantPage(supplierProduct: widget.supplierProduct,),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        0, 16, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Text('Semua Produk',
                            style: FlutterFlowTheme.bodyText1
                                .override(
                              fontFamily: 'Poppins',
                            ),
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
        ),
        Container(
          width: 300,
          height: 200,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
                16, 16, 16, 0),
            child:
            // loading ?
            // Center(
            //   child: Container(
            //       width: 20,
            //       height: 20,
            //       child: CircularProgressIndicator()),
            // )
            widget.supplierProduct?.objectDatas == null ?   Center(
              child: Column(
                children: [
                  Image.asset('assets/images/im_no_job.png'),
                  SizedBox(height: 10,),
                  Text('Kamu belum ada produk nih, yuk jualin\ndagangan mu disini', textAlign: TextAlign.center, style: FlutterFlowTheme.bodyText2,),
                  SizedBox(height: 10,),
                  FFButtonWidget(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddProductMerchant(),
                        ),
                      );
                    },
                    text: 'Mulai Jualan',
                    options: FFButtonOptions(

                      height: 32,
                      color: FlutterFlowTheme.secondaryColor,
                      textStyle: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        color: FlutterFlowTheme.primaryColor,
                        fontSize: 12,
                      ),
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.primaryColor,
                        width: 1,
                      ),
                      borderRadius: 12,
                    ),
                    loading: _loadingButtonMulai,
                  )
                ],
              ),
            ) :  GridView.builder(

                padding: EdgeInsets.zero,
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                scrollDirection: Axis.vertical,
                itemCount: widget.supplierProduct?.objectDatas?.length,
                itemBuilder: (context, snap){

                  final card = widget.supplierProduct?.objectDatas?[snap];
                  var currencyFormatter = NumberFormat.currency(locale: 'ID');
                  var price = currencyFormatter.format(card?.price);
                  var komisi = currencyFormatter.format(card?.commission);

                  return InkWell(
                    onTap: (){
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) => EditProductMerchant(id: card?.uuid,)));

                    },
                    child: Card(
                      clipBehavior:
                      Clip.antiAliasWithSaveLayer,
                      color: Color(0xFFF5F5F5),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Stack(
                            alignment:
                            AlignmentDirectional(0, 1),
                            children: [
                              Image.network(
                                '${card?.imageUrl}',
                                width: double.infinity,
                                height: 100,
                                fit: BoxFit.cover,
                              ),

                            ],
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional
                                .fromSTEB(8, 8, 8, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${card?.name}',
                                  style: FlutterFlowTheme
                                      .bodyText1
                                      .override(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  EdgeInsetsDirectional
                                      .fromSTEB(
                                      0, 4, 0, 0),
                                  child: Row(
                                    mainAxisSize:
                                    MainAxisSize.max,
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Text(
                                        'Rp${price.replaceAll('IDR', '').replaceAll(',00', '')}',
                                        style:
                                        FlutterFlowTheme
                                            .bodyText1
                                            .override(
                                          fontFamily:
                                          'Poppins',
                                          fontSize: 11,
                                        ),
                                      ),
                                      Text(
                                        'Rp${komisi.replaceAll('IDR', '').replaceAll(',00', '')}',
                                        style:
                                        FlutterFlowTheme
                                            .bodyText1
                                            .override(
                                          fontFamily:
                                          'Poppins',
                                          fontSize: 11,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
            ),
          ),
        ),
        SizedBox(height: 10,)
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
                              setRadius(parseInt);
                            });
                          },
                          max: 150,
                          min: 1,
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
                                  //valuesShipment = selectShipment.contains(listValue?.code);
                                  codeShipment = listValue?.code ?? '';
                                  return Container(
                                    width: 300,
                                    child: CheckboxListTile(

                                      value: selectShipment.contains(listValue?.code),
                                      onChanged: (selected) {
                                        valuesShipment = selected!;

                                        a.add(listValue?.code);
                                        String isi = a.toString().replaceAll('[', '').replaceAll(']', '');

                                        stateSetter(() {
                                          shipmentSelectedBool(selected!,
                                              listValue?.code);
                                          shipmentSelected(selected!,
                                              listValue?.code);
                                          getShipmentName(selected!,
                                              listValue?.name);
                                          setShipmentBool(isi);
                                          setShipmentSelect(selected);
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
                        print('aadd');
                        print(a);
                        String convertValue = selectShipment.toString();
                        codeNameShipment = convertValue.replaceAll('[', '').replaceAll(']', '');
                        String convertValueName = selectShipmentName.toString();
                        String convertnonfinal = convertValueName.replaceAll('[', '').replaceAll(']', '');
                        String convertValueFinal = convertValue.replaceAll('[', '').replaceAll(']', '').replaceAll(', ', ':');
                        print(convertValueFinal);
                        // setShipmentBool(codeShipment);
                        // setShipmentSelect(valuesShipment);
                        setShipment(convertnonfinal);
                        setShipmentStringtoApi(convertValueFinal);

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
