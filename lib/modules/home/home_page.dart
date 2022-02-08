import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:mogawe/core/data/response/home_content/gawean_model.dart';
import 'package:mogawe/core/data/response/home_content/gawean_row_model.dart';
import 'package:mogawe/core/data/response/home_content/product_etalasa_model.dart';
import 'package:mogawe/core/data/response/user_profile_response.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/core/repositories/chat_qiscus_repositories.dart';
import 'package:mogawe/modules/hire_me/hire_me_page.dart';
import 'package:mogawe/modules/hire_me/sales/hire_me_sales_page.dart';
import 'package:mogawe/modules/home/faq/faq_webview.dart';
import 'package:mogawe/modules/home/widgets/build_banner_builder.dart';
import 'package:mogawe/modules/home/widgets/build_gawean_item.dart';
import 'package:mogawe/modules/home/widgets/build_mogawers_target.dart';
import 'package:mogawe/modules/home/widgets/build_product_item.dart';
import 'package:mogawe/modules/home/widgets/gaweanListEmptyView.dart';
import 'package:mogawe/modules/home/widgets/productListEmptyView.dart';
import 'package:mogawe/modules/inbox_notif/notification/notif.dart';
import 'package:mogawe/modules/inbox_notif/notification/notification_list/notification_list_page.dart';
import 'package:mogawe/modules/profile/profile_screen.dart';
import 'package:mogawe/modules/wallet/wallet/wallet_page.dart';
import 'package:mogawe/utils/ui/animation/bounce_tap.dart';
import 'package:mogawe/utils/ui/widgets/MogaweImageHandler.dart';
import 'package:mogawe/utils/ui/widgets/shimmering_skeleton.dart';
import 'package:rxdart/rxdart.dart';
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
  var convertCurrency, balance, point;
  UserProfileResponse? userProfileResponse;
  final FirebaseMessaging message = FirebaseMessaging.instance;

  var initsetting;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  BehaviorSubject<ReceiveNotification> get didReceiveLocalNotificationSubject =>
      BehaviorSubject<ReceiveNotification>();
  int gaweanMenu = 0;

  void getToken() async {
    setState(() {
      loading = true;
    });
    token = await AuthRepository().readSecureData('token');
    String? tokenDevice = await message.getToken();
    print(tokenDevice);
    print("OUT >> hey");
    print(token);
    await ChatQiscusRepo().kirimTokenDevice(tokenDevice, token);
    userProfileResponse = await AuthRepository().getProfile(token);

    setState(() {
      loading = false;
      convertCurrency = this.userProfileResponse?.balance;
      var currencyFormatter = NumberFormat.currency(locale: 'ID');
      balance = currencyFormatter.format(convertCurrency);
      point = currencyFormatter.format(this.userProfileResponse?.points ?? 0);
    });
  }

  @override
  void initState() {
    super.initState();
    getToken();
    bloc = GaweanBloc();
    bloc.add(GetGaweanListEvent());
    permission_forIOS();
    FirebaseMessaging.onMessage.listen((event) { showNotification(event); });
    FirebaseMessaging.onMessageOpenedApp.listen((event) { showNotification(event); });
    FirebaseMessaging.onBackgroundMessage((message) => showNotification(message));
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      //If there is data in our notification
      if (message != null) {
        //We will open the route from the field view
        //with the value definied in the notification
        print(message.data);
      }
    });

    initSetting_notif();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  Future showNotification(RemoteMessage message) async{
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications', // title
        importance: Importance.max,
        playSound: true

    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    RemoteNotification? data  = message.notification;
    Map<String, dynamic> dataisi = message.data;

    String screen = dataisi['title'].toString();
    print(screen);

    AndroidNotification? android = message.notification?.android;
    if(data != null){
      flutterLocalNotificationsPlugin.show(0, data.title, data.body, NotificationDetails(
        android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            groupKey: channel.groupId,
            icon: '@mipmap/ic_launcher',

            enableVibration: true,
            importance: Importance.max,
            priority: Priority.max, playSound: true
        ),
        iOS: IOSNotificationDetails(presentAlert: true, presentSound: true, presentBadge: true),
      ), payload: '');

    }


  }

  permission_forIOS() async{
    NotificationSettings setting = await message.requestPermission(
        alert: true,
        badge: true,
        sound: true
    );
    if(setting.authorizationStatus == AuthorizationStatus.authorized){
      ('diizinkan');
    }
    else if(setting.authorizationStatus == AuthorizationStatus.provisional){
      ('diizinkan');
    } else{
      ('tidak diizinkan');
    }

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true
    );
  }

  Future<dynamic> onselect(payload) async{
    (payload);
    Navigator.pushNamed(context, payload);
  }

  initSetting_notif(){
    var initsettingAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');

    const IOSInitializationSettings initios = IOSInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false
    );

    final InitializationSettings initsetting = InitializationSettings(
        android: initsettingAndroid, iOS: initios
    );
    flutterLocalNotificationsPlugin.initialize(initsetting, onSelectNotification: onselect);

  }

  Widget blocListener(Widget child) {
    return BlocListener(
      bloc: bloc,
      listener: (ctx, state) => print("$state"),
      child: child,
    );
  }

  Widget blocBuilder(BuildContext context) {
    return BlocBuilder(
      bloc: bloc,
      builder: (ctx, state) {
        if (state is ShowLoadingListGaweanState) {
          print("State : $state");
          return _buildHomeShimmerLoading();
        }
        if (state is ShowListGaweanState) {
          print("State : $state");
          print("State : $state");
          return _buildHomeWidgetContent(state.list, context);
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
      resizeToAvoidBottomInset: false,
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
              child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  width: 40,
                  height: 40,
                  clipBehavior: Clip.antiAlias,
                  child: mogaweImageHandler(url: this.userProfileResponse?.profil_picture, isProfile: true))
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
                        '${point.replaceAll('IDR', '').replaceAll(',00', '')} pts',
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
                RefreshIndicator(
                    onRefresh: () async {
                      bloc.add(GetGaweanListEvent());
                    },
                    child: SingleChildScrollView(
                        child: blocListener(blocBuilder(context)))),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildHomeShimmerLoading(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
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
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                 physics: const NeverScrollableScrollPhysics(),
                child: Row(children: [
                  Skeleton(width: 330, height: 175,),
                  SizedBox(width: 12),
                  Skeleton(width: 330, height: 175,),
                ],),
              ),
            ),
          ],
        ),
        SizedBox(height: 85),
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Skeleton(width: 150, height: 24,),
        ),
        SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Skeleton(height: 175,),
        ),
        SizedBox(height: 36),
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Skeleton(width: 150, height: 24,),
        ),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Skeleton(height: 50,),
        ),
      ],
    );
  }

  Widget _buildHomeWidgetContent(List<GaweanRowModel> homeWidgets, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
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
          child: BuildMogawersTarget(data: homeWidgets, context: context),
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
              _buildProductAndGaweanHome(homeWidgets, context),
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
      child: BounceTap(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HireMePage(),
            ),
          );
        },
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
    );
  }

  Widget _buildProductAndGaweanHome(List<GaweanRowModel> homeWidget, BuildContext context) {
    return gaweanMenu == 0
        ? _buildGaweanList(homeWidget[1].jobs ?? [])
        : _buildProductList(homeWidget[1].products ?? [], context);
  }

  Widget _buildGaweanList(List<Gawean> jobs) {
    return jobs.length == 0
        ? gaweanListEmptyView(context: context)
        : Column(
      children: [
        ListView.builder(
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
        ),
        BounceTap(
            onTap: (){},
            child: Text("Lihat Semua", style: TextStyle(color: FlutterFlowTheme.primaryColor, fontWeight: FontWeight.w600))),
      ],
    );
  }

  Widget _buildProductList(List<ProductModel> products, BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return products.length == 0
        ? productListEmptyView(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HireMeSalesPage(),
            ),
          );
        })
        : Column(
      children: [
        GridView.builder(
          itemCount: products.length > 6
              ? 6
              : products.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 230,
          ),
          itemBuilder: (ctx, index) {
            return BuildProductItem(
                productModel: products[index]);
          },
        ),
        SizedBox(height: 18),
        BounceTap(
            onTap: (){},
            child: Text("Lihat Semua",
                style: TextStyle(color: FlutterFlowTheme.primaryColor, fontWeight: FontWeight.w600),),),
      ]);
  }
}
