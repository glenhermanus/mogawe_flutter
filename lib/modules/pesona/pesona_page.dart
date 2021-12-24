import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mogawe/core/data/response/pesona/detail_pesona_response.dart';
import 'package:mogawe/core/data/response/pesona/pesona_response.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/modules/generator/function_form.dart';
import 'package:mogawe/modules/pesona/acreditation_page.dart';
import 'package:mogawe/modules/pesona/detail_pesona_page.dart';
import 'package:shimmer/shimmer.dart';

class PesonaPage extends StatefulWidget {
  PesonaPage({Key? key}) : super(key: key);

  @override
  _PesonaPageState createState() => _PesonaPageState();
}

class _PesonaPageState extends State<PesonaPage> {
  bool _loadingButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var token;
  var res;

  bool loading = false;
  PesonaResponses? pesonaResponses;
  DetailPesonaResponses? detailPesonaResponses;

  Future getdata() async{
    setState(() {
      loading = true;

    });

    token = await AuthRepository().readSecureData('token');
    pesonaResponses = await AuthRepository().pesonadata(token);

    setState(() {
      print(pesonaResponses?.message);
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getToken();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.primaryColor,
        automaticallyImplyLeading: true,
        title: Text(
          'Pesona',
          style: FlutterFlowTheme.subtitle1.override(
            fontFamily: 'Poppins',
            color: FlutterFlowTheme.secondaryColor,
          ),
        ),
        actions: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                      onTap: (){ Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AcreditationPage(),
                        ),
                      );},
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.moGaweGreen,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 2,
                              color: Color(0x8F515151),
                              offset: Offset(0, 2),
                              spreadRadius: 0,
                            )
                          ],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          Icons.calculate,
                          color: FlutterFlowTheme.secondaryColor,
                          size: 24,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FunctionForm(),
                          ),
                        );
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.moGaweGreen,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 2,
                              color: Color(0x8F515151),
                              offset: Offset(0, 2),
                              spreadRadius: 0,
                            )
                          ],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: FaIcon(
                            FontAwesomeIcons.instagram,
                            color: FlutterFlowTheme.secondaryColor,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.moGaweGreen,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            color: Color(0x8F515151),
                            offset: Offset(0, 2),
                            spreadRadius: 0,
                          )
                        ],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.delivery_dining,
                        color: FlutterFlowTheme.secondaryColor,
                        size: 24,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                      child: Text(
                        '+12',
                        style: FlutterFlowTheme.subtitle1.override(
                          fontFamily: 'Poppins',
                          color: FlutterFlowTheme.secondaryColor,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount:  pesonaResponses?.object.length,
          itemBuilder: (context, snap){
            final list =  pesonaResponses?.object[snap];
            return Stack(
              alignment: AlignmentDirectional(0, 1),
              children: [
                loading ? Shimmer.fromColors(
                  baseColor: Color(0xffD8D8D8),
                  highlightColor: Color(0xffEDEDED),
                  enabled: true,
                  child: Container( width: double.infinity,
                    height: double.infinity,),
                ) : Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Image.network(
                    '${list?.jobpic}',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 48),
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Color(0x00EEEEEE),
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: FlutterFlowTheme.secondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.primaryColor,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          4, 4, 4, 4),
                                      child: loading ? Shimmer.fromColors(
                                        baseColor: Color(0xffD8D8D8),
                                        highlightColor: Color(0xffEDEDED),
                                        enabled: true,
                                        child: Container( width: 20,
                                          height: 5,
                                          color: Colors.white,
                                        ),
                                      ) : Image.network(
                                        '${list?.iconUrl}', width: 24, color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                                    child:  loading ? Shimmer.fromColors(
                                      baseColor: Color(0xffD8D8D8),
                                      highlightColor: Color(0xffEDEDED),
                                      enabled: true,
                                      child: Container( width: 50,
                                        height: 10,
                                      color: Colors.white,
                                      ),
                                    ) : Text(
                                      '${list?.name}',
                                      style: FlutterFlowTheme.subtitle1.override(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                                child: loading ? Shimmer.fromColors(
                                  baseColor: Color(0xffD8D8D8),
                                  highlightColor: Color(0xffEDEDED),
                                  enabled: true,
                                  child: Container( width: 80,
                                    height: 10,
                                    color: Colors.white,
                                  ),
                                ) : Text(
                                  '${list?.desc}',
                                  style: FlutterFlowTheme.bodyText2.override(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 2, 0),
                                        child: Card(
                                          clipBehavior: Clip.antiAliasWithSaveLayer,
                                          color: Color(0xFFF0F0F0),
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                4, 4, 4, 4),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.settings_outlined,
                                                  color: Colors.black,
                                                  size: 16,
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(8, 0, 0, 0),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'Linked to',
                                                        style: FlutterFlowTheme
                                                            .bodyText1
                                                            .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                      loading ? Shimmer.fromColors(
                                                        baseColor: Color(0xffD8D8D8),
                                                        highlightColor: Color(0xffEDEDED),
                                                        enabled: true,
                                                        child: Container( width: 10,
                                                          height: 10,
                                                          color: Colors.white,
                                                        ),
                                                      ) :Text(
                                                        '${list?.potentialJob} potensial hire_me',
                                                        style: FlutterFlowTheme
                                                            .bodyText1
                                                            .override(
                                                          fontFamily: 'Poppins',
                                                          color: FlutterFlowTheme
                                                              .primaryColor,
                                                          fontSize: 10,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            2, 0, 0, 0),
                                        child: Card(
                                          clipBehavior: Clip.antiAliasWithSaveLayer,
                                          color: Color(0xFFF0F0F0),
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                4, 4, 4, 4),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.settings_outlined,
                                                  color: Colors.black,
                                                  size: 16,
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(8, 0, 0, 0),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'Start from',
                                                        style: FlutterFlowTheme
                                                            .bodyText1
                                                            .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                      loading ? Shimmer.fromColors(
                                                        baseColor: Color(0xffD8D8D8),
                                                        highlightColor: Color(0xffEDEDED),
                                                        enabled: true,
                                                        child: Container( width: 10,
                                                          height: 10,
                                                          color: Colors.white,
                                                        ),
                                                      ) : Text(
                                                        'Rp${list?.minimumjob}/day',
                                                        style: FlutterFlowTheme
                                                            .bodyText1
                                                            .override(
                                                          fontFamily: 'Poppins',
                                                          color: FlutterFlowTheme
                                                              .primaryColor,
                                                          fontSize: 10,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 28),
                  child: FFButtonWidget(
                    onPressed: ()async{
                      detailPesonaResponses = await AuthRepository().detailpesonadata(token, list?.uuidJob);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPesonaPage(detailPesonaResponses: detailPesonaResponses,),
                        ),
                      );
                    },
                    text: 'Mulai',
                    options: FFButtonOptions(
                      width: 130,
                      height: 48,
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
            );
          },
        ),
      ),
    );
  }
}
