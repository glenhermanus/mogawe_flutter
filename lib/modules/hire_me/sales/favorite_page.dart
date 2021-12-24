
import 'package:flutter/material.dart';
import 'package:mogawe/core/data/response/hire_me/favorite_hire_me_sales_response.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';

class FavoriteHireMeSalesPage extends StatefulWidget {
  FavoriteHireMeSalesPage({Key? key}) : super(key: key);

  @override
  _FavoriteHireMeSalesPageState createState() => _FavoriteHireMeSalesPageState();
}

class _FavoriteHireMeSalesPageState extends State<FavoriteHireMeSalesPage> {
  String? dropDownValue;
  TextEditingController? textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading =false;
  var token;
  FavHireMeSalesResponses? favHireMeSalesResponses;


  Future getdata() async{
    setState(() {
      loading = true;

    });

    token = await AuthRepository().readSecureData('token');
    favHireMeSalesResponses = await AuthRepository().favhiremeSalesdata(token);

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
          'Favorite',
          style: FlutterFlowTheme.subtitle1.override(
            fontFamily: 'Poppins',
            color: Colors.black
          ),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: FlutterFlowTheme.secondaryColor,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            loading ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.topCenter,
                  child: CircularProgressIndicator()),
            ) : favHireMeSalesResponses?.object.length != 0 ? Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                child: GridView.builder(
                    itemCount: favHireMeSalesResponses?.object.length,
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.55,
                    ),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, snap){
                      final lista = favHireMeSalesResponses?.object[snap];

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
                                  child: InkWell(
                                    onTap: ()async{

                                      if(lista?.isFavorite != true){
                                        var res = await AuthRepository().postfavhiremeSalesdata(lista?.isFavorite, token, lista?.uuidobj);
                                        setState(() {
                                          lista?.isFavorite = true;
                                        });
                                      }else{
                                        var del = await AuthRepository().deletefavhiremeSalesdata(lista?.isFavorite, token, lista?.uuidobj);
                                        setState(() {
                                          lista?.isFavorite = false;
                                        });
                                      }

                                    },
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
            ) : Center(child: Text('Anda belum memilih produk favorite')),
          ],
        ),
      ),
    );
  }
}
