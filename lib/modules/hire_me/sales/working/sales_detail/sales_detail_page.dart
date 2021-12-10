import 'package:intl/intl.dart';
import 'package:mogawe/core/data/response/hire_me/sales_detail_response.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_icon_button.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:mogawe/modules/auth/repositories/auth_repository.dart';
import 'package:mogawe/modules/inbox_notif/inbox/chat/chat_page.dart';
import 'package:shimmer/shimmer.dart';

class SalesDetailPage extends StatefulWidget {
  String uuid;
  SalesDetailPage({required this.uuid});

  @override
  _SalesDetailPageState createState() => _SalesDetailPageState();
}

class _SalesDetailPageState extends State<SalesDetailPage> {
  bool _loadingButton1 = false;
  bool _loadingButton2 = false;
  bool _loadingButton3 = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  SalesDetailResponses? salesDetailResponses;
  bool loading =false;
  var token;
  var price, komisi;

  Future getData()async{
    setState(() {
      loading = true;

    });

    token = await AuthRepository().readSecureData('token');
    salesDetailResponses = await AuthRepository().getDetailsales(token, widget.uuid);
    var currencyFormatter = NumberFormat.currency(locale: 'ID');
    price = currencyFormatter.format(salesDetailResponses?.price);
    komisi = currencyFormatter.format(salesDetailResponses?.commission);
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
          'Informasi Produk',
          style: FlutterFlowTheme.subtitle1.override(
            fontFamily: 'Poppins',
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
            child: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30,
              borderWidth: 1,
              buttonSize: 48,
              icon: Icon(
                Icons.chat_rounded,
                color: FlutterFlowTheme.primaryColor,
                size: 24,
              ),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(),
                  ),
                );
              },
            ),
          )
        ],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: FlutterFlowTheme.secondaryColor,
      body: SafeArea(
        child: ListView(

          children: [
            loading? Container(
              width: MediaQuery.of(context).size.width,
              height: 240,
              child: Shimmer.fromColors(
                baseColor: Color(0xffD8D8D8),
                highlightColor: Color(0xffEDEDED),
                enabled: true,
                child: Container(
                  color: Colors.white,
                  width: 100,
                  height: 10,),
              ),
            ) :  Container(
              width: MediaQuery.of(context).size.width,
              height: 240,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                  itemCount: salesDetailResponses?.images.length,
                  itemBuilder: (context, snap){
                  final listImage = salesDetailResponses?.images[snap];
                return Row(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional(1, 1),
                      children: [
                        Image.network(
                          '${listImage?.value}',
                          width: MediaQuery.of(context).size.width,
                          height: 240,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 16),
                          child: FFButtonWidget(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            text: 'Download',
                            icon: Icon(
                              Icons.download_sharp,
                              size: 15,
                            ),
                            options: FFButtonOptions(
                              width: 148,
                              height: 40,
                              color: FlutterFlowTheme.secondaryColor,
                              textStyle: FlutterFlowTheme.subtitle2.override(
                                fontFamily: 'Poppins',
                                color: FlutterFlowTheme.tertiaryColor,
                              ),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: 12,
                            ),
                            loading: _loadingButton1,
                          ),
                        ),

                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 16, 0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.54,
                            height: 240,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: salesDetailResponses?.images.length,
                              itemBuilder: (context, snaps){
                                return Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: 8.0,
                                    height: 8.0,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 2.0),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: snap == snaps
                                            ? Colors.white
                                            : Colors.black26
                                    ),
                                  ),
                                );
                                },
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: 10,)
                  ],
                );
              }),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: loading? Shimmer.fromColors(
                              baseColor: Color(0xffD8D8D8),
                              highlightColor: Color(0xffEDEDED),
                              enabled: true,
                              child: Container(
                                color: Colors.white,
                                width: 100,
                                height: 10,),
                            ) : Text(
                              '${salesDetailResponses?.name}',
                              style: FlutterFlowTheme.title3.override(
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ), 
                          FFButtonWidget(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            text: 'Share',
                            icon: Icon(
                              Icons.share_sharp,
                              size: 16,
                            ),
                            options: FFButtonOptions(
                              width: 130,
                              height: 40,
                              color: FlutterFlowTheme.secondaryColor,
                              textStyle: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Poppins',
                                color: FlutterFlowTheme.primaryColor,
                                fontSize: 12,
                              ),
                              elevation: 0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: 12,
                            ),
                            loading: _loadingButton2,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Terjual',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              Text(
                                '28',
                                style: FlutterFlowTheme.subtitle1.override(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Kamu Menjual',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                Text(
                                  '1',
                                  style: FlutterFlowTheme.subtitle1.override(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Harga rekomendasi',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                            ),
                          ),
                          loading? Shimmer.fromColors(
                            baseColor: Color(0xffD8D8D8),
                            highlightColor: Color(0xffEDEDED),
                            enabled: true,
                            child: Container(
                              color: Colors.white,
                              width: 100,
                              height: 10,),
                          ) : Text(
                            'Rp${price.replaceAll('IDR', '').replaceAll(',00', '')}',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Komisi Penjualan',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.moGaweGreen,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          loading? Shimmer.fromColors(
                            baseColor: Color(0xffD8D8D8),
                            highlightColor: Color(0xffEDEDED),
                            enabled: true,
                            child: Container(
                              color: Colors.white,
                              width: 100,
                              height: 10,),
                          ) : Text(
                            'Rp${komisi.replaceAll('IDR', '').replaceAll(',00', '')}',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.moGaweGreen,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Informasi Produk',
                            style: FlutterFlowTheme.subtitle1.override(
                              fontFamily: 'Poppins',
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: loading? Shimmer.fromColors(
                            baseColor: Color(0xffD8D8D8),
                            highlightColor: Color(0xffEDEDED),
                            enabled: true,
                            child: Container(
                              color: Colors.white,
                              width: 100,
                              height: 10,),
                          ) : Text(
                            '${salesDetailResponses?.desc}',
                            style: FlutterFlowTheme.bodyText2.override(
                              fontFamily: 'Poppins',
                              color: Color(0xFF9F9F9F),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.15,),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 5),
              child: FFButtonWidget(
                onPressed: () {
                  print('Button pressed ...');
                },
                text: 'Checkout\n',
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
                loading: _loadingButton3,
              ),
            )
          ],
        ),
      ),
    );
  }
}
