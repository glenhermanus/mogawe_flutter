
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mogawe/core/data/response/profile/profile_history_response.dart';
import 'package:mogawe/core/data/response/profile/profile_response.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/modules/auth/screens/login/login_page.dart';
import 'package:mogawe/modules/profile/blocs/profile_event.dart';
import 'package:mogawe/modules/profile/blocs/profile_state.dart';
import 'package:mogawe/modules/profile/profile_page.dart';
import 'package:mogawe/utils/ui/widgets/app_util.dart';

import 'blocs/profile_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  late ProfileBloc bloc;
  ObjectData? data;
  bool isLoading = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<ProfileHistoryData> histories = [];
  String? periode;

  @override
  void initState() {
    super.initState();
    bloc = ProfileBloc();
    bloc.add(GetProfileEvent());
    bloc.add(GetProfileHistoryEvent());
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
        if (state is InitProfileState) return layout();
        if (state is ShowLoadingProfileState) {
          WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
            AppUtil.show(context);
          });
          isLoading = true;
          return layout();
        }
        if (state is ShowProfileData) {
          checkLoading();
          data = state.data;
          return layout();
        }
        if (state is ShowProfileHistoryDataState) {
          checkLoading();
          histories = state.list;
          return layout();
        }
        if (state is ShowPaginateProfileHistoryDataState) {
          histories.addAll(state.list);
          return layout();
        }
        if (state is SuccessUpdateProfileState) {
          checkLoading();
          data = state.data;
          WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                state.message,
                style: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Poppins',
                    color: Colors.white
                ),
              ),
            ));
          });
          return layout();
        }
        if (state is SuccessUpdateTargetRevenueState) {
          checkLoading();
          data = state.data;
          WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                state.message,
                style: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Poppins',
                    color: Colors.white
                ),
              ),
            ));
          });
          return layout();
        }
        if (state is SuccessUpdatePhotoProfileState) {
          checkLoading();
          data = state.data;
          WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                state.message,
                style: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Poppins',
                    color: Colors.white
                ),
              ),
            ));
          });
          return layout();
        }
        if (state is ShowErrorGetProfileState) {
          checkLoading();
          WidgetsBinding.instance!.addPostFrameCallback((timeStamp) { 
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) =>
            LoginPage()), (route) => false);
          });
          return layout();
        }
        if (state is ShowErrorProfileState) {
          checkLoading();
          WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                state.message,
                style: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Poppins',
                    color: Colors.white
                ),
              ),
              backgroundColor: FlutterFlowTheme.primaryColor,
            ));
          });
          return layout();
        }
        return Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.primaryColor,
        automaticallyImplyLeading: true,
        title: Text(
          'Profile',
          style: FlutterFlowTheme.subtitle1.override(
            fontFamily: 'Poppins',
            color: FlutterFlowTheme.secondaryColor,
          ),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: FlutterFlowTheme.secondaryColor,
      body: blocListener(blocBuilder()),
    );
  }

  Widget layout() => ProfilePage(
    data: data,
    histories: histories,
    updateProfile: (map) => bloc.add(DoUpdateProfileEvent(map)),
    updateTarget: (map) => bloc.add(DoUpdateTargetRevenueEvent(map)),
    onFotoChanged: (v) {
      var map = {
        "profilePicture": v
      };
      Navigator.pop(context);
      bloc.add(DoUpdatePhotoProfileEvent(map));
    },
    historyPageListen: (p) => bloc.add(PaginateProfileHistoryEvent(periode, "$p")),
    filter: (f) {
      periode = f;
      bloc.add(FilterProfileHistoryEvent(periode!));
    },
  );

  void checkLoading() {
    if (isLoading) {
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        Navigator.pop(context);
      });
      isLoading = false;
    }
  }
}
