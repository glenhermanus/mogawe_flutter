import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:mogawe/core/data/response/pesona/detail_pesona_response.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/modules/pesona/bloc/PersonaBloc.dart';
import 'package:mogawe/modules/pesona/bloc/PersonaEvent.dart';
import 'package:mogawe/modules/pesona/bloc/PersonaState.dart';
import 'package:mogawe/modules/pesona/widgets/loading/detail_persona_loading.dart';

class DetailPesonaPage extends StatefulWidget {
  final String uuidJob;
  DetailPesonaPage({required this.uuidJob});

  @override
  _DetailPesonaPageState createState() => _DetailPesonaPageState();
}

class _DetailPesonaPageState extends State<DetailPesonaPage> {
  bool _loadingButton = false;
  late PersonaBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = PersonaBloc();
    bloc.add(GetPersonaDetail(widget.uuidJob));
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

  Widget blockBuilder() {
    return BlocBuilder(
      bloc: bloc,
      builder: (ctx, state) {
        if (state is ShowLoadingPersona) {
          return Center(
            child: buildDetailPersonaLoading(),
          );
        }
        if (state is ShowPersonaDetail) {
          return _buildDetailPersonaBody(state.detailPersona);
        }
        return Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print(widget.detailPesonaResponses?.uuidobj);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),

        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.white,
        title: Text('Detail Verifikasi', style: FlutterFlowTheme.title3, textAlign: TextAlign.center,),
      ),
      backgroundColor: Colors.white,
      body: blocListener(blockBuilder()),
    );
  }

  Widget _buildDetailPersonaBody(DetailPesonaResponses detailPersona){
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network('${detailPersona.jobPicture}', width: MediaQuery.of(context).size.width,
            height: 250, fit: BoxFit.cover,),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${detailPersona.jobName}', style: FlutterFlowTheme.title3.override(
                    fontFamily: 'Poppins',
                    color: Colors.black
                ),),
                SizedBox(height: 5,),
                Text('${detailPersona.desc}', style: FlutterFlowTheme.bodyText1,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: HtmlWidget(
              '${detailPersona.howto}',
              customStylesBuilder: (element){

              },
            ),
          ),
          SizedBox(height: 30,),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 28),
            child: Center(
              child: FFButtonWidget(
                onPressed: (){
                  print(widget.detailPesonaResponses?.uuidJob);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FormLoadingScreen(idTask: widget.detailPesonaResponses?.uuidobj, currentTimeInMillis: 0),
                    ),
                  );
                },
                text: 'Mulai Verifikasi',
                options: FFButtonOptions(
                  height: 48,
                  color: FlutterFlowTheme.primaryColor,
                  textStyle: FlutterFlowTheme.title3.override(
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
            ),
          )
        ],
      ),
    );
  }
}
