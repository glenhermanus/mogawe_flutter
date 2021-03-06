import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mogawe/core/data/response/hire_me/hire_me_sales_response.dart';
import 'package:mogawe/core/data/response/hire_me/sales_detail_response.dart';
import 'package:mogawe/core/data/response/hire_me/seller_addres_response.dart';
import 'package:mogawe/core/data/response/user_profile_response.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_icon_button.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/modules/hire_me/sales/widgets/build_loading_detail_page.dart';
import 'package:mogawe/modules/hire_me/sales/working/sales_shipment/sales_address_page.dart';
import 'package:mogawe/modules/hire_me/sales/working/sales_shipment/servis%20ekspedisi.dart';
import 'package:mogawe/modules/hire_me/sales/working/sales_shipment/shipment_detail.dart';
import 'package:shimmer/shimmer.dart';

class SalesShipmentPage extends StatefulWidget {
  String uuid;
  SalesShipmentPage({required this.uuid});

  @override
  _SalesShipmentPageState createState() =>
      _SalesShipmentPageState();
}

class _SalesShipmentPageState extends State<SalesShipmentPage> {
  TextEditingController? nama_pembeli;
  TextEditingController? no_hp;
  TextEditingController textController3 = new TextEditingController();
  TextEditingController resellername = new TextEditingController();
  TextEditingController resellerphone = new TextEditingController();
  TextEditingController reselleralamat = new TextEditingController();
  TextEditingController? textController4;
  bool checkboxListTileValue1 = false;
  bool checkboxListTileValue2= false;
  bool checkboxListTileValue3= false;
  bool checkboxListTileValue4= false;
  bool _loadingButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading = false;
  var token, price, totalfee, totalfeeCurrency, pricewithoutIDR, priceCurrency, checkbox, provinceIdShipment, provinceShipmentName, cityShipmentName;
  SalesDetailResponses? salesDetailResponses;
  var image;
  int itemCount = 1;
  var currencyFormatter, alamat, detailalamat, city_id_buyer, city_id_seller,
      lat,lng, latdouble, lngdouble,
      cityShipment, nameEkspedisi, service,
      priceEkspedisi, priceEkspedisiFormat, priceEkspedisiDouble, estmin, estmax;
  HireMeSalesResponses? hireMeSalesResponses;
  SellerAddress? sellerAddress;
  UserProfileResponse? userProfileResponse;

  Future getData()async{
    setState(() {
      loading = true;

    });

    token = await AuthRepository().readSecureData('token');
    alamat = await AuthRepository().readSecureData('alamat');
    detailalamat = await AuthRepository().readSecureData('detail');
    salesDetailResponses = await AuthRepository().getDetailsales(token, widget.uuid);
    hireMeSalesResponses = await AuthRepository().hiremeSalesdata(token);
    checkbox = await AuthRepository().readSecureData('checkbox3');
    nameEkspedisi = await AuthRepository().readSecureData('nameEkspedisi');
    priceEkspedisi = await AuthRepository().readSecureData('value');
    service = await AuthRepository().readSecureData('serviceEkspedisi');
    lat = await AuthRepository().readSecureData('lat');
    lng = await AuthRepository().readSecureData('long');
    estmin = await AuthRepository().readSecureData('estmin');
    estmax = await AuthRepository().readSecureData('estmax');
    city_id_buyer = await AuthRepository().readSecureData('city_id');
    userProfileResponse = await AuthRepository().getProfile(token);
    currencyFormatter = NumberFormat.currency(locale: 'ID');
    priceEkspedisiDouble = priceEkspedisi != null ? double.parse(priceEkspedisi) : 0;
    priceEkspedisiFormat = currencyFormatter.format(priceEkspedisiDouble);
    price = '${salesDetailResponses?.price.toString().split('.').first}';
    priceCurrency = currencyFormatter.format(salesDetailResponses?.price);
    for(var i =0; i<salesDetailResponses!.productAddresses.length; i++){
      cityShipment = salesDetailResponses?.productAddresses[i].supplierAddressShipmentCityId;
      provinceIdShipment = salesDetailResponses?.productAddresses[i].supplierAddressShipmentProvinceId;
      provinceShipmentName = salesDetailResponses?.productAddresses[i].supplierAddressShipmentProvinceName;
      cityShipmentName = salesDetailResponses?.productAddresses[i].supplierAddressShipmentCityName;
      print(cityShipment);
      print('inicity');
    }
    //sellerAddress = await AuthRepository().getSellerAddress(token, salesDetailResponses?.uuidSupplierAddress);
    setState(() {
      loading = false;
      int _price = int.parse(price);
      totalfee = _price * itemCount;
      totalfeeCurrency = currencyFormatter.format(totalfee);
      alamat == null ? textController3.text ='' : detailalamat == null ? textController3.text = '' : textController3.text = '$alamat $detailalamat';
      city_id_seller = sellerAddress?.shipmentCityId;
      checkboxListTileValue3 = checkbox =='true';
      resellername.text = userProfileResponse?.full_name as String;
      resellerphone.text = userProfileResponse?.phone != '' ? userProfileResponse?.phone as String : '';
      print(userProfileResponse?.phone);
      print('aas');
    });
  }

  @override
  void initState() {
    super.initState();
    nama_pembeli = TextEditingController();
    no_hp = TextEditingController();
    textController3 = TextEditingController();
    textController4 = TextEditingController();
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
          'Pengiriman',
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
        child: loading? buildLoadingDetailSales() : SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 24, 16, 16),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Detail Pembeli',
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.secondaryColor,
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          loading ? Shimmer.fromColors(
                            baseColor: Color(0xffD8D8D8),
                            highlightColor: Color(0xffEDEDED),
                            enabled: true,
                            child: Container(
                              color: Colors.white,
                              width: MediaQuery.of(context).size.width,
                              height: 50,),
                          ) :    Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nama pembeli',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              TextFormField(
                                controller: nama_pembeli,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'John Doe',
                                  hintStyle:
                                  FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.fieldColor,
                                  suffixIcon: InkWell(
                                    onTap: ()async{
                                      final PhoneContact contact = await FlutterContactPicker.pickPhoneContact();
                                      no_hp?.text = contact.phoneNumber!.number.toString();
                                      nama_pembeli?.text = contact.fullName.toString();
                                    },
                                    child: Icon(
                                      Icons.contacts,
                                      size: 18,
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    size: 18,
                                  ),
                                ),
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'No HP pembeli',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                TextFormField(
                                  controller: no_hp,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: '08XXXXXXXXX',
                                    hintStyle:
                                    FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: FlutterFlowTheme.fieldColor,
                                    prefixIcon: Icon(
                                      Icons.phone,
                                      size: 16,
                                    ),
                                  ),
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                loading ? Shimmer.fromColors(
                                  baseColor: Color(0xffD8D8D8),
                                  highlightColor: Color(0xffEDEDED),
                                  enabled: true,
                                  child: Container(
                                    color: Colors.white,
                                    width: 100,
                                    height: 10,),
                                ) : Text(
                                  'Alamat tujuan',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                TextFormField(
                                  controller: textController3,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: 'Pilih alamat',
                                    hintStyle:
                                    FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: FlutterFlowTheme.fieldColor,
                                    suffixIcon: InkWell(
                                        onTap: (){ Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SalesAddress(uuid: widget.uuid,),
                                          ),
                                        );
                                        AuthRepository().deleteSecureData('alamat');
                                        },
                                        child: Icon(Icons.location_searching, size: 18,)),
                                    prefixIcon: Icon(
                                      Icons.location_on,
                                      size: 18,
                                    ),
                                  ),
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                loading ? Shimmer.fromColors(
                                  baseColor: Color(0xffD8D8D8),
                                  highlightColor: Color(0xffEDEDED),
                                  enabled: true,
                                  child: Container(
                                    color: Colors.white,
                                    width: 100,
                                    height: 10,),
                                ) : Text(
                                  'Pesanan',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: loading ? Shimmer.fromColors(
                                        baseColor: Color(0xffD8D8D8),
                                        highlightColor: Color(0xffEDEDED),
                                        enabled: true,
                                        child: Container(
                                          color: Colors.white,
                                          width: 100,
                                          height: 10,),
                                      ) :  Container(
                                        width: 64,
                                        height: 64,
                                        child: ListView.builder(
                                            itemCount: 1,
                                            itemBuilder: (context, snap){
                                              final listImage = salesDetailResponses?.images[snap];
                                              image = salesDetailResponses?.images[0].value;
                                              return Image.network(
                                                '${image}',
                                                width: 64,
                                                height: 64,
                                                fit: BoxFit.cover,
                                              );
                                            }
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8, 0, 0, 0),
                                        child: loading ? Shimmer.fromColors(
                                          baseColor: Color(0xffD8D8D8),
                                          highlightColor: Color(0xffEDEDED),
                                          enabled: true,
                                          child: Container(
                                            color: Colors.white,
                                            width: 100,
                                            height: 10,),
                                        ) : Text(
                                          '${salesDetailResponses?.name}',
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                      itemCount == 1 ? Container() :  FlutterFlowIconButton(
                                          borderColor: Colors.transparent,
                                          borderRadius: 30,
                                          borderWidth: 1,
                                          buttonSize: 44,
                                          icon: Icon(
                                            Icons.remove_circle,
                                            color:
                                            FlutterFlowTheme.primaryColor,
                                            size: 20,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              itemCount--;
                                              int price_ = int.parse(price);
                                              totalfee = price_ * itemCount;
                                              totalfeeCurrency = currencyFormatter.format(totalfee);
                                            });
                                          },
                                        ),
                                        Text(
                                          '${itemCount.toString()}',
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                          ),
                                        ),
                                        FlutterFlowIconButton(
                                          borderColor: Colors.transparent,
                                          borderRadius: 30,
                                          borderWidth: 1,
                                          buttonSize: 44,
                                          icon: Icon(
                                            Icons.add_circle,
                                            color:
                                            FlutterFlowTheme.primaryColor,
                                            size: 20,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              itemCount++;
                                              int price_ = int.parse(price);
                                              totalfee = price_ * itemCount;
                                              totalfeeCurrency = currencyFormatter.format(totalfee);
                                            });
                                          },
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Catatan pesanan',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                TextFormField(
                                  controller: textController4,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: 'Warna, model, packing, dll.',
                                    hintStyle:
                                    FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: FlutterFlowTheme.fieldColor,
                                    prefixIcon: Icon(
                                      Icons.notes,
                                      size: 18,
                                    ),
                                  ),
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                  ),
                                  keyboardType: TextInputType.multiline,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                     Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.secondaryColor,
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Alamat Pickup',
                                  style: FlutterFlowTheme.subtitle3.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontSize: 14
                                  ),
                                ),
                                SizedBox(height: 10,),
                                loading ? Shimmer.fromColors(
                                  baseColor: Color(0xffD8D8D8),
                                  highlightColor: Color(0xffEDEDED),
                                  enabled: true,
                                  child: Container(
                                    color: Colors.white,
                                    width: 100,
                                    height: 10,),
                                ) : salesDetailResponses?.supplierAddressNotes != null?  Text(
                                  '${salesDetailResponses?.supplierAddressAddress}\n${salesDetailResponses?.supplierAddressNotes}',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                  ),
                                ) : Text(
                                  '${salesDetailResponses?.supplierAddressAddress}',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Text(
                                  'Metode pengiriman',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                CheckboxListTile(
                                  value: checkboxListTileValue1,
                                  onChanged: (newValue) => setState(
                                          () {
                                            checkboxListTileValue1 = newValue!;
                                            checkboxListTileValue2 = false;
                                            checkboxListTileValue3 = false;
                                          } ),
                                  title: Text(
                                    'Ambil Sendiri',
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                  tileColor: Color(0xFFF5F5F5),
                                  dense: false,
                                  controlAffinity:
                                  ListTileControlAffinity.trailing,
                                ),
                                CheckboxListTile(
                                  value: checkboxListTileValue2,
                                  onChanged: (newValue) => setState(
                                          () {
                                            checkboxListTileValue2 = newValue!;
                                            checkboxListTileValue1 = false;
                                            checkboxListTileValue3 = false;
                                          } ),
                                  title: Text(
                                    'Kurir Toko',
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                  tileColor: Color(0xFFF5F5F5),
                                  dense: false,
                                  controlAffinity:
                                  ListTileControlAffinity.trailing,
                                ),
                                InkWell(
                                  onTap: (){

                                  },
                                  child: CheckboxListTile(
                                    value: checkboxListTileValue3,
                                    onChanged: (newValue) => setState(
                                            ()  {
                                              checkboxListTileValue3 = newValue!;
                                              AuthRepository().deleteSecureData('nameEkspedisi');
                                              AuthRepository().deleteSecureData('serviceEkspedisi');
                                              AuthRepository().deleteSecureData('value');
                                              checkboxListTileValue2 = false;
                                              checkboxListTileValue1 = false;
                                              if(checkboxListTileValue3 = true){
                                                print(salesDetailResponses?.supplierAddressShipmentCityId);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => ServiceEKspedisi(uuid: widget.uuid, weight: 1,
                                                      ekspedisi: salesDetailResponses?.shippingExpeditionServices, buyerCityId: city_id_buyer, supCityId:  cityShipment,),
                                                  ),
                                                );
                                              }
                                              else{

                                              }
                                            } ),
                                    title: Text(
                                      'Ekspedisi',
                                      style: FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    subtitle: nameEkspedisi!=null ? checkboxListTileValue3 != false? Text(
                                      '$nameEkspedisi $service',
                                      style: FlutterFlowTheme.bodyText3.override(
                                        fontFamily: 'Poppins',
                                      ),
                                    ) :Text(
                                      '',
                                    ) : Text(
                                      '') ,
                                    tileColor: Color(0xFFF5F5F5),
                                    dense: false,
                                    controlAffinity:
                                    ListTileControlAffinity.trailing,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Harga',
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Harga Produk',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                             loading ? Shimmer.fromColors(
                               baseColor: Color(0xffD8D8D8),
                               highlightColor: Color(0xffEDEDED),
                               enabled: true,
                               child: Container(
                                 color: Colors.white,
                                 width: 100,
                                 height: 10,),
                             ) : Text(
                                'Rp${priceCurrency.replaceAll('IDR', '').replaceAll(',00', '')}',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Ongkir',
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                              ),
                            ),
                           priceEkspedisi != null ? Text(
                              'Rp${priceEkspedisiFormat.replaceAll('IDR', '').replaceAll(',00', '')}',
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                              ),
                            ) : Text(
                             'Gratis',
                             style: FlutterFlowTheme.bodyText1.override(
                               fontFamily: 'Poppins',
                             ),
                           )
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Pembayaran',
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                color: FlutterFlowTheme.moGaweGreen,
                              ),
                            ),
                            loading ? Shimmer.fromColors(
                              baseColor: Color(0xffD8D8D8),
                              highlightColor: Color(0xffEDEDED),
                              enabled: true,
                              child: Container(
                                color: Colors.white,
                                width: 100,
                                height: 10,),
                            ) :  Text(
                              'Rp${totalfeeCurrency.replaceAll('IDR', '').replaceAll(',00', '')}',
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                color: FlutterFlowTheme.moGaweGreen,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                    child: CheckboxListTile(
                      value: checkboxListTileValue4,
                      onChanged: (newValue) =>
                          setState(() => checkboxListTileValue4 = newValue!),
                      title: Text(
                        'Kirim sebagai dropshipper',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                        ),
                      ),
                      tileColor: Color(0xFFF5F5F5),
                      dense: false,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                checkboxListTileValue4 != true ? Container(): Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nama Pengirim',
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                              ),
                            ),
                            TextFormField(
                              controller: resellername,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: 'John Doe',
                                hintStyle:
                                FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,

                              ),
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding:
                          EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'No HP Pengirim',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              TextFormField(
                                controller: resellerphone,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: '08XXXXXXXXX',
                                  hintStyle:
                                  FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,

                                ),
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                          EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Alamat Pengirim',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              TextFormField(
                                controller: reselleralamat,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'Alamat',
                                  hintStyle:
                                  FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,

                                ),
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 24, 16, 16),
                    child: FFButtonWidget(
                      onPressed: () async{
                        print('Button pressed ...');
                        try {
                          Fluttertoast.showToast(msg: "Loading...");
                          await AuthRepository().checkout(
                              widget.uuid,
                              nama_pembeli?.text,
                              no_hp?.text,
                              textController3.text,
                              lat,
                              lng,
                              itemCount,
                              'Logistic',
                              double.parse(priceEkspedisi),
                              provinceIdShipment,
                              provinceShipmentName,
                              cityShipment,
                              cityShipmentName,
                              estmax,
                              estmin,
                              price,
                              totalfee,
                              salesDetailResponses?.commission,
                              0,
                              checkboxListTileValue4 != false ? resellername
                                  .text :
                              salesDetailResponses?.supplierAddressName,
                              resellerphone.text,
                              alamat,
                              'midtrans',
                              '',
                              'not yet',
                              '',
                              token);
                          Fluttertoast.showToast(msg: "Berhasil");
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShipmentDetail(),
                            ),
                          );
                        } catch(e){
                          Fluttertoast.showToast(msg: '$e');
                        }
                      },
                      text: 'Kirim Tagihan',
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

