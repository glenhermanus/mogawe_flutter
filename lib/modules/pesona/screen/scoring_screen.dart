import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mogawe/core/data/response/home_content/Certificate.dart';
import 'package:mogawe/core/data/response/pesona/certificate_response.dart';
import 'package:mogawe/core/data/response/pesona/detail_pesona_response.dart';
import 'package:mogawe/core/data/response/pesona/expired_response.dart';
import 'package:mogawe/core/data/response/pesona/pending_response.dart';
import 'package:mogawe/core/data/response/pesona/pesona_response.dart';
import 'package:mogawe/core/data/response/pesona/pesona_response_object.dart';
import 'package:mogawe/core/data/response/pesona/verified_response.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/modules/pesona/bloc/scoring_bloc.dart';
import 'package:mogawe/modules/pesona/bloc/scoring_event.dart';
import 'package:mogawe/modules/pesona/bloc/scoring_state.dart';
import 'package:mogawe/modules/pesona/page/acreditation_page.dart';
import 'package:mogawe/modules/pesona/bloc/pesona_bloc.dart';
import 'package:mogawe/modules/pesona/bloc/pesona_event.dart';
import 'package:mogawe/modules/pesona/bloc/pesona_state.dart';
import 'package:mogawe/modules/pesona/page/detail_pesona_page.dart';
import 'package:mogawe/modules/pesona/page/pesona_page.dart';
import 'package:mogawe/modules/pesona/page/scoring_page.dart';
import 'package:mogawe/modules/pesona/widget/build_loading_pesona.dart';
import 'package:mogawe/modules/profile/widget/loading/build_pickup_address_loading.dart';
import 'package:mogawe/utils/ui/animation/bounce_tap.dart';

class ScoringScreen extends StatefulWidget {
  const ScoringScreen({Key? key}) : super(key: key);

  @override
  _ScoringScreenState createState() => _ScoringScreenState();
}

class _ScoringScreenState extends State<ScoringScreen> {
  late ScoringBloc bloc;
  List<ObjectPending> objectPending =[];
  List<ObjectVerif> objectVerif =[];
  List<ObjectExpired> objectExpire = [];
  List<Object> dataCertif = [];
  var token;

  getToken()async{
    token = await AuthRepository().readSecureData('token');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = ScoringBloc();
    bloc.add(GetCertificateEvent());
    bloc.add(GetScoringPendingEvent());
    bloc.add(GetScoringVerifEvent());
    bloc.add(GetScoringExpiredEvent());
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
        if (state is ShowLoadingScoringsState) {
          print("State : $state");
          return buildLoadingPesona();
        }
        if (state is ShowListScoringsState) {
          dataCertif = state.data;

          return layout();
        }
        if (state is ShowEmptyListPesonaState) {
          return layout();
        }
        if (state is ShowErrorPesonaState) {
          print("error ads" + state.message);
          return Container();
        }
        if (state is ShowPendingStatusState) {
          objectPending = state.dataPending;

          return layout();
        }
        if (state is ShowEmptyPendingState) {
          return layout();
        }
        if (state is ShowVerifiedStatusState) {
          objectVerif = state.dataVerified;

          return layout();
        }
        if (state is ShowEmptyVerifState) {
          return layout();
        }
        if (state is ShowExpiredStatusState) {
          objectExpire = state.dataExpired;

          return layout();
        }
        if (state is ShowEmptyExpiredState) {
          return layout();
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

  Widget layout() => ScoringPage(
    object: dataCertif,
    objectPending: objectPending,
    objectVerif: objectVerif,
    objectExpired: objectExpire,
  );

}
