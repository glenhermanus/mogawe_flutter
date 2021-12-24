import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mogawe/core/data/response/ewallet/ewallet_model.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_util.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/core/repositories/wallet_repository.dart';

class OtpEWalletScreen extends StatefulWidget {
  final EWalletModel eWalletModel;
  final String eWalletNominal;
  final String eWalletVoucherCode;

  const OtpEWalletScreen(
      {Key? key,
      required this.eWalletModel,
      required this.eWalletNominal,
      required this.eWalletVoucherCode})
      : super(key: key);

  @override
  _OtpEWalletScreenState createState() => _OtpEWalletScreenState();
}

class _OtpEWalletScreenState extends State<OtpEWalletScreen> {
  TextEditingController? otpTextEditingController;

  final _formKey = GlobalKey<FormState>();

  final WalletRepository _walletRepository = WalletRepository.instance;

  bool _buttonLoading = false;

  @override
  void initState() {
    super.initState();
    otpTextEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.secondaryColor,
        iconTheme: IconThemeData(color: FlutterFlowTheme.tertiaryColor),
        automaticallyImplyLeading: true,
        title: Text(
          'Verifikasi',
          style: FlutterFlowTheme.subtitle1.override(
            fontFamily: 'Poppins',
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    return _buildContent();
  }

  Widget _buildContent() {
    return Center(
      child: Container(
        width: 220,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 32,
              ),
              Text(
                "Cek Email Kamu",
                style: FlutterFlowTheme.title3,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Kami sudah mengirimkan kode OTP ke email kamu",
                style: FlutterFlowTheme.bodyText3,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 32,
              ),
              TextFormField(
                textAlign: TextAlign.center,
                controller: otpTextEditingController,
                maxLength: 6,
                decoration: InputDecoration(
                  hintText: "Kode OTP",
                  counterText: '',
                  counterStyle: TextStyle(fontSize: 0),
                ),
                validator: (value) {
                  RequiredValidator(errorText: "Kode OTP tidak boleh kosong");
                  return null;
                },
              ),
              SizedBox(
                height: 32,
              ),
              FFButtonWidget(
                text: "Verifikasi",
                onPressed: () {
                  setState(() => _buttonLoading = true);
                  _handleVerifyOtpCode(
                      widget.eWalletModel.uuid,
                      widget.eWalletVoucherCode,
                      widget.eWalletNominal,
                      otpTextEditingController!.text);
                  setState(() => _buttonLoading = false);
                },
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
                loading: _buttonLoading,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleVerifyOtpCode(
    String uuidEWalletAccount,
    String voucherCode,
    String amount,
    String otp,
  ) async {
    var token =
        "eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJNTy04Rk1HOFAiLCJpYXQiOjE2MzkzODc0ODIsInN1YiI6Im1vZ2F3ZXJzIiwiaXNzIjoibW9nYXdlIn0.8_QeC-6Ui3RGG1CvM66rjuSZgidzcHVB2uSCDy4ZnfQ";
    var body = {
      "uuidTransferAccount": uuidEWalletAccount,
      "voucherCode": voucherCode,
      "amount": amount,
      "otp": otp
    };
    try {
      var response = await _walletRepository.verifyOtpResponse(token, body);
      if (response.returnValue == "000") {
        int count = 0;
        Navigator.of(context).popUntil((_) => count++ >= 3);
        showSnackbar(context, response.message);
      } else if (response.returnValue == "001") {
        showSnackbar(context, response.message);
      }
    } catch (ex) {
      showSnackbar(context, ex.toString());
    }

    print(body);
  }
}
