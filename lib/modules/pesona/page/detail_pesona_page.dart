import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:mogawe/core/data/response/pesona/detail_pesona_response.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/modules/form/form_loading_screen.dart';

class DetailPesonaPage extends StatefulWidget {
  DetailPesonaResponses? detailPesonaResponses;
  DetailPesonaPage({this.detailPesonaResponses});

  @override
  _DetailPesonaPageState createState() => _DetailPesonaPageState();
}

class _DetailPesonaPageState extends State<DetailPesonaPage> {
  bool _loadingButton = false;
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
      body: SafeArea(
        child: ListView(
          children: [
            Image.network('${widget.detailPesonaResponses?.jobPicture}', width: MediaQuery.of(context).size.width,
              height: 250, fit: BoxFit.cover,),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${widget.detailPesonaResponses?.jobName}', style: FlutterFlowTheme.title3.override(
                      fontFamily: 'Poppins',
                    color: Colors.black
                  ),),
                  SizedBox(height: 5,),
                  Text('${widget.detailPesonaResponses?.desc}', style: FlutterFlowTheme.bodyText1,),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: HtmlWidget(
                 '${widget.detailPesonaResponses?.howto}',
                  customStylesBuilder: (element){

                  },
              ),
            ),
            SizedBox(height: 30,),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 28),
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
                  width: 130,
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
            )
          ],
        ),
      ),
    );
  }
}
