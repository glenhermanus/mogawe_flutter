
import 'package:mogawe/core/data/response/hire_me/hire_me_sales_response.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_drop_down.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_icon_button.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mogawe/modules/auth/repositories/auth_repository.dart';
import 'package:mogawe/modules/hire_me/sales/favorite_page.dart';

class HireMeSalesPage extends StatefulWidget {
  HireMeSalesPage({Key? key}) : super(key: key);

  @override
  _HireMeSalesPageState createState() => _HireMeSalesPageState();
}

class _HireMeSalesPageState extends State<HireMeSalesPage> {
  String? dropDownValue;
  TextEditingController? textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading =false;
  var token;
  HireMeSalesResponses? hireMeSalesResponses;


  Future getdata() async{
    setState(() {
      loading = true;

    });

    token = await AuthRepository().readSecureData('token');
    hireMeSalesResponses = await AuthRepository().hiremeSalesdata(token);

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    getdata();
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
          'Gawean Jualan',
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
              buttonSize: 40,
              icon: Icon(
                Icons.favorite,
                color: FlutterFlowTheme.primaryColor,
                size: 24,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoriteHireMeSalesPage(),
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
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: FlutterFlowTheme.fieldColor,
                        prefixIcon: Icon(
                          Icons.search,
                          size: 16,
                        ),
                      ),
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                    child: FlutterFlowDropDown(
                      options: ['Semua Kategori'].toList(),
                      onChanged: (val) => setState(() => dropDownValue = val),
                      width: 160,
                      height: 40,
                      textStyle: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                      ),
                      fillColor: FlutterFlowTheme.fieldColor,
                      elevation: 2,
                      borderColor: Color(0x00515151),
                      borderWidth: 0,
                      borderRadius: 8,
                      margin: EdgeInsetsDirectional.fromSTEB(8, 4, 8, 4),
                      hidesUnderline: true,
                    ),
                  )
                ],
              ),
            ),
           loading ? CircularProgressIndicator() : Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                child: GridView.builder(
                  itemCount: hireMeSalesResponses?.object.length,
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.55,
                  ),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, snap){
                    final lista = hireMeSalesResponses?.object[snap];

                    return Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: Color(0xFFF5F5F5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            alignment: AlignmentDirectional(1, -1),
                            children: [
                              Image.network(
                                '${lista?.imageUrl}',
                                width: double.infinity,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 8, 8, 0),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.secondaryColor,
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: lista?.isFavorite != true ? Icon(
                                    Icons.favorite,
                                    color: Color(0xFF737373),
                                    size: 24,
                                  ) : Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 24,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${lista?.name}',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 8, 0, 0),
                                  child: Text(
                                    'Harga Produk',
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                      fontSize: 11,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Rp${lista!.price?.toString().replaceAll('.', '')}',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 8, 0, 0),
                                  child: Text(
                                    'Komisi',
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                      fontSize: 11,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Rp${lista.commission?.toString().replaceAll('.', '')}',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.moGaweGreen,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),

                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
