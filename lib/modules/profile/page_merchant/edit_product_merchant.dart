import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';

class EditProductMerchant extends StatefulWidget {
  const EditProductMerchant({Key? key}) : super(key: key);

  @override
  _EditProductMerchantState createState() => _EditProductMerchantState();
}

class _EditProductMerchantState extends State<EditProductMerchant> {
  bool _loadingButton = false;
  TextEditingController textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.secondaryColor,
        iconTheme: IconThemeData(color: FlutterFlowTheme.tertiaryColor),
        automaticallyImplyLeading: true,
        title: Text(
          'Edit Produk',
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
                  DottedBorder(
                    borderType: BorderType.RRect,
                    strokeWidth: 1,
                    color: Colors.black54,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Icon(
                          Icons.add, color: Colors.red,
                        ),
                      ),
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
                  Text('Gambar Produk *'),
                  SizedBox(height: 10,),
                  Container(
                    decoration: BoxDecoration(),
                    child: TextFormField(
                      controller: textController,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'search',
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
                      controller: textController,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'search',
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
                      controller: textController,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'search',
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
                      controller: textController,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'search',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.home_outlined),
                          SizedBox(width: 10,),
                          Text('Alamat PickUp*'),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios, size: 14,)
                    ],
                  ),
                  SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.list),
                          SizedBox(width: 10,),
                          Text('Kategori *'),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios, size: 14,)
                    ],
                  ),
                  SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info_outline),
                          SizedBox(width: 10,),
                          Text('Produk Berbahaya *'),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios, size: 14,)
                    ],
                  ),
                  SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.attach_money_sharp),
                          SizedBox(width: 10,),
                          Text('Harga *'),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios, size: 14,)
                    ],
                  ),
                  SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.money_sharp),
                          SizedBox(width: 10,),
                          Text('Komisi *'),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios, size: 14,)
                    ],
                  ),
                  SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.category),
                          SizedBox(width: 10,),
                          Text('Stok *'),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios, size: 14,)
                    ],
                  ),
                  SizedBox(height: 16,),
                  Row(
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
                  SizedBox(height: 16,),

                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 16),
            child: FFButtonWidget(
              onPressed: () {

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
    );
  }
}
