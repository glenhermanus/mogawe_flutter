import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mogawe/core/data/response/pesona/detail_pesona_response.dart';
import 'package:mogawe/core/data/response/pesona/pesona_response.dart';
import 'package:mogawe/core/data/response/pesona/pesona_response_object.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/modules/pesona/acreditation_page.dart';
import 'package:mogawe/modules/pesona/bloc/pesona_bloc.dart';
import 'package:mogawe/modules/pesona/bloc/pesona_event.dart';
import 'package:mogawe/modules/pesona/bloc/pesona_state.dart';
import 'package:mogawe/modules/pesona/detail_pesona_page.dart';
import 'package:mogawe/modules/profile/widget/loading/build_pickup_address_loading.dart';
import 'package:mogawe/utils/ui/animation/bounce_tap.dart';

class PesonaScreenScreen extends StatefulWidget {
  const PesonaScreenScreen({Key? key}) : super(key: key);

  @override
  _PesonaScreenScreenState createState() => _PesonaScreenScreenState();
}

class _PesonaScreenScreenState extends State<PesonaScreenScreen> {
  late PesonaBloc bloc;
  late List<PesonaResponsesObject> listPesona;
  var token;

  getToken()async{
    token = await AuthRepository().readSecureData('token');
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   bloc = PesonaBloc();
  //   bloc.add(GetPesonaEvent());
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = PesonaBloc();
    bloc.add(GetPesonaEvent());
    getToken();
  }
  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }


  Widget blocListener(Widget child) {
    return BlocListener(
      bloc: bloc,
      listener: (ctx, state) => print("State : $state"),
      child: child,
    );
  }

  Widget blocBuilder() {
    return BlocBuilder(
      bloc: bloc,
      builder: (ctx, state) {
        if (state is ShowLoadingPesonaState) {
          print("State : $state");
          return buildPickUpAddressLoading();
        }
        if (state is ShowListPesonaState) {
          listPesona = state.data;

          return PageView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                double convertCurrency = listPesona[index % listPesona.length].minimumjob ?? 0;
                var currencyFormatter = NumberFormat.currency(locale: 'ID');
                var minimum = currencyFormatter.format(convertCurrency);
                return _buildItemPesona(listPesona[index % listPesona.length], index, minimum);
              });
        }
        if (state is ShowEmptyListPesonaState) {
          return Container();
        }
        if (state is ShowErrorPesonaState) {
          print("error ads" + state.message);
          return Container();
        }
        return Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: blocListener(blocBuilder()),
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
             DetailPesonaResponses detailPesonaResponses = await AuthRepository().detailpesonadata(token, pesona.uuidJob);
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
          ),
        )
      ],
    );
  }


}
