import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mogawe/core/data/response/pesona/certificate_response.dart';
import 'package:mogawe/core/data/response/pesona/detail_pesona_response.dart';
import 'package:mogawe/core/data/response/pesona/pesona_response.dart';
import 'package:mogawe/core/data/response/pesona/pesona_response_object.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/modules/pesona/page/acreditation_page.dart';
import 'package:mogawe/modules/pesona/page/detail_pesona_page.dart';
import 'package:mogawe/modules/pesona/screen/scoring_screen.dart';
import 'package:shimmer/shimmer.dart';

class PesonaPage extends StatefulWidget {
  List<Object> object;
  List<PesonaResponsesObject> listPesona;
  PesonaPage({required this.object, required this.listPesona});

  @override
  _PesonaPageState createState() => _PesonaPageState();
}

class _PesonaPageState extends State<PesonaPage> {
  bool _loadingButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var token;
  var res;
  int length_data =6;
  bool loading = false;
  PesonaResponses? pesonaResponses;
  DetailPesonaResponses? detailPesonaResponses;
  bool loadingPage = false, loadingall = false;
  List<PesonaResponses> pesonaItem =[];

  Future getdata() async{
    setState(() {
      loading = true;

    });

    token = await AuthRepository().readSecureData('token');

    setState(() {

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
          _buildCertificatesList(widget.object)

        ],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: PageView.builder(
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              double convertCurrency = widget.listPesona[index % widget.listPesona.length].minimumjob ?? 0;
              var currencyFormatter = NumberFormat.currency(locale: 'ID');
              var minimum = currencyFormatter.format(convertCurrency);
              return _buildItemPesona( widget.listPesona[index %  widget.listPesona.length], index, minimum);
            }),
      ),
    );
  }

  Widget _buildCertificatesList(List<Object> listPesona) {
    print(listPesona);
    int limitCertificate = 4;
    List<Widget> listCertificateWidget = <Widget>[];
    int counter = 0;
    int pesonaTakenCounter = 0;

    for (var i = 0; i < listPesona.length; i++) {
      print('ini length ${listPesona.length}');
      if(listPesona[i].status != ""){
        if (counter < limitCertificate){
          pesonaTakenCounter++;
          listCertificateWidget.add(_buildCertificateItem(listPesona[i]));
        }
        counter++;
      }
    }

    int sisaPesona = counter - limitCertificate;

    if (counter > limitCertificate){
      listCertificateWidget.add(Text(" +$sisaPesona"));
    } else {
      listCertificateWidget.add(SizedBox());
    }

    return pesonaTakenCounter == 0 ?
    Container()
        : GestureDetector(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScoringScreen(),
            ),
          );
        },
        child: Row(children: listCertificateWidget,));
  }

  Widget _buildCertificateItem(Object pesona) {
    print(pesona.status);
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
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
      child: Image.network(
        pesona.iconUrl ?? "",
        color: pesona.status == 'pending'
            ? FlutterFlowTheme.moGaweYellow
            : FlutterFlowTheme.moGaweGreen,
        width: 20,
        height: 20,
      ),
    );
  }

  Widget _buildItemPesona(PesonaResponsesObject pesona, int index, minimum) {
    return Stack(
      alignment: AlignmentDirectional(0, 1),
      children: [
        Align(
          alignment: AlignmentDirectional(0, 0),
          child: Image.network(
            '${pesona.jobpic}',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 48),
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.25,
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
                              child: Image.network(
                                '${pesona.iconUrl}', width: 24, color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                            child: Text(
                              '${pesona.name}',
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
                        EdgeInsetsDirectional.fromSTEB(4, 16, 0, 0),
                        child: Text(
                          '${pesona.desc}',
                          maxLines: 2,
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
                                              Text(
                                                '${pesona.potentialJob} potensial jobs',
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
                                              Text(
                                                'Rp${minimum.replaceAll('IDR', '').replaceAll(',00', '')}/day',
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPesonaPage(uuidJob: pesona.uuidJob ?? "", isFromBanner: false,),
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
          ),
        )
      ],
    );
  }
}
