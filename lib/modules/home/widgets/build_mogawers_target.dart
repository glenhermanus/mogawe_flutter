import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mogawe/core/data/response/home_content/Certificate.dart';
import 'package:mogawe/core/data/response/home_content/Revenue.dart';
import 'package:mogawe/core/data/response/home_content/gawean_row_model.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/modules/hire_me/hire_me_page.dart';
import 'package:mogawe/modules/home/bloc/home_bloc.dart';
import 'package:mogawe/modules/home/bloc/home_event.dart';
import 'package:mogawe/modules/pesona/pesona_page.dart';
import 'package:mogawe/modules/pesona/screen/pesona_screen.dart';
import 'package:mogawe/utils/services/currency_formatter.dart';
import 'package:mogawe/utils/ui/animation/bounce_tap.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuildMogawersTarget extends StatefulWidget {
  final List<GaweanRowModel> data;
  final BuildContext context;

  const BuildMogawersTarget({Key? key, required this.data, required this.context}) : super(key: key);

  @override
  State<BuildMogawersTarget> createState() => _BuildMogawersTargetState();
}

class _BuildMogawersTargetState extends State<BuildMogawersTarget> {
  int _target = 0;
  bool loading = false;
  bool _loadingButton1 = false;
  static const _locale = 'ID';

  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  var formatter = NumberFormat('#,###,###');

  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;

  final TextEditingController _targetEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _target = widget.data[0].targetRevenue?.targetRevenue ?? 200000;
    });
  }

  @override
  Widget build(BuildContext context) {
    HomeBloc bloc = context.read<HomeBloc>();

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
            _buildProgressRevenueBar(widget.data[0].targetRevenue),
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
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return Center(
                                    child: _showTargetHarianDialog(bloc),
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
                        'Personamu:',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                        ),
                      ),
                    ),
                    _buildCertificatesList(widget.data[0].myCertificates)
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
    int pesonaTakenCounter = 0;

    for (var i = 0; i < listPesona.length; i++) {
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
       _buildPluspesona()
      : GestureDetector(
      onTap: (){
        Navigator.push(
          widget.context,
          MaterialPageRoute(
            builder: (context) => PesonaScreenScreen(),
          ),
        );
      },
        child: Row(children: listCertificateWidget,));
  }

  Widget _buildPluspesona() {
    return BounceTap(
      onTap: (){
        Navigator.push(
          widget.context,
          MaterialPageRoute(
            builder: (context) => PesonaScreenScreen(),
          ),
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Tambah Persona',
            style: FlutterFlowTheme.subtitle2.override(
              fontFamily: 'Poppins',
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
            child: Icon(
              Icons.add_circle,
              color: FlutterFlowTheme.tertiaryColor,
              size: 20,
            ),
          )
        ],
      ),
    );
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
        color: pesona.status == "pending"
            ? FlutterFlowTheme.moGaweYellow
            : FlutterFlowTheme.moGaweGreen,
        width: 20,
        height: 20,
      ),
    );
  }

  Widget _buildProgressRevenueBar(Revenue? revenue) {

    double maxProgressBarHeight = 160.0;
    double dailyTargetPercentage = _convertTargetAndProgressToPercent(revenue?.todayRevenue.toDouble() ?? 0.0, revenue?.targetRevenue.toDouble() ?? 0.0);
    double progressBarHeight = _convertPercentToProgressBarHeight(dailyTargetPercentage, maxProgressBarHeight);

    return Container(
      width: 64,
      child: Stack(
        alignment: AlignmentDirectional(0, 0),
        children: [
          Container(
            width: double.infinity,
            height: maxProgressBarHeight,
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
                  height: progressBarHeight,
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
            "$dailyTargetPercentage%",
            style: FlutterFlowTheme.subtitle1.override(
              fontFamily: 'Poppins',
            ),
          )
        ],
      ),
    );
  }

  double _convertTargetAndProgressToPercent(double progress, double target){
    return (progress / target) * 100.0;
  }

  double _convertPercentToProgressBarHeight(double percent, double maxHeight) {
    return (percent / 100.0) * maxHeight;
  }

  Widget _showTargetHarianDialog(HomeBloc bloc) {
    return AlertDialog(
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Target Harian"),
            TextFormField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(prefixText: _currency),
              onChanged: (string) {
                string = '${_formatNumber(string.replaceAll('.', ''))}';
                _targetEditingController.value = TextEditingValue(
                  text: string,
                  selection: TextSelection.collapsed(offset: string.length),
                );
              },
              controller: _targetEditingController,
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
          onPressed: () {
            _targetEditingController.text = "";
            Navigator.pop(widget.context);
          },
        ),
        TextButton(
          child: Text("Simpan"),
          onPressed: () {
            if(_targetEditingController.text.isNotEmpty) {
              int revenue =
                  int.parse(_targetEditingController.text.replaceAll('.', ''));
              bloc.add(DoUpdateTargetRevenueEvent(revenue));
              setState(() {
                _target = int.parse(
                    _targetEditingController.text.replaceAll('.', ''));
              });
              _targetEditingController.text = "";
              Navigator.pop(widget.context);
            } else {
              Navigator.pop(widget.context);
            }
          },
        )
      ],
    );
  }
}
