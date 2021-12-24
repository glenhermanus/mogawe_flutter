import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
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
  var token;


  // Text Editing Controller list
  final TextEditingController _targetEditingController =
  TextEditingController();

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

  void getToken() async {
    setState(() {
      loading = true;
    });
    token = await AuthRepository().getToken();

    print("OUT >> hey");
    print(token);

    var res = await AuthRepository().getProfile(token);
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
    getToken();
    getDailyTarget();
  }



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
      listener: (ctx, state) => print("$state"),
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
          print("State : $state");
          return ListView.builder(
            itemCount: 3,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (ctx, index) {
              return Container(
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
              );
            },
          );
        }
        if (state is ShowErrorHomeState){
          log(state.message);
        }
        return Container();
      },
    );
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
                        children: [
                          Text(
                            loading ? "--" : stringtoRupiah(_target),
                            style: FlutterFlowTheme.title1.override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                            child: IconButton(
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
                            ),
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
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
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
                            Icons.calculate,
                            color: FlutterFlowTheme.secondaryColor,
                            size: 24,
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.moGaweYellow,
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
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                          child: Text(
                            '+4',
                            style: FlutterFlowTheme.subtitle1.override(
                              fontFamily: 'Poppins',
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
