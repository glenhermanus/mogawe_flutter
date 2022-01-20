
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mogawe/core/data/response/merchant/shipment_courier.dart';
import 'package:mogawe/core/data/response/merchant/supplier_product.dart';
import 'package:mogawe/core/data/response/profile/profile_history_response.dart';
import 'package:mogawe/core/data/response/profile/profile_response.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/modules/auth/screens/login/login_page.dart';
import 'package:mogawe/modules/home/home_page.dart';
import 'package:mogawe/modules/profile/blocs/profile_event.dart';
import 'package:mogawe/modules/profile/blocs/profile_state.dart';
import 'package:mogawe/modules/profile/profile_page.dart';
import 'package:mogawe/utils/ui/widgets/app_util.dart';

import 'package:mogawe/core/data/response/merchant/merchant_profile_response.dart';
import 'blocs/profile_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  late ProfileBloc bloc;
  ObjectData? data;
  Object? dataMerchant;
  List<ObjectShipment>? objectShipment;
  bool isLoading = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<ProfileHistoryData> histories = [];
  String? periode;
  String? q;
  TextEditingController targetCtrl = TextEditingController();
  TextEditingController namaCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
   String? reminder;
   String? phone;
  String? birthday;
  int? taskReminder;
  SupplierProduct? supplierProduct;
  var token;

  getData()async{

    token = await AuthRepository().readSecureData('token');
    supplierProduct = await AuthRepository().getSupplierProducts(token);

  }

  @override
  void initState() {
    super.initState();
    bloc = ProfileBloc();
    bloc.add(GetProfileEvent());
    bloc.add(GetMerchantEvent());
    bloc.add(GetProfileHistoryEvent());
    bloc.add(GetShipmentCourierEvent());
    getData();
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
        if (state is ShowLoadingMerchantState) {
          WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
            AppUtil.show(context);
          });
          isLoading = true;
          return layout();
        }
        if (state is ShowLoadingSelfPickRadiusState) {
          WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
            AppUtil.show(context);
          });
          isLoading = true;
          return layout();
        }
        if (state is ShowLoadingShipmentState) {
          WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
            AppUtil.show(context);
          });
          isLoading = true;
          return layout();
        }
        if (state is ShowLoadingShipmentState) {
          WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
            AppUtil.show(context);
          });
          isLoading = true;
          return layout();
        }
        if (state is ShowProfileData) {
          checkLoading();
          data = state.data;
          targetCtrl.text = data!.config?.targetRevenue!.toInt().toString() as String;
          namaCtrl.text = data?.fullName?? '';
          emailCtrl.text = data?.email ?? '';
          phoneCtrl.text = data?.phone ?? '';
          taskReminder = data!.config?.taskReminderDefault ?? 0;
          reminder = data!.config?.taskReminderDefault.toString() ?? '';
          phone = data?.phone ?? '';
          birthday = data?.birthdate.toString();
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
        if (state is SuccessUpdateSelfReminderState) {
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
        if (state is SuccessUpdatePhotoMerchantState) {
          checkLoading();
          dataMerchant = state.datam;
          WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                state.messages,
                style: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Poppins',
                    color: Colors.white
                ),
              ),
            ));
          });
          return layout();
        }
        if (state is SuccessUpdateSelfPickRadiusState) {
          checkLoading();
          WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {

          });
          return layout();
        }
        if (state is SuccessUpdateshippingExpeditionState) {
          checkLoading();
          WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {

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
        if (state is ShowErrorMerchantState) {
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
        if (state is ShowErrorSelfPickRadiusState) {
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
        if (state is ShowErrorShipmentCourierState) {
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
        if (state is ShowErrorShipmentCourierState) {
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
        if (state is ShowProfileMerchant) {
          checkLoading();
          dataMerchant = state.data;
          return layout();
        }
        if (state is ShowShipmentMerchant) {
          checkLoading();
          objectShipment = state.data;
          return layout();
        }
        if (state is ShowErrorGetMerchantState) {
          checkLoading();
          // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
          //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) =>
          //       HomePage()), (route) => false);
          // });
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
    dataMerchant: dataMerchant,
    objectShipment: objectShipment,
    supplierProduct: supplierProduct,
    updateShipment: (map) {
      Navigator.pop(context);
      bloc.add(DoUpdateShippingExpeditionEvent(map));},
    histories: histories,
    updateProfile: (map) => bloc.add(DoUpdateProfileEvent(map)),
    updateTarget: (map) => bloc.add(DoUpdateTargetRevenueEvent(map)),
    updateSelfReminder: (map) => bloc.add(DoUpdateSelfReminderEvent(map)),
    targetCtrl: targetCtrl,
    namaCtrl: namaCtrl,
    emailCtrl: emailCtrl,
    phoneCtrl: phoneCtrl,
    reminder: reminder,
    phone: phone,
    birthday: birthday,
    taskReminder: taskReminder,
    onFotoChanged: (v) {
      var map = {
        "profilePicture": v
      };
      Navigator.pop(context);
      bloc.add(DoUpdatePhotoProfileEvent(map));
    },

    onFotoChangedMerchant: (v) {
      var map = {
        "file": v
      };
      Navigator.pop(context);
      bloc.add(DoUpdatePhotoMerchantEvent(map));
    },

    parseRadius: (v){
      var map = {
        "selfPickupRadius" : v
      };
      Navigator.pop(context);
      bloc.add(DoUpdateSelfPickRadiusEvent(map));
    },

    historyPageListen: (p, q) {
      this.q = q;
      bloc.add(PaginateProfileHistoryEvent(q, periode, "$p"));
    },
    filter: (f, q) {
      periode = f;
      this.q = q;
      bloc.add(FilterProfileHistoryEvent(periode!, q));
    },
    searchListen: (q) => bloc.add(SearchProfileHistoryEvent(q, periode)),
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