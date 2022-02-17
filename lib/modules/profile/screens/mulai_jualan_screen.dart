import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/modules/profile/blocs/mulai_merchant_bloc.dart';
import 'package:mogawe/modules/profile/blocs/mulai_merchant_event.dart';
import 'package:mogawe/modules/profile/blocs/mulai_merchant_state.dart';
import 'package:mogawe/modules/profile/page_merchant/mulai_jualan.dart';
import 'package:mogawe/utils/ui/animation/bounce_tap.dart';
import 'package:mogawe/utils/ui/widgets/app_util.dart';

class MulaiJualanScreen extends StatefulWidget {
  String uuidMogawers;
  MulaiJualanScreen({required this.uuidMogawers});

  @override
  _MulaiJualanScreenState createState() => _MulaiJualanScreenState();
}

class _MulaiJualanScreenState extends State<MulaiJualanScreen> {
  late MulaiMerchantBloc bloc;
  bool isLoading = false;
  String photoUrl = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = MulaiMerchantBloc();
    print('a ${widget.uuidMogawers}');
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
        if (state is InitMulaiMerchantState) return layout();
        if (state is ShowLoadingMulaiMerchantState) {
          WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
            AppUtil.show(context);
          });
          isLoading = true;
          return layout();
        }
        if (state is ShowLoadingMerchantState) {
          WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
            AppUtil.show(context);
          });
          isLoading = true;
          return layout();
        }

        if (state is SuccessUpdatePhotoTokoState) {
          checkLoading();
          //data = state.data;
          photoUrl = state.message;
          return layout();
        }

        if (state is ShowErrorUploadPhotoState) {
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

      backgroundColor: FlutterFlowTheme.secondaryColor,
      body: blocListener(blocBuilder()),
    );
  }

  Widget layout() => MulaiJualan(
    uuid: widget.uuidMogawers,
    photoUrl: photoUrl,
    onFotoChanged: (v) {
      var map = {
        "file": v
      };
      Navigator.pop(context);
      bloc.add(DoUpdatePhotoEvent(map));
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
