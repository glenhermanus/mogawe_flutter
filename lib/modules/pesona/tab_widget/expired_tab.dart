import 'package:flutter/material.dart';
import 'package:mogawe/core/data/response/pesona/expired_response.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/modules/form/form_loading_screen.dart';
import 'package:mogawe/modules/pesona/page/detail_pesona_page.dart';
import 'package:mogawe/utils/ui/animation/bounce_tap.dart';

class ExpiredTab extends StatefulWidget {
  final List<ObjectExpired> object;

  const ExpiredTab({Key? key, required this.object}) : super(key: key);

  @override
  _ExpiredTabState createState() => _ExpiredTabState();
}

class _ExpiredTabState extends State<ExpiredTab> {

  alert() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),),
        content: Container(
          height: MediaQuery.of(context).size.height * 0.3,
          child: Column(
            children: [
              SizedBox(height: 10,),
              Image.asset('assets/icon/ic_alert_scor.png', height: 60,),
              SizedBox(height: 25,),
              Text(
                'Maaf kamu belum bisa retake pesona ini sampai tanggal 2 Desember 2021. Coba lagi nanti yaa',
                textAlign: TextAlign.center, style: FlutterFlowTheme.bodyText1.copyWith(fontWeight: FontWeight.w400, color: Colors.black, fontFamily: 'Lato'),
              ),
              SizedBox(height: 25,),
              BounceTap(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.38,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Color(0xffEA2327), width: 1.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Center(
                      child: Text('Mengerti', style: FlutterFlowTheme.title1.copyWith(fontSize: 14, fontWeight: FontWeight.w700, color: FlutterFlowTheme.primaryColor),),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),

      ),
    ));
  }

  void SelectedItem(BuildContext context, item, uuid, status) {
    switch (item) {
      case 0:
        if(status != 'pending'){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormLoadingScreen(idTask: uuid, currentTimeInMillis: DateTime.now().millisecondsSinceEpoch, isPersona: true,),
            ),
          );
        }
        else{
          alert();
        }

        break;
      case 1:
        gotoForm(uuid);
        break;

    }
  }

  gotoForm(id)async{
    var token = await AuthRepository().readSecureData('token');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPesonaPage(
          uuidJob: id,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: widget.object.length,
        itemBuilder: (context, index) {
          return _buildItemPesona( widget.object[index], index);
        });
  }

  Widget _buildItemPesona(ObjectExpired pesona, int index ) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color(0xffc7c7c7))
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: pesona.status == 'pending'
                              ? FlutterFlowTheme.moGaweYellow
                              : FlutterFlowTheme.moGaweGreen,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Image.network('${pesona.iconUrl}', height: 20, color: pesona.status == 'pending'
                              ? FlutterFlowTheme.blackColor
                              : FlutterFlowTheme.secondaryColor,),
                        ),
                      ),
                      SizedBox(width: 21,),
                      Text('${pesona.name}', style: FlutterFlowTheme.title3.copyWith(fontSize: 18),)
                    ],
                  ),
                  Container(
                    width: 20,
                    child: PopupMenuButton<int>(
                      padding: EdgeInsets.zero,
                      color: Colors.white,
                      icon: Icon(Icons.more_vert_rounded, color: Colors.black,),
                      itemBuilder: (context) => [
                        PopupMenuItem<int>(value: 0, child: Row(
                          children: [
                            Icon(Icons.refresh, color: Colors.red, size: 13,),
                            SizedBox(width: 20,),
                            Text('Retake Pesona', style: FlutterFlowTheme.title1.copyWith(fontSize: 10),),
                          ],
                        )),
                        PopupMenuItem<int>(value: 1, child: Row(
                          children: [
                            Icon(Icons.info_outline, color: Colors.red, size: 13,),
                            SizedBox(width: 20,),
                            Text('Detail Pesona', style: FlutterFlowTheme.title1.copyWith(fontSize: 10),),
                          ],
                        ))
                      ],
                      onSelected: (item) => SelectedItem(context, item, pesona.uuidJob, pesona.status),
                    ),
                  )
                ],
              ),
              SizedBox(height: 8,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                decoration: BoxDecoration(
                  color: Color(0xffc7c7c7),
                ),
              ),
              SizedBox(height: 8,),
              Row(
                children: [
                  Column(
                    children: [
                      Text('Score', style: FlutterFlowTheme.bodyText1.copyWith(color: Color(0xff757575)),),
                      Text(pesona.status == 'pending'
                          ?'${pesona.finalScore}*' :'${pesona.finalScore}', style: FlutterFlowTheme.title2,),
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.4,),
                  Column(
                    children: [
                      Text('Median', style: FlutterFlowTheme.bodyText1.copyWith(color: Color(0xff757575))),
                      Text('${pesona.averageScore}', style: FlutterFlowTheme.title2),
                    ],
                  )
                ],
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.access_time_outlined, color: Color(0xff757575), size: 15,),
                      SizedBox(width: 6,),
                      Text('Completed at ', style: FlutterFlowTheme.bodyText3.copyWith(color: Color(0xff757575)),)
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: pesona.status == 'pending'
                          ? FlutterFlowTheme.moGaweYellow
                          : FlutterFlowTheme.moGaweGreen,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        pesona.status == 'pending' ? 'Pending' : pesona.status == 'verified' ?
                        'Completed' : 'Expired', style: FlutterFlowTheme.bodyText3.copyWith(color: pesona.status == 'pending'
                          ? FlutterFlowTheme.blackColor
                          : FlutterFlowTheme.secondaryColor),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

