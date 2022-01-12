import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mogawe/core/data/response/home_content/Certificate.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/modules/hire_me/hire_me_page.dart';
import 'package:mogawe/modules/home/bloc/home_bloc.dart';
import 'package:mogawe/modules/home/bloc/home_event.dart';
import 'package:mogawe/modules/home/bloc/home_state.dart';
import 'package:mogawe/utils/services/currency_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuildMogawersTarget extends StatefulWidget {
  const BuildMogawersTarget({Key? key}) : super(key: key);

  @override
  State<BuildMogawersTarget> createState() => _BuildMogawersTargetState();
}

class _BuildMogawersTargetState extends State<BuildMogawersTarget> {
  late HomeBloc bloc;

  int _target = 0;
  bool loading = false;
  bool _loadingButton1 = false;

  // Text Editing Controller list
  final TextEditingController _targetEditingController =
      TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = HomeBloc();
    bloc.add(GetCertificate());
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
        if (state is ShowLoadingCertificate) {
          print("State : $state");
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ShowHomeCertificate) {
          print("certificate size is ${state.list[0].myCertificates.length}");
          if (state.list[0].myCertificates == null || state.list[0].myCertificates.length == 0) {
            return Container();
          } else {
            return _buildCertificatesList(state.list[0].myCertificates);
          }
        }
        if (state is ShowErrorHomeState) {
          print("error certificate" + state.message);
          return Container();
        }
        return Container();
      },
    );
  }

  void getDailyTarget() async {
    setState(() {
      loading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    final target = prefs.getInt('target');
    log(target.toString());
    _target = target ?? 200000;
    setState(() {
      loading = false;
    });
  }

  void saveDailyTarget(int target) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('target', target);
  }

  @override
  void initState() {
    super.initState();
    getDailyTarget();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: FlutterFlowTheme.fieldColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 64,
              child: Stack(
                alignment: AlignmentDirectional(0, 0),
                children: [
                  Container(
                    width: double.infinity,
                    height: 160,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.secondaryColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 32,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.moGaweGreen,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    '20%',
                    style: FlutterFlowTheme.subtitle1.override(
                      fontFamily: 'Poppins',
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kejar sisa target hari ini:',
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            loading ? "--" : stringtoRupiah(_target),
                            style: FlutterFlowTheme.title1.override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Center(
                                    child: AlertDialog(
                                      content: Container(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextFormField(
                                              keyboardType: TextInputType
                                                  .numberWithOptions(
                                                  decimal: true),
                                              controller:
                                              _targetEditingController,
                                              validator: (value) {},
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          child: Text("Batal"),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                        TextButton(
                                          child: Text("Simpan"),
                                          onPressed: () => {
                                            saveDailyTarget(int.parse(
                                                _targetEditingController
                                                    .text)),
                                            Navigator.pop(context),
                                            setState(() {
                                              _target = int.parse(
                                                  _targetEditingController
                                                      .text);
                                            }),
                                            _targetEditingController.text =
                                            "",
                                          },
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            icon: Icon(
                              Icons.edit_rounded,
                              size: 20,
                            ),
                            color: FlutterFlowTheme.tertiaryColor,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          setState(() => _loadingButton1 = true);
                          try {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HireMePage(),
                              ),
                            );
                          } finally {
                            setState(() => _loadingButton1 = false);
                          }
                        },
                        text: 'Tambah Gawean',
                        options: FFButtonOptions(
                          width: 160,
                          height: 32,
                          color: FlutterFlowTheme.primaryColor,
                          textStyle: FlutterFlowTheme.subtitle2.override(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 12,
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
                      padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                      child: Text(
                        'Pesonamu:',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                        ),
                      ),
                    ),
                    blocListener(blocBuilder())
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCertificatesList(List<Certificate> listPesona) {
    int limitCertificate = 4;
    List<Widget> listCertificateWidget = <Widget>[];
    int counter = 0;

    for (var i = 0; i < listPesona.length; i++) {
      if(listPesona[i].status != ""){
        if (counter < limitCertificate){
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

    return Row(children: listCertificateWidget,);
  }

  Widget _buildCertificateItem(Certificate pesona) {
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
        color: pesona.status == "pending" ? FlutterFlowTheme.moGaweYellow : FlutterFlowTheme.moGaweGreen,
        width: 20,
        height: 20,
      ),
    );
  }
}
