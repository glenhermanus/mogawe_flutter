import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mogawe/core/data/response/home_content/gawean_model.dart';
import 'package:mogawe/core/data/response/home_content/gawean_row_model.dart';
import 'package:mogawe/core/data/response/home_content/product_etalasa_model.dart';
import 'package:mogawe/core/data/response/user_profile_response.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/modules/home/faq/faq_webview.dart';
import 'package:mogawe/modules/home/widgets/build_banner_builder.dart';
import 'package:mogawe/modules/home/widgets/build_gawean_item.dart';
import 'package:mogawe/modules/home/widgets/build_mogawers_target.dart';
import 'package:mogawe/modules/home/widgets/build_product_item.dart';
import 'package:mogawe/modules/home/widgets/gaweanListEmptyView.dart';
import 'package:mogawe/modules/home/widgets/productListEmptyView.dart';
import 'package:mogawe/modules/inbox_notif/notification/notification_list/notification_list_page.dart';
import 'package:mogawe/modules/profile/profile_screen.dart';
import 'package:mogawe/modules/wallet/wallet/wallet_page.dart';

import '../../../core/flutter_flow/flutter_flow_icon_button.dart';
import 'gawean/bloc/gawean_bloc.dart';
import 'gawean/bloc/gawean_event.dart';
import 'gawean/bloc/gawean_state.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GaweanBloc bloc;
  bool loading = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var token;
  var convertCurrency, balance;
  UserProfileResponse? userProfileResponse;

  int gaweanMenu = 0;


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
      convertCurrency = this.userProfileResponse?.balance;
      var currencyFormatter = NumberFormat.currency(locale: 'ID');
      balance = currencyFormatter.format(convertCurrency);
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
          print("State : $state");
          return _buildHomeWidgetContent(state.list);
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
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                  child: loading
                      ? Text('Loading ...',
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            color: FlutterFlowTheme.secondaryColor,
                          ))
                      : Text(
                          'Rp ${balance.replaceAll('IDR', '').replaceAll(',00', '')}',
                          style: FlutterFlowTheme.title2.override(
                            fontFamily: 'Poppins',
                            color: FlutterFlowTheme.secondaryColor,
                          ),
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
            icon: Image.asset('assets/icon/ic_faq.png', width: 20,),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WebviewFAQ(),
                ),
              );
            },
          ),
          // FlutterFlowIconButton(
          //   borderColor: Colors.transparent,
          //   borderRadius: 30,
          //   borderWidth: 1,
          //   buttonSize: 44,
          //   icon: Icon(
          //     Icons.person_outline,
          //     color: FlutterFlowTheme.secondaryColor,
          //     size: 24,
          //   ),
          //   onPressed: () async {
          //     await Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => HireMePage(),
          //       ),
          //     );
          //   },
          // ),
          // FlutterFlowIconButton(
          //   borderColor: Colors.transparent,
          //   borderRadius: 30,
          //   borderWidth: 1,
          //   buttonSize: 44,
          //   icon: Icon(
          //     Icons.message_rounded,
          //     color: FlutterFlowTheme.secondaryColor,
          //     size: 24,
          //   ),
          //   onPressed: () async {
          //     await Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => InboxPage(),
          //       ),
          //     );
          //   },
          // ),
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
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.primaryColor,
                ),
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
                          : Text(
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
                child:
                SingleChildScrollView(child: blocListener(blocBuilder())),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildHomeWidgetContent(List<GaweanRowModel> homeWidgets) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Stack(
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
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: BuildBannerBuilder(),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(18, 16, 16, 0),
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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: BuildMogawersTarget(data: homeWidgets),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(18, 16, 0, 0),
          child: _buildPlusGawean(),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      gaweanMenu = 0;
                    });
                  },
                  child: Container(
                    width: 100,
                    height: 52,
                    decoration: BoxDecoration(
                      color: gaweanMenu == 0
                          ? FlutterFlowTheme.primaryColor
                          : FlutterFlowTheme.secondaryColor,
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
                          color: gaweanMenu == 0
                              ? FlutterFlowTheme.secondaryColor
                              : FlutterFlowTheme.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      gaweanMenu = 1;
                    });
                  },
                  child: Container(
                    width: 100,
                    height: 52,
                    decoration: BoxDecoration(
                      color: gaweanMenu == 0
                          ? FlutterFlowTheme.secondaryColor
                          : FlutterFlowTheme.primaryColor,
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
                          color: gaweanMenu == 0
                              ? FlutterFlowTheme.primaryColor
                              : FlutterFlowTheme.secondaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildProductAndGaweanHome(homeWidgets),
              SizedBox(height: 36)
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlusGawean() {
    return Padding(
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
    );
  }

  Widget _buildProductAndGaweanHome(List<GaweanRowModel> homeWidget) {
    return gaweanMenu == 0
        ? _buildGaweanList(homeWidget[1].jobs ?? [])
        : _buildProductList(homeWidget[1].products ?? []);
  }

  Widget _buildGaweanList(List<Gawean> jobs) {
    return jobs.length == 0
        ? gaweanListEmptyView(
        onPressedBtnPenugasan: () {}, onPressedBtnPesona: () {})
        : ListView.builder(
        itemCount: jobs.length < 5
            ? jobs.length
            : 5,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (ctx, index) {
          var gawean = jobs[index];
          return BuildGaweanItem(
            gaweanModel: gawean,
          );
        }
    );
  }

  Widget _buildProductList(List<ProductModel> products) {
    return products.length == 0
        ? productListEmptyView(onPressed: () {})
        : GridView.builder(
      itemCount: products.length > 6
          ? 6
          : products.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.4,
      ),
      itemBuilder: (ctx, index) {
        return BuildProductItem(
            productModel: products[index]);
      },
    );
  }
}
