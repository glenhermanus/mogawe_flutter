import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mogawe/core/data/response/home_content/Certificate.dart';
import 'package:mogawe/core/data/response/pesona/certificate_response.dart';
import 'package:mogawe/core/data/response/pesona/detail_pesona_response.dart';
import 'package:mogawe/core/data/response/pesona/pesona_response.dart';
import 'package:mogawe/core/data/response/pesona/pesona_response_object.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/modules/pesona/page/acreditation_page.dart';
import 'package:mogawe/modules/pesona/bloc/pesona_bloc.dart';
import 'package:mogawe/modules/pesona/bloc/pesona_event.dart';
import 'package:mogawe/modules/pesona/bloc/pesona_state.dart';
import 'package:mogawe/modules/pesona/page/detail_pesona_page.dart';
import 'package:mogawe/modules/pesona/page/pesona_page.dart';
import 'package:mogawe/modules/pesona/widget/build_loading_pesona.dart';
import 'package:mogawe/modules/profile/widget/loading/build_pickup_address_loading.dart';
import 'package:mogawe/utils/ui/animation/bounce_tap.dart';

class PesonaScreenScreen extends StatefulWidget {
  const PesonaScreenScreen({Key? key}) : super(key: key);

  @override
  _PesonaScreenScreenState createState() => _PesonaScreenScreenState();
}

class _PesonaScreenScreenState extends State<PesonaScreenScreen> {
  late PesonaBloc bloc;
   List<PesonaResponsesObject> listPesona =[];
   List<Object> listObject =[];
  List<Object> object = [];
  var token;

  getToken()async{
    token = await AuthRepository().readSecureData('token');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = PesonaBloc();
    bloc.add(GetPesonaEvent());
    bloc.add(GetPesonaCertificate());
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
          return buildLoadingPesona();
        }
        if (state is ShowListPesonaState) {
          listPesona = state.data;

          return layout();
        }
        if (state is ShowEmptyListPesonaState) {
          return Container();
        }
        if (state is ShowErrorPesonaState) {
          print("error ads" + state.message);
          return Container();
        }
        if (state is ShowLoadingCertificateState) {
          print("State : ${state}");
          return Container();
        }
        if (state is ShowEmptyListCertificateState) {
          return layout();
        }
        if (state is ShowListCertificateState) {
          listObject = state.data;
          return layout();
        }
        if (state is ShowErrorCertificateState) {
          print("error list certif ${state.message}" );
          return Container();
        }
        return Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color(0xFFF5F5F5),
      body: blocListener(blocBuilder()),
    );
  }

  Widget layout() => PesonaPage(
   object: listObject,
    listPesona: listPesona,
  );

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
        color: pesona.status == "pending"
            ? FlutterFlowTheme.moGaweYellow
            : FlutterFlowTheme.moGaweGreen,
        width: 20,
        height: 20,
      ),
    );
  }

}
