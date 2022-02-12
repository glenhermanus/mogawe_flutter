import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mogawe/core/data/response/user_profile_response.dart';
import 'package:mogawe/core/data/response/wallet/wallet_history_model.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/modules/wallet/bloc/wallet_bloc.dart';
import 'package:mogawe/modules/wallet/bloc/wallet_event.dart';
import 'package:mogawe/modules/wallet/bloc/wallet_state.dart';
import 'package:mogawe/modules/wallet/widgets/build_loading_wallet_history.dart';
import 'package:mogawe/modules/wallet/wiithdrawal/wiithdrawal_page.dart';
import "package:grouped_list/grouped_list.dart";
import 'package:mogawe/utils/services/currency_formatter.dart';
import 'package:mogawe/utils/services/date_formatter.dart';
import 'package:mogawe/utils/ui/widgets/MogaweNominalText.dart';

class WalletPage extends StatefulWidget {
  WalletPage({Key? key}) : super(key: key);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  late WalletBloc bloc;
  List<WalletHistoryModel>? data;
  UserProfileResponse? userProfileResponse;
  bool isLoading = false;
  bool loading = false;
  late String token;
  bool _loadingButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  void getToken() async {
    setState(() {
      loading = true;
    });
    token = await AuthRepository().readSecureData('token') as String ?? "";

    print("OUT >> hey from wallet");
    print(token);

    var res = await AuthRepository().getProfile(token);
    userProfileResponse = res;
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getToken();
    bloc = WalletBloc();
    bloc.add(GetWalletHistoryEvent());
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
        if (state is ShowLoadingWalletState) {
          print("State : $state");
          return Center(
            child: buildWalletHistoryLoading(),
          );
        }
        if (state is ShowWalletHistoryList) {
          data?.addAll(state.list);
          print("Wallet size is ${state.list.length}");
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: _buildHistoryWalletList(state.list),
          );
        }
        if (state is ShowErrorGetWalletState) {
          print("error walet" + state.message);
          return Container();
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
        backgroundColor: FlutterFlowTheme.secondaryColor,
        iconTheme: IconThemeData(color: FlutterFlowTheme.tertiaryColor),
        automaticallyImplyLeading: true,
        title: Text(
          'Dompet MoGawers',
          style: FlutterFlowTheme.subtitle1.override(
            fontFamily: 'Poppins',
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFE7E7E7),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: double.infinity,
          height: 172,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.secondaryColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                child: Container(
                  width: double.infinity,
                  height: 64,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.secondaryColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: FlutterFlowTheme.tertiaryColor,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Saldo',
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            // Text(
                            //   loading ? '' : 'Rp',
                            //   style: FlutterFlowTheme.subtitle2.override(
                            //     fontFamily: 'Poppins',
                            //   ),
                            // ),
                            Text(
                              loading
                                  ? 'loading...'
                                  : ' ${stringtoRupiah(this.userProfileResponse?.balance as int)}',
                              style: FlutterFlowTheme.title3.override(
                                fontFamily: 'Poppins',
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                child: FFButtonWidget(
                  onPressed: () async {
                    setState(() => _loadingButton = true);
                    try {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WiithdrawalPage(),
                        ),
                      );
                    } finally {
                      setState(() => _loadingButton = false);
                    }
                  },
                  text: 'Tarik Saldo',
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 52,
                    color: FlutterFlowTheme.primaryColor,
                    textStyle: FlutterFlowTheme.subtitle2.override(
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
            ],
          ),
        ),
         Expanded(child: blocListener(blockBuilder())),
      ],
    ));
  }
  Widget _buildHistoryWalletList(List<WalletHistoryModel> list) {

    print("Wallet size is ${list.length}");

    return GroupedListView<dynamic, String>(
        elements: list,
        groupBy: (element) =>
            new DateFormatter().formatDateMMMddyyyy(element.trxTime),
        groupComparator: (date1, date2) => date2.compareTo(date1),
        order: GroupedListOrder.ASC,
        groupSeparatorBuilder: (date) => _buildItemDateWallet(date.toString()),
        scrollDirection: Axis.vertical,
        indexedItemBuilder: (context, element, index) {
          WalletHistoryModel walletHistory = list[index];
          return _buildItemWallet(walletHistory);
        });
  }

  Widget _buildItemDateWallet(String date) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(24, 12, 0, 0),
      child: Text(
        date,
        style: FlutterFlowTheme.bodyText1.override(
          fontFamily: 'Poppins',
        ),
      ),
    );
  }

  Widget _buildItemWallet(WalletHistoryModel walletHistory) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 0),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Color(0xFFF5F5F5),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                walletHistory.description ?? "",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: FlutterFlowTheme.subtitle2.override(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: walletHistory.trxType == "Credit"
                              ? FlutterFlowTheme.moGaweGreen
                              : FlutterFlowTheme.primaryColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 2, 8, 2),
                          child: Text(
                            walletHistory.trxType,
                            style: FlutterFlowTheme.bodyText2.override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.secondaryColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFC0C0C0),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 2, 8, 2),
                          child: Text(
                            walletHistory.trxCategory ?? "",
                            style: FlutterFlowTheme.bodyText2.override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.blackColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MogaweNominalText(
                            nominal: walletHistory.total.toInt(),
                            isNeedSymbol: true,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 16,
                thickness: 1,
                color: Color(0xFFE7E7E7),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Saldo berjalan:',
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                      color: Color(0xFF8B8B8B),
                    ),
                  ),
                  Text(
                    'Rp85.000',
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                      color: Color(0xFF8B8B8B),
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
