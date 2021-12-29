import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mogawe/core/data/response/ewallet/ewallet_model.dart';
import 'package:mogawe/core/data/response/ewallet/nominal/ewallet_nominal_model.dart';
import 'package:mogawe/core/data/response/user_profile_response.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/core/repositories/wallet_repository.dart';
import 'package:mogawe/modules/wallet/add_ewallet_account/add_ewallet_account_screen.dart';
import 'package:mogawe/modules/wallet/bloc/ewallet_bloc.dart';
import 'package:mogawe/modules/wallet/bloc/wallet_event.dart';
import 'package:mogawe/modules/wallet/bloc/wallet_state.dart';
import 'package:mogawe/modules/wallet/otp/ewallet_otp_screen.dart';
import 'package:mogawe/modules/wallet/transfer_ewallet/widget/nominal_item_tile.dart';

class TransferEWalletScreen extends StatefulWidget {
  const TransferEWalletScreen({Key? key}) : super(key: key);

  @override
  _TransferEWalletScreenState createState() => _TransferEWalletScreenState();
}

class _TransferEWalletScreenState extends State<TransferEWalletScreen> {
  // BLOC
  late EWalletBloc bloc;
  List<EWalletNominalModel>? eWalletNominalList;
  List<EWalletModel>? eWalletDataList;

  final WalletRepository _walletRepository = WalletRepository.instance;

  bool _loadingButton1 = false;
  bool _loadingButton2 = false;

  late int nominalSelectedIndex = 0;
  int eWalletSelectedIndex = 0;
  late EWalletModel mEWallet;

  UserProfileResponse? userProfileResponse;
  bool isLoading = false;
  bool loading = false;
  var token;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  void getToken() async {
    setState(() {
      loading = true;
    });
    token = await AuthRepository().readSecureData('token');

    var res = await AuthRepository().getProfile(token);
    var listNominal =
        await WalletRepository().getEWalletNominal(realToken: token);

    userProfileResponse = res;
    setState(() {
      eWalletNominalList = listNominal;
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
    bloc = EWalletBloc();
    bloc.add(GetEWalletListEvent());
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
        if (state is ShowLoadingEWalletState) {
          print("State : $state");
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ShowEWalletList) {
          eWalletDataList?.addAll(state.list);
          mEWallet = state.list[eWalletSelectedIndex];
          print("Wallet size is ${state.list.length}");
          return _buildEWalletList(state.list);
        }
        if (state is ShowErrorGetWalletState) {
          print(state.message);
          return Container();
        }
        return Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height + 200,
          child: _buildBody(),
        ),
      ),
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.secondaryColor,
        iconTheme: IconThemeData(color: FlutterFlowTheme.tertiaryColor),
        automaticallyImplyLeading: true,
        title: Text(
          'Transfer E-Wallet',
          style: FlutterFlowTheme.subtitle1.override(
            fontFamily: 'Poppins',
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
    );
  }

  Widget _buildBody() {
    return SafeArea(child: _buildContent());
  }

  Widget _buildContent() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.secondaryColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Jumlah Penarikan',
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Lato',
                        fontSize: 14,
                      ),
                    ),
                    loading
                        ? Text("Loading....")
                        : Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Total Saldo : Rp.1,240',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Lato',
                                  fontSize: 14,
                                ),
                              )
                            ],
                          )
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              loading
                  ? CircularProgressIndicator()
                  : Expanded(
                      child: _buildItemEWalletNominal(eWalletNominalList),
                    ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(child: blocListener(blocBuilder())),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                  child: FFButtonWidget(
                    onPressed: () async {
                      setState(() => _loadingButton1 = true);
                      try {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddEWalletAccountScreen(),
                          ),
                        ).then((value) => setState(() {}));
                      } finally {
                        setState(() => _loadingButton1 = false);
                      }
                    },
                    text: 'Tambah Akun E-Wallet',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 48,
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
                    loading: _loadingButton1,
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.secondaryColor,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Perlu Diketahui',
                        style: FlutterFlowTheme.title2.override(
                            fontFamily: 'Lato', fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(
                            Icons.circle,
                            color: Color(0xFF757575),
                            size: 8,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                            child: Text(
                              'Minimal penarikan Rp50.000',
                              style: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Lato',
                                fontSize: 14,
                                color: Color(0xFF757575),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(
                            Icons.circle,
                            color: Color(0xFF757575),
                            size: 8,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                            child: Text(
                              'Biaya admin transfer bank Rp1.000',
                              style: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Lato',
                                fontSize: 14,
                                color: Color(0xFF757575),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(
                            Icons.circle,
                            color: Color(0xFF757575),
                            size: 8,
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                              child: Text(
                                'Jika penarikan sudah dilakukan, lama maksimal pencairan adalah 2x24 jam',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Lato',
                                  fontSize: 14,
                                  color: Color(0xFF757575),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                  child: FFButtonWidget(
                    onPressed: () async {
                      setState(() => _loadingButton2 = true);
                      print(mEWallet.accountOwner);
                      _handleSendOTPCode(mEWallet.uuid);
                      setState(() => _loadingButton2 = false);
                    },
                    text: 'Transfer',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 48,
                      color: FlutterFlowTheme.primaryColor,
                      textStyle: FlutterFlowTheme.subtitle2.override(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: 12,
                    ),
                    loading: _loadingButton2,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildItemEWalletNominal(List<EWalletNominalModel>? list) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list?.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 3,
      ),
      itemBuilder: (context, index) {
        return NominalItemTile(
          splitNominalString(list?[index].pulsaNominal ?? "debug"),
          nominalSelectedIndex,
          index,
          () {
            setState(() {
              nominalSelectedIndex = index;
            });
          },
        );
      },
    );
  }

  Widget _buildEWalletList(List<EWalletModel> list) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (context, index) {
        EWalletModel eWallet = list[index];
        return _buildItemEWallet(eWallet, index);
      },
    );
  }

  Widget _buildItemEWallet(EWalletModel eWalletModel, int index) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
      child: InkWell(
        onTap: () {
          print(index);
          setState(() {
            eWalletSelectedIndex = index;
          });
        },
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: Color(0xFFFFFFFF),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        eWalletModel.accountService,
                        style: FlutterFlowTheme.subtitle2.override(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        eWalletModel.accountOwner,
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Color(0xFF8B8B8B),
                        ),
                      ),
                      Text(
                        eWalletModel.accountNo,
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Color(0xFF8B8B8B),
                        ),
                      )
                    ],
                  ),
                ),
                Icon(
                  Icons.check_circle,
                  color: eWalletSelectedIndex == index
                      ? FlutterFlowTheme.moGaweGreen
                      : Colors.grey[400],
                  size: 24,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleSendOTPCode(String eWalletUuid) async {
    var token =
        "eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJNTy04Rk1HOFAiLCJpYXQiOjE2MzkzODc0ODIsInN1YiI6Im1vZ2F3ZXJzIiwiaXNzIjoibW9nYXdlIn0.8_QeC-6Ui3RGG1CvM66rjuSZgidzcHVB2uSCDy4ZnfQ";
    var response = await _walletRepository.sendOtpCode(token);
    if (response.returnValue == "000") {
      print("Kode otp berhasil dikirim");
      try {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpEWalletScreen(
              eWalletModel: mEWallet,
              eWalletNominal: splitNominalString(
                  eWalletNominalList![nominalSelectedIndex].pulsaNominal),
              eWalletVoucherCode:
                  eWalletNominalList![nominalSelectedIndex].pulsaCode,
            ),
          ),
        );
      } finally {
        setState(() {
          _loadingButton2 = false;
        });
      }
    }
  }

  String splitNominalString(String nominal) {
    var parts = nominal.split(" ");
    var prefix = parts[2].trim();
    return prefix;
  }
}
