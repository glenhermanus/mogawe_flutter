
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mogawe/core/data/response/user_profile_response.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/modules/home/widgets/build_banner_builder.dart';
import 'package:mogawe/modules/home/widgets/build_gawean_item.dart';
import 'package:mogawe/modules/home/widgets/build_mogawers_target.dart';
import 'package:mogawe/modules/inbox_notif/inbox/inbox/inbox_page.dart';
import 'package:mogawe/modules/inbox_notif/notification/notification_list/notification_list_page.dart';
import 'package:mogawe/modules/profile/profile_screen.dart';
import 'package:mogawe/modules/wallet/wallet/wallet_page.dart';

import '../../../core/flutter_flow/flutter_flow_icon_button.dart';
import '../hire_me/hire_me_page.dart';
import 'gawean/bloc/gawean_bloc.dart';
import 'gawean/bloc/gawean_event.dart';
import 'gawean/bloc/gawean_state.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GaweanBloc bloc;

  bool _loadingButton2 = false;
  bool _loadingButton3 = false;
  bool _loadingButton4 = false;
  bool _loadingButton5 = false;
  bool _loadingButton6 = false;
  bool loading = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var token;
  UserProfileResponse? userProfileResponse;

  void getToken() async {
    setState(() {
      loading = true;
    });
    token = await AuthRepository().readSecureData('token');

    print("OUT >> hey");
    print(token);

    userProfileResponse = await AuthRepository().getProfile(token);

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getToken();
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = GaweanBloc();
    bloc.add(GetGaweanListEvent());
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
        if (state is ShowLoadingListGaweanState) {
          print("State : $state");
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ShowListGaweanState) {
          print("State : $state");
          return ListView.builder(
            itemCount: state.list[1].jobs!.length == 5 ? 5 : state.list[1].jobs!.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (ctx, index) {
              var gawean = state.list[1].jobs![index];
              return BuildGaweanItem(gaweanModel: gawean);
            },
          );
        }
        if (state is ShowEmptyListState) {
          return _gaweanListEmptyView();
        }
        if (state is ShowErrorGaweanListState){
          log(state.message);
        }
        return Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print(userProfileResponse?.full_name);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.primaryColor,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: InkWell(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WalletPage(),
              ),
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Icon(
                  Icons.account_balance_wallet,
                  color: FlutterFlowTheme.secondaryColor,
                  size: 18,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                child: loading
                    ? Text('Loading ...',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          color: FlutterFlowTheme.secondaryColor,
                        ))
                    : Text(
                        'Rp ${this.userProfileResponse?.balance}',
                        style: FlutterFlowTheme.title2.override(
                          fontFamily: 'Poppins',
                          color: FlutterFlowTheme.secondaryColor,
                        ),
                      ),
              )
            ],
          ),
        ),
        actions: [
          FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 44,
            icon: Icon(
              Icons.person_outline,
              color: FlutterFlowTheme.secondaryColor,
              size: 24,
            ),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HireMePage(),
                ),
              );
            },
          ),
          FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 44,
            icon: Icon(
              Icons.message_rounded,
              color: FlutterFlowTheme.secondaryColor,
              size: 24,
            ),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InboxPage(),
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 4, 0),
            child: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30,
              borderWidth: 1,
              buttonSize: 44,
              icon: Icon(
                Icons.notifications,
                color: FlutterFlowTheme.secondaryColor,
                size: 24,
              ),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationListPage(),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 24, 0),
            child: InkWell(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ),
                );
              },
              child: this.userProfileResponse?.profil_picture == null ? Container(
                width: 40,
                height: 40,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.network(
                  'https://picsum.photos/seed/168/600',
                ),
              ) : Container(
                width: 40,
                height: 40,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.network(
                  '${this.userProfileResponse?.profil_picture}',
                ),
            ),
          ),
          ),
        ],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: FlutterFlowTheme.secondaryColor,
      body: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional(0, -1),
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.primaryColor,
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.copyright,
                      color: FlutterFlowTheme.fieldColor,
                      size: 16,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                      child: loading
                          ? Text('Loading ...',
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            color: FlutterFlowTheme.secondaryColor,
                          ))
                          :  Text(
                        '${this.userProfileResponse?.points}pts',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          color: FlutterFlowTheme.secondaryColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        //TODO: Banner Goes Here
                        Padding(
                          padding: const EdgeInsetsDirectional.only(top: 16),
                          child: BuildBannerBuilder(),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Target Harian',
                                style: FlutterFlowTheme.subtitle2.override(
                                  fontFamily: 'Poppins',
                                ),
                              )
                            ],
                          ),
                        ),
                        //TODO: Card Target goes here
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: BuildMogawersTarget(),
                        ),
                        //TODO: Gawean goes here
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              blocListener(blocBuilder())
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // show when gawean list is empty
  Widget _gaweanListEmptyView() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Gawean',
                style: FlutterFlowTheme.subtitle2.override(
                  fontFamily: 'Poppins',
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                child: Icon(
                  Icons.add_circle,
                  color: FlutterFlowTheme.primaryColor,
                  size: 20,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  width: 100,
                  height: 52,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(0),
                    ),
                    border: Border.all(
                      color: FlutterFlowTheme.primaryColor,
                    ),
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Text(
                      'Penugasan',
                      style: FlutterFlowTheme.subtitle2.override(
                        fontFamily: 'Poppins',
                        color: FlutterFlowTheme.secondaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: 100,
                  height: 52,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.secondaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(16),
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(16),
                    ),
                    border: Border.all(
                      color: FlutterFlowTheme.primaryColor,
                    ),
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Text(
                      'Etalase',
                      style: FlutterFlowTheme.subtitle2.override(
                        fontFamily: 'Poppins',
                        color: FlutterFlowTheme.primaryColor,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
          child: Image.asset(
            'assets/images/im_no_job.png',
            width: double.infinity,
            height: 242,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
          child: Text(
            'Wah, kamu belum punya hire_me\nyang bisa dikerjain lagi.',
            textAlign: TextAlign.center,
            style: FlutterFlowTheme.subtitle2.override(
              fontFamily: 'Poppins',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
          child: FFButtonWidget(
            onPressed: () {
              print('Button pressed ...');
            },
            text: 'Dapatkan penugasan baru',
            options: FFButtonOptions(
              width: 240,
              height: 48,
              color: FlutterFlowTheme.secondaryColor,
              textStyle: FlutterFlowTheme.subtitle2.override(
                fontFamily: 'Poppins',
                color: FlutterFlowTheme.primaryColor,
                fontSize: 12,
              ),
              borderSide: BorderSide(
                color: FlutterFlowTheme.primaryColor,
                width: 1,
              ),
              borderRadius: 12,
            ),
            loading: _loadingButton2,
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
          child: FFButtonWidget(
            onPressed: () {
              print('Button pressed ...');
            },
            text: 'Tambahkan pesonamu',
            options: FFButtonOptions(
              width: 240,
              height: 48,
              color: FlutterFlowTheme.secondaryColor,
              textStyle: FlutterFlowTheme.subtitle2.override(
                fontFamily: 'Poppins',
                color: FlutterFlowTheme.primaryColor,
                fontSize: 12,
              ),
              borderSide: BorderSide(
                color: FlutterFlowTheme.primaryColor,
                width: 1,
              ),
              borderRadius: 12,
            ),
            loading: _loadingButton3,
          ),
        ),
      ],
    );
  }
}
