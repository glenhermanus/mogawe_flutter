import 'package:flutter/material.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';

class ShipmentDetail extends StatefulWidget {
  const ShipmentDetail({Key? key}) : super(key: key);

  @override
  _ShipmentDetailState createState() => _ShipmentDetailState();
}

class _ShipmentDetailState extends State<ShipmentDetail> {
  bool _loadingButton = false;
  TextEditingController no_tagihan = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.secondaryColor,
        iconTheme: IconThemeData(color: FlutterFlowTheme.tertiaryColor),
        automaticallyImplyLeading: true,
        title: Text(
          'Detail Pembelian',
          style: FlutterFlowTheme.subtitle1.override(
            fontFamily: 'Poppins',
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFF5F5F5),
      body: ListView(
        children: [
          Center(
            child: Image.asset('assets/images/im_no_job.png', ),
          ),
          SizedBox(height: 20,),
          Text('Pembayaran dan pesanan sudah diteruskan ke\npembali. Yuk kabari pembeli untuk menyelesaikan\npembayarannya ya.',
          textAlign: TextAlign.center, style: FlutterFlowTheme.subtitle2,),
          SizedBox(height: 20,),
          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FFButtonWidget(
                      onPressed: () async{
                        print('Button pressed ...');
                      },
                      text: 'Chat Pembeli',
                      options: FFButtonOptions(
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
                    FFButtonWidget(
                      onPressed: () async{
                        print('Button pressed ...');
                      },
                      text: 'Lanjut Belanja',
                      options: FFButtonOptions(
                        height: 56,
                        color: FlutterFlowTheme.secondaryColor,
                        textStyle: FlutterFlowTheme.subtitle2.override(
                          fontFamily: 'Poppins',
                          color: FlutterFlowTheme.primaryColor,
                        ),
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.primaryColor,
                          width: 1,
                        ),
                        borderRadius: 20,
                      ),
                      loading: _loadingButton,
                    )
                  ],
                ),
                SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      Text('Informasi Tagihan', style: FlutterFlowTheme.bodyText1.copyWith(color: Colors.black,
                      fontWeight: FontWeight.bold, fontSize: 16),),
                      SizedBox(height: 20,),
                      Text(
                        'No. Tagihan',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(height: 5,),
                      TextFormField(
                        controller: no_tagihan,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'INV-Mo-202020202',
                          hintStyle:
                          FlutterFlowTheme.bodyText2.override(
                            fontFamily: 'Poppins',
                            color: Colors.black26
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black26,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10)
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
                      ),
                      SizedBox(height: 15,),
                      Text(
                        'Status Tagihan',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(height: 5,),
                      TextFormField(
                        controller: no_tagihan,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Menunggu Pembayaran',
                          hintStyle:
                          FlutterFlowTheme.bodyText2.override(
                              fontFamily: 'Poppins',
                              color: Colors.black26
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black26,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10)
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
                      ),
                      SizedBox(height: 15,),
                      Text(
                        'Total Tagihan',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(height: 5,),
                      TextFormField(
                        controller: no_tagihan,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Rp209.000',
                          hintStyle:
                          FlutterFlowTheme.bodyText2.override(
                              fontFamily: 'Poppins',
                              color: Colors.black26
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black26,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10)
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
                      ),
                      SizedBox(height: 20,),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20,),
          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [

                      Text(
                        'No. Transaksi',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(height: 5,),
                      TextFormField(
                        controller: no_tagihan,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: '20220202',
                          hintStyle:
                          FlutterFlowTheme.bodyText2.override(
                              fontFamily: 'Poppins',
                              color: Colors.black26
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black26,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10)
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
                      ),
                      SizedBox(height: 15,),
                      Text(
                        'Glen',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(height: 5,),
                      TextFormField(
                        controller: no_tagihan,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: '08151515\nJl M Kavling\nJakarta Selatan\nIndonesia Kecamatan Tebet',
                          hintStyle:
                          FlutterFlowTheme.bodyText2.override(
                              fontFamily: 'Poppins',
                              color: Colors.black26
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black26,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10)
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
                        maxLines: 4,
                      ),
                      SizedBox(height: 15,),
                      Text(
                        'Tas Rajut Wanita',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(height: 5,),
                      TextFormField(
                        controller: no_tagihan,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Jumlah: 1\nHarga produk: Rp200.000',
                          hintStyle:
                          FlutterFlowTheme.bodyText2.override(
                              fontFamily: 'Poppins',
                              color: Colors.black26
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black26,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10)
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
                        maxLines: 2,
                      ),
                      SizedBox(height: 15,),
                      Text(
                        'Metode Pengiriman',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(height: 5,),
                      TextFormField(
                        controller: no_tagihan,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Total ongkir: Rp9.000',
                          hintStyle:
                          FlutterFlowTheme.bodyText2.override(
                              fontFamily: 'Poppins',
                              color: Colors.black26
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black26,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10)
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
                      ),
                      SizedBox(height: 20,),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: FFButtonWidget(
              onPressed: () async{
                print('Button pressed ...');
              },
              text: 'Selesai',
              options: FFButtonOptions(
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
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}
