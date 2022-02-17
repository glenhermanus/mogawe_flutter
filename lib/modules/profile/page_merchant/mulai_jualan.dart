import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/core/repositories/mulai_merchant_repository.dart';
import 'package:mogawe/modules/profile/page_merchant/address_new_merchant.dart';
import 'package:mogawe/modules/profile/page_merchant/edit_new_address_merchant.dart';
import 'package:mogawe/modules/profile/profile_screen.dart';
import 'package:mogawe/utils/ui/animation/bounce_tap.dart';

class MulaiJualan extends StatefulWidget {
  final Function(File photo) onFotoChanged;
  final String photoUrl;
  final String uuid;
  MulaiJualan({required this.uuid, required this.onFotoChanged, required this.photoUrl});

  @override
  _MulaiJualanState createState() => _MulaiJualanState();
}

class _MulaiJualanState extends State<MulaiJualan> {
  TextEditingController nama_toko = new TextEditingController();
  TextEditingController alamat = new TextEditingController();
  final picker = ImagePicker();
  File? photo;
  String? path;
  String address = '';
  String note = '';
  var token;
  late double addressLat, addressLng;
  var idCity, idProv, nameCity, nameProv, namaalamat;
  var logger = Logger(printer: PrettyPrinter());

  Future getImageGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      photo = File(pickedFile.path);
      path = photo?.path.split('/').last;
      widget.onFotoChanged(photo!);
    } else {
      Fluttertoast.showToast(msg: "Tidak ada foto yang dipilih");
    }
  }

  Future getImageCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      photo = File(pickedFile.path);
      path = photo!.path.split('/').last;
      widget.onFotoChanged(photo!);
    } else {
      Fluttertoast.showToast(msg: "Tidak ada foto yang dipilih");
    }
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

  getToken()async{
    token = await AuthRepository().readSecureData('token');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(namaalamat!=null){
      alamat.text = namaalamat;
    }
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.secondaryColor,
        iconTheme: IconThemeData(color: FlutterFlowTheme.tertiaryColor),
        automaticallyImplyLeading: true,
        title: Text(
          'Mulai Jualan',
          style: FlutterFlowTheme.subtitle1.override(
              fontFamily: 'Poppins',
              color: Colors.black
          ),
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: BounceTap(
                onTap: () async {
                var res=   await MulaiMerchantRepository().registMerchant(
                      token, nama_toko.text, address, addressLat, addressLng,
                      idProv, nameProv, idCity, nameCity, widget.photoUrl, widget.uuid);
                print(res);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(),
                    ));
                },
                child: Text(
                  "Simpan",
                  style: FlutterFlowTheme.subtitle1.copyWith(fontSize: 14),
                ),
              ),
            ),
          ),
        ],
        centerTitle: false,
        elevation: 4,
      ),
      backgroundColor: FlutterFlowTheme.secondaryColor,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 22, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Informasi Toko',style: FlutterFlowTheme.subtitle1.copyWith(fontSize: 14)),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.photoUrl == '' ? InkWell(
                      onTap: (){
                        chooseImage();
                      },
                      child: Container(
                        width: 126,
                        height: 126,
                        decoration: BoxDecoration(
                          color: Color(0xffC4C4C4),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(30),
                                child: Image.asset('assets/images/icon_toko.png'),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  width: 26,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset('assets/icon/ic_edit.png'),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ) :
                    InkWell(
                      onTap: (){
                        chooseImage();
                      },
                      child: Container(
                        width: 126,
                        height: 126,
                        decoration: BoxDecoration(
                            color: Color(0xffC4C4C4),
                            borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(widget.photoUrl),
                            fit: BoxFit.fill
                          )
                        ),
                        child: Stack(
                          children: [

                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  width: 26,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset('assets/icon/ic_edit.png'),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 18,),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Gambar Profil', style: FlutterFlowTheme.bodyText1.copyWith(fontSize: 14),),
                          Text('Besar file maks. 10MB dengan format .JPG, .JPEG, .PNG', style: FlutterFlowTheme.bodyText2.copyWith(fontSize: 12,
                          color: Color(0xffc7c7c7)),)
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 32,),
                Text('Nama Toko',style: FlutterFlowTheme.bodyText1.copyWith(fontSize: 14)),
                TextFormField(
                  controller: nama_toko,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: 'Masukkan nama toko kamu',
                    hintStyle: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins', color: Colors.black38
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(0),
                    ),

                  ),
                  style: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Poppins',
                  ),
                  maxLength: 60,
                  onChanged: (s)async{
                    setState(() {

                    });

                  },
                ),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Alamat Pickup',style: FlutterFlowTheme.bodyText1.copyWith(fontSize: 14)),
                    namaalamat== null ? BounceTap(
                      onTap: ()async{
                       var res = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  AddressNewMerchant(),
                          ),
                        );
                       if (res != null || res != "") {
                         setState(() {
                           address = res['storeAddress'] as String;
                           addressLat = res['lat'] as double;
                           addressLng = res['long'] as double;
                           namaalamat = res['nameAddress'];
                           nameCity = res['nameCity'];
                           nameProv = res['nameProvince'];
                           idCity = res['cityId'];
                           idProv = res['idProv'];
                           note = res['note'];
                           logger.d("addressnya adalah ${res['note']}");
                         });
                       }
                      },
                        child: Row(
                          children: [
                            Icon(Icons.add, color: Colors.red, size: 16,),
                            Text(' Alamat', style: FlutterFlowTheme.title1.copyWith(fontSize: 14, color: Colors.red))
                          ],
                        ),
                    ) :
                    BounceTap(
                      onTap: ()async{
                        var res = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  AddressEditNewMerchant(
                              alamat: address, idCity: idCity, nama_city: nameCity, lat: addressLat, nama_alamat: namaalamat,
                              note: note, lang: addressLng, idProv: idProv, nama_provinsi: nameProv,
                            ),
                          ),
                        );
                        if (res != null || res != "") {
                          setState(() {
                            address = res['storeAddress'] as String;
                            addressLat = res['lat'] as double;
                            addressLng = res['long'] as double;
                            namaalamat = res['nameAddress'];
                            nameCity = res['nameCity'];
                            nameProv = res['nameProvince'];
                            idCity = res['cityId'];
                            idProv = res['idProv'];
                            note = res['note'];
                            print(note);
                            logger.d("addressnya adalah ${res['storeAddress']}");
                          });
                        }
                      },
                      child: Text(' Ubah', style: FlutterFlowTheme.title1.copyWith(fontSize: 14, color: Colors.red)),
                    )
                  ],
                ),
                TextFormField(
                  readOnly: true,
                  controller: alamat,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: namaalamat == null ? 'Atur Alamat Pickup' : '$namaalamat',
                    hintStyle: namaalamat  == null ? FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins', color: Colors.black38
                    ) : FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins', color: Colors.black
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
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
              ],
            ),
          )
        ],
      ),
    );
  }


}
