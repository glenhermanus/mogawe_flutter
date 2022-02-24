import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mogawe/core/data/response/pesona/certificate_response.dart';
import 'package:mogawe/core/data/response/pesona/certificate_response.dart' as Stat;
import 'package:mogawe/core/data/response/pesona/detail_pesona_response.dart';
import 'package:mogawe/core/data/response/pesona/expired_response.dart';
import 'package:mogawe/core/data/response/pesona/expired_response.dart' as Status;
import 'package:mogawe/core/data/response/pesona/pending_response.dart';
import 'package:mogawe/core/data/response/pesona/pesona_response.dart';
import 'package:mogawe/core/data/response/pesona/pesona_response_object.dart';
import 'package:mogawe/core/data/response/pesona/verified_response.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/modules/pesona/page/acreditation_page.dart';
import 'package:mogawe/modules/pesona/page/detail_pesona_page.dart';
import 'package:mogawe/modules/pesona/screen/pesona_screen.dart';
import 'package:mogawe/modules/pesona/tab_widget/all_tab.dart';
import 'package:mogawe/modules/pesona/tab_widget/completed_tab.dart';
import 'package:mogawe/modules/pesona/tab_widget/expired_tab.dart';
import 'package:mogawe/modules/pesona/tab_widget/pending_tab.dart';
import 'package:mogawe/utils/ui/animation/bounce_tap.dart';
import 'package:mogawe/utils/ui/widgets/shimmering_skeleton.dart';
import 'package:shimmer/shimmer.dart';

class ScoringPage extends StatefulWidget {
  List<Object> object;
  List<ObjectPending> objectPending;
  List<ObjectVerif> objectVerif;
  List<ObjectExpired> objectExpired;
  ScoringPage({required this.object, required this.objectPending, required this.objectVerif, required this.objectExpired});

  @override
  _ScoringPageState createState() => _ScoringPageState();
}

class _ScoringPageState extends State<ScoringPage> with SingleTickerProviderStateMixin{
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
  late TabController tabController;
  int currTab = 0;

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
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(handleTabSelection);
    getdata();
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  void handleTabSelection() {
    if (tabController.indexIsChanging ||
        tabController.index != tabController.previousIndex) {
      currTab = tabController.index;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: FlutterFlowTheme.blackColor),
        backgroundColor: FlutterFlowTheme.secondaryColor,
        automaticallyImplyLeading: true,
        title: Text(
          'PesonaKu',
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Poppins',
            fontSize: 20,
            color: FlutterFlowTheme.blackColor
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: BounceTap(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PesonaScreenScreen()
                  ),
                );
              },
              child: Row(
                children: [
                  Icon(Icons.add, color: Colors.red, size: 18,),
                  SizedBox(width: 4,),
                  Text('Pesona', style: FlutterFlowTheme.title3.copyWith(color: Colors.red, fontSize: 14),)
                ],
              ),
            ),
          )
        ],
        centerTitle: false,
        elevation: 4,
      ),
      backgroundColor: FlutterFlowTheme.secondaryColor,
      body: SafeArea(
        child: DefaultTabController(
          length: 4,
          initialIndex: currTab,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 16, bottom: 16, right: 16),
                decoration: BoxDecoration(
                    color: FlutterFlowTheme.secondaryColor,
                    borderRadius: BorderRadius.circular(24)
                ),
                child: TabBar(
                  isScrollable: true,
                  labelStyle: GoogleFonts.getFont(
                    'Roboto',
                  ),
                  indicatorPadding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.symmetric(horizontal: 12),
                  indicatorColor: Colors.transparent,
                  controller: tabController,
                  tabs: [
                    tabItem(0, "All  (${widget.object.length})", ),
                    tabItem(1, "Completed  (${widget.objectVerif.length})",  ),
                    tabItem(2, "Pending  (${widget.objectPending.length})",  ),
                    tabItem(3, "Expired  (${widget.objectExpired.length})",  )
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    AllTab(
                      object: widget.object,
                    ),
                    CompletedTab(
                      object: widget.objectVerif,
                    ),
                    PendingTab(
                      object: widget.objectPending,
                    ),
                    ExpiredTab(
                      object: widget.objectExpired,
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget tabItem(int index, String title,  ) {
    Color colTab;
    Color colText;
    Color border;
    if (index == currTab) {
      colTab = FlutterFlowTheme.primaryColor;
      colText = FlutterFlowTheme.secondaryColor;
      border = Colors.transparent;
    } else {
      colTab = FlutterFlowTheme.secondaryColor;
      colText = FlutterFlowTheme.blackColor;
      border = Color(0xff979797);
    }
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: colTab,
          borderRadius: BorderRadius.circular(20),
        border: Border.all(color: border)
      ),
      child: Center(
        child: Text(title, textAlign: TextAlign.center, style: TextStyle(
            color: colText,
            fontWeight: FontWeight.w600,
            fontSize: 12,
        )),
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
              builder: (context) => AcreditationPage(),
            ),
          );
        },
        child: Row(children: listCertificateWidget,));
  }

  Widget _buildCertificateItem(Object pesona) {
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
        width: 20,
        height: 20,
      ),
    );
  }

  Widget _buildItemPesona(Object pesona, int index ) {
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
                        '${pesona.status}'
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
