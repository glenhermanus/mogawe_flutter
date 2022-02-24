import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mogawe/core/data/response/hire_me/category_list_response.dart';
import 'package:mogawe/core/data/response/merchant/alamat_merchant_pickup.dart';
import 'package:mogawe/core/data/sources/network/user_network_service.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/core/repositories/profile_repository.dart';
import 'package:mogawe/modules/profile/page_merchant/atur_pengiriman.dart';
import 'package:mogawe/modules/profile/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddProductMerchant extends StatefulWidget {
  const AddProductMerchant({Key? key}) : super(key: key);

  @override
  _AddProductMerchantState createState() => _AddProductMerchantState();
}

class _AddProductMerchantState extends State<AddProductMerchant> {
  bool _loadingButton = false;
  TextEditingController textController = new TextEditingController();
  TextEditingController hargactrl = new TextEditingController();
  TextEditingController namactrl = new TextEditingController();
  TextEditingController deskripsictrl = new TextEditingController();
  TextEditingController youtubeUrlctrl = new TextEditingController();
  TextEditingController brandctrl = new TextEditingController();
  TextEditingController komisictrl = new TextEditingController();
  CategoryListResponse? category;
  AddressPickupMerchant? addressPickupMerchant;
  int?  indexSelect, indexSelectAddress, indexSelectDanger, indexSelectStok;
  var listcategory_, valuelist =
  {
    'name' : 'Semua Kategori',
    'uuid' : 'abc',
  };
  var token;
  bool loading_category = false;
  var nameCategory, uuidCategory, nameCategoryValue, uuidCategoryValue, name, stokValue;
  var value;
  bool loading = false;
  var categoryValue, addresValue, dangerValue;
  String? harga, komisi;
  List ValueImage=[];
  var ProdukBerbahayalist =
  [{
    'name' : 'Ya (Mengandung magnet/baterai\n/cairan/bahan mudah terbakar',
    'isDangerous' : 'true',
  },
    {
      'name' : 'Tidak',
      'isDangerous' : 'false',
    },

  ];
  var stock =[
    {
      'name' : 'Tersedia',
      'stock' : 'true',
    },
    {
      'name' : 'Tidak Tersedia',
      'stock' : 'false',
    },
  ];
  final picker = ImagePicker();
  File? photo;
  List<File>? photos;
  String? path, fileName;

  // Future getImageGallery() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true, type: FileType.image);
  //
  //   if(result != null) {
  //     photos = result.paths.map((path) => File(path!)).toList();
  //   } else {
  //     // User canceled the picker
  //   }
  //   if (!mounted) return;
  //
  //   setState(() {
  //     fileName = photos != null ? photos!.map((e) => e.toString()).toString() : 'error';
  //     uploadFoto(photo, token);
  //   });
  // }

  Future getImageGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        photo = File(pickedFile.path);
        path = photo?.path.split('/').last;
        uploadFoto(photo!, token);
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: "Tidak ada foto yang dipilih");
      }
    });

  }

  void uploadFoto(File foto, token)async{
    var map = {
      "file": foto
    };
   var res= await ProfileRepository().addPhotoProduct(map, realToken: token);
   setState(() {
     print('qbc');
     ValueImage.add({
       "uuid":"",
       "uuidProduct":"",
       "value":res.object,
       "mainPicture":false,
       "sequence":0
     });
     print(ValueImage);
   });

  }
  Future<String> getShipmentValue ()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('shipmenttoApi') ?? '';
  }

  Future<bool> getcekKurirTokoAdd()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('kurirtokoAdd') ?? false;
  }

  Future<int> getcekRadius()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('radius') ?? 0;
  }

  Future<bool> getcekValueEkspAdd()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('valueEkspedisi') ?? false;
  }

  Future<bool> getcekDiantarAdd()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('diantarAdd') ?? false;
  }

  Future getImageCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        photo = File(pickedFile.path);
        path = photo?.path.split('/').last;
        uploadFoto(photo!, token);
        Navigator.pop(context);
        //  widget.onFotoChangedMerchant!(photo!);
      } else {
        Fluttertoast.showToast(msg: "Tidak ada foto yang dipilih");
      }
    });

  }

  Future getCategory()async{
    setState(() {
      loading = true;

    });

    token = await AuthRepository().readSecureData('token');
    category = await AuthRepository().getCategorydata(token);
    addressPickupMerchant = await AuthRepository().getAddresPickupMerchant(token);

    setState(() {
      loading = false;
      listcategory_ = [];

      for(var i=0; i <category!.object!.length; i++){

        var listbaru = {
          'name' : category?.object?[i].name as String,
          'uuid' : category?.object?[i].uuid as String,
        };
        listcategory_.add(listbaru);
      }
    });
  }

  openAlertBoxKategori() {
    final node = FocusScope.of(context);
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
                          "Kategori Produk", style: FlutterFlowTheme.bodyText1.copyWith(fontWeight: FontWeight.w600,
                            fontSize: 16),
                        ),
                        SizedBox(height: 10,),
                        Expanded(
                          child: Container(
                            width: 300,
                            height:  MediaQuery.of(context).size.height * 0.6,
                            child: ListView.builder(
                                itemCount: category?.object?.length,
                                itemBuilder: (context, snap){
                                  final listValue = category?.object?[snap];


                                  return InkWell(
                                    onTap: (){
                                      stateSetter(() {
                                        categoryValue = category?.object?[snap];
                                        indexSelect = snap;
                                        node.nextFocus();
                                        Navigator.pop(context);
                                      });

                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                                      child: Container(
                                          width: 300,
                                          child: Text('${listValue?.name}')
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

              );
            }));
  }

  openAlertBoxAlamat() {
    final node = FocusScope.of(context);
    return showDialog(
        context: context,
        builder: (BuildContext context) => StatefulBuilder(
            builder: (BuildContext context, StateSetter stateSetter) {
              return AlertDialog(
                contentPadding: EdgeInsets.only(top: 0.0, bottom: 0.0),

                content: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          "Alamat Pickup", style: FlutterFlowTheme.bodyText1.copyWith(fontWeight: FontWeight.w600,
                            fontSize: 16),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          width: 300,
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: ListView.builder(
                              itemCount: addressPickupMerchant?.object.length,
                              itemBuilder: (context, snap){
                                final listValue = addressPickupMerchant?.object[snap];

                                return InkWell(
                                  onTap: (){
                                    stateSetter(() {
                                      addresValue = addressPickupMerchant?.object[snap];
                                      indexSelectAddress = snap;
                                      node.nextFocus();
                                      Navigator.pop(context);
                                    });

                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                                    child: Container(
                                        width: 300,
                                        child: Text('${listValue?.name}')
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                ),

              );
            }));
  }

  openAlertBoxProdukBerbahaya() {
    final node = FocusScope.of(context);
    return showDialog(
        context: context,
        builder: (BuildContext context) => StatefulBuilder(
            builder: (BuildContext context, StateSetter stateSetter) {
              return AlertDialog(
                contentPadding: EdgeInsets.only(top: 0.0, bottom: 0.0),

                content: Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          "Kategori Produk", style: FlutterFlowTheme.bodyText1.copyWith(fontWeight: FontWeight.w600,
                            fontSize: 16),
                        ),
                        SizedBox(height: 10,),
                        Expanded(
                          child: Container(
                            width: 300,
                            height:  MediaQuery.of(context).size.height * 0.6,
                            child: ListView.builder(
                                itemCount: ProdukBerbahayalist.length,
                                itemBuilder: (context, snap){
                                  final listValue = ProdukBerbahayalist[snap];
                                  return InkWell(
                                    onTap: (){
                                      stateSetter(() {
                                        dangerValue = ProdukBerbahayalist[snap];
                                        indexSelectDanger = snap;
                                        node.nextFocus();
                                        Navigator.pop(context);
                                      });

                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                                      child: Container(
                                          width: 300,
                                          child: Text('${listValue['name']}')
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

              );
            }));
  }

  openAlertBoxStok() {
    final node = FocusScope.of(context);
    return showDialog(
        context: context,
        builder: (BuildContext context) => StatefulBuilder(
            builder: (BuildContext context, StateSetter stateSetter) {
              return AlertDialog(
                contentPadding: EdgeInsets.only(top: 0.0, bottom: 0.0),

                content: Container(
                  height: MediaQuery.of(context).size.height * 0.20,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          "Stok Produk", style: FlutterFlowTheme.bodyText1.copyWith(fontWeight: FontWeight.w600,
                            fontSize: 16),
                        ),
                        SizedBox(height: 10,),
                        Expanded(
                          child: Container(
                            width: 300,
                            height:  MediaQuery.of(context).size.height * 0.6,
                            child: ListView.builder(
                                itemCount: stock.length,
                                itemBuilder: (context, snap){
                                  final listValue = stock[snap];
                                  return InkWell(
                                    onTap: (){
                                      stateSetter(() {
                                        stokValue = stock[snap];
                                        indexSelectStok = snap;
                                        node.nextFocus();
                                        Navigator.pop(context);
                                      });

                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                                      child: Container(
                                          width: 300,
                                          child: Text('${listValue['name']}')
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

              );
            }));
  }

  void showEditDialog(BuildContext ctx,
      {String? title, Function(String v)? onChanged, TextInputType? type,
        String? value, bool isGender = false, String? field, TextEditingController? ctrl}) {
    var maskFormatter = new NumberFormat.currency(locale: 'id');
    showDialog(
        context: ctx,
        builder: (ctx) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title ?? "", style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600
              )),
              SizedBox(height: 12),
             Container(
                height: 32,
                child: TextFormField(

                  onChanged: (v) {
                    value = v;
                    if (v.isEmpty) value = null;
                    setState(() {});
                  },
                  keyboardType: type ?? TextInputType.text,
                  controller: ctrl,
                ),
              )
            ],
          ),
            actions:  [
            TextButton(
              child: Text("BATAL"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text("OK"),
              onPressed: () {
                if (value != null) {
                  setState(() {
                    var formatterKomisi;
                    final formatter = new NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0).format(double.parse(hargactrl.text??''));
                    harga = formatter;
                    Navigator.pop(context);
                  });
                }
                if(komisictrl.text != null){
                  setState(() {
                    var formatterKomisi;
                    formatterKomisi = new NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0).format(double.parse(komisictrl.text??''));
                    komisi = formatterKomisi;
                  });
                }
                else Fluttertoast.showToast(msg: "Harus diisi");
              },
            ),
            ]
        ),

    );
  }

  Widget munculingambar(BuildContext context){
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return Stack(
      children: [
        SafeArea(
            child: Image.file(File(photo!.path), height: 50, fit: BoxFit.fill,
            ),
          ),
      ],
    );


  }

  backPressed(BuildContext context){
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Data akan hilang", style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600
              )),
              SizedBox(height: 12),
              Text("Apakah Anda ingin membatalkan perubahan?", style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400
              )),
            ],
          ),
          actions:  [
            TextButton(
              child: Text("BATAL"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text("YA"),
              onPressed: () {
               Navigator.of(context).pop();
               Navigator.of(context).pop();
              },
            ),
          ]
      ),

    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await backPressed(context);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.secondaryColor,
          iconTheme: IconThemeData(color: FlutterFlowTheme.tertiaryColor),
          automaticallyImplyLeading: true,
          title: Text(
            'Tambah Produk',
            style: FlutterFlowTheme.subtitle1.override(
              fontFamily: 'Poppins',
            ),
          ),

          centerTitle: false,
          elevation: 0,
        ),
        body: ListView(
          children: [
            SizedBox(height: 5,),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Gambar Produk *'),
                    SizedBox(height: 10,),
                    InkWell(
                      onTap: ()=> chooseImage(),
                      child: Row(
                        children: [
                          photo != null ? DottedBorder(
                            borderType: BorderType.RRect,
                            strokeWidth: 1,
                            color: Colors.black54,
                            child: Container(
                              width: 40,
                              height: 50,
                              child: munculingambar(context),
                            ),
                          ) : Container(),
                          SizedBox(width: 10,),
                          DottedBorder(
                            borderType: BorderType.RRect,
                            strokeWidth: 1,
                            color: Colors.black54,
                            child: Container(
                              height: 50,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Icon(
                                  Icons.add, color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nama Produk *'),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(),
                      child: TextFormField(
                        controller: namactrl,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Nama Produk',
                          hintStyle: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
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
                          filled: true,
                          fillColor: FlutterFlowTheme.fieldColor,

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
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Deskripsi *'),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(),
                      child: TextFormField(
                        controller: deskripsictrl,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Deskripsi',
                          hintStyle: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
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
                          filled: true,
                          fillColor: FlutterFlowTheme.fieldColor,

                        ),
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                        ),
                        minLines: 2,
                        maxLines: 4,
                        onChanged: (s)async{
                          setState(() {

                          });

                          setState(() {

                          });
                        },
                      ),
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Youtube Url'),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(),
                      child: TextFormField(
                        controller: youtubeUrlctrl,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Youtube Url',
                          hintStyle: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
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
                          filled: true,
                          fillColor: FlutterFlowTheme.fieldColor,

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
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Brand *'),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(),
                      child: TextFormField(
                        controller: brandctrl,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Brand',
                          hintStyle: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
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
                          filled: true,
                          fillColor: FlutterFlowTheme.fieldColor,

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
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: ()=> openAlertBoxAlamat(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.home_outlined),
                              SizedBox(width: 10,),
                              Text('Alamat PickUp*'),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                child: addresValue  == null ? Text('') : Text('${addresValue.name}'),
                              ),
                              SizedBox(width: 10,),
                              Icon(Icons.arrow_forward_ios, size: 14,),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 16,),
                    InkWell(
                      onTap: () {
                        openAlertBoxKategori();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.list),
                              SizedBox(width: 10,),
                              Text('Kategori *'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: categoryValue == null ? Text('') : Text('${categoryValue.name}'),
                              ),
                              SizedBox(width: 10,),
                              Icon(Icons.arrow_forward_ios, size: 14,),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 16,),
                    InkWell(
                      onTap: (){
                        openAlertBoxProdukBerbahaya();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.info_outline),
                              SizedBox(width: 10,),
                              Text('Produk Berbahaya *'),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                child: dangerValue  == null ? Text('') : Text('${dangerValue['name'].split('(').first}'),
                              ),
                              SizedBox(width: 10,),
                              Icon(Icons.arrow_forward_ios, size: 14,),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 16,),
                    InkWell(
                      onTap: ()=> showEditDialog(
                          context,
                          title: "Rekomendasi Harga Produk ",
                          type: TextInputType.numberWithOptions(),
                          value: harga,
                          field: "phone",
                          ctrl: hargactrl,
                          onChanged: (v) {
                            // phone = v;
                            // if (v.isEmpty) phone = null;
                            setState(() {});
                          }
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.attach_money_sharp),
                              SizedBox(width: 10,),
                              Text('Harga *'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: harga != null ? Text('$harga') : Text(''),
                              ),
                              SizedBox(width: 10,),
                              Icon(Icons.arrow_forward_ios, size: 14,),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 16,),
                    InkWell(
                      onTap: ()=> showEditDialog(
                          context,
                          title: "Komisi Produk ",
                          type: TextInputType.number,
                          value: komisi,
                          field: "phone",
                          ctrl: komisictrl,
                          onChanged: (v) {
                            // phone = v;
                            // if (v.isEmpty) phone = null;
                            setState(() {});
                          }
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.money_sharp),
                              SizedBox(width: 10,),
                              Text('Komisi *'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: komisi != null ? Text('$komisi') : Text(''),
                              ),
                              SizedBox(width: 10,),
                              Icon(Icons.arrow_forward_ios, size: 14,),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 16,),
                    InkWell(
                      onTap: ()=> openAlertBoxStok(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.category),
                              SizedBox(width: 10,),
                              Text('Stok *'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: stokValue != null ? Text('${stokValue['name']}') : Text(''),
                              ),
                              SizedBox(width: 10,),
                              Icon(Icons.arrow_forward_ios, size: 14,),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 16,),
                    InkWell(
                      onTap: (){
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) => AturPengiriman()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.inbox),
                              SizedBox(width: 10,),
                              Text('Pengiriman *'),
                            ],
                          ),
                          Icon(Icons.arrow_forward_ios, size: 14,)
                        ],
                      ),
                    ),
                    SizedBox(height: 16,),

                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 16),
              child: FFButtonWidget(
                onPressed: ()async{
                  String shipping ='';
                  int? valueRadius;
                  bool? valueantar, valuekurir, freeongkir, valueeks;
                  setState(() {
                    getShipmentValue().then((value) {
                      setState(() {
                        shipping = value;
                      });
                    });
                    getcekDiantarAdd().then((value) {
                      setState(() {
                        valueantar = value;
                      });
                    });
                    getcekKurirTokoAdd().then((value) {
                      setState(() {
                        valuekurir = value;
                      });
                    });
                    getcekValueEkspAdd().then((value) {
                      setState(() {
                        valueeks = value;
                      });
                    });
                    getcekRadius().then((value) {
                      setState(() {
                        valueRadius = value;
                      });
                    });
                    freeongkir = valueantar == false ? valuekurir == false? false : true : true;
                  });
                  var berat = await AuthRepository().readSecureData('beratbarang');

                  try{
                    await UserNetworkService().InputProduct(token, categoryValue.uuid, namactrl.text, deskripsictrl.text, brandctrl.text, dangerValue['isDangerous'],
                        berat, 0.0, 0.0, 0.0, 'new', double.parse(hargactrl.text), double.parse(komisictrl.text), stokValue['stock'], youtubeUrlctrl.text == null ? youtubeUrlctrl.text = '' : youtubeUrlctrl.text,
                        true, ValueImage, false, freeongkir, valueantar, ValueImage[0]['value'],
                        valuekurir, shipping != null ? true : false, shipping,
                        addressPickupMerchant?.object?[0].address, addressPickupMerchant?.object[0].name, addressPickupMerchant?.object[0].notes, valueRadius,
                        addressPickupMerchant?.object[0].supplierName, addressPickupMerchant?.object[0].uuid, addressPickupMerchant?.object[0].latitude, addressPickupMerchant?.object[0].longitude,
                        addressPickupMerchant?.object[0].shipmentCityId, addressPickupMerchant?.object[0].shipmentCityName, addressPickupMerchant?.object[0].shipmentProvinceId, addressPickupMerchant?.object[0].shipmentProvinceName
                    );
                    Fluttertoast.showToast(msg: "Berhasil");
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(),
                      ),
                    );
                  }catch(e){

                    Fluttertoast.showToast(msg: "$e");
                  }




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
                  borderRadius: 20,
                ),
                loading: _loadingButton,
              ),
            )
          ],
        ),
      ),
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

}


