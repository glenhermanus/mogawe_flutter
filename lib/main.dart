import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/core/repositories/chat_qiscus_repositories.dart';
import 'package:mogawe/modules/inbox_notif/notification/notif.dart';
import 'package:mogawe/modules/starter/screens/splash_page/splash_page.dart';
import 'package:rxdart/rxdart.dart';

Future<void> firebaseMessagingBackground(RemoteMessage message) async{
  await Firebase.initializeApp();

}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackground);
  await Firebase.initializeApp();
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging message = FirebaseMessaging.instance;

  var initsetting;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  BehaviorSubject<ReceiveNotification> get didReceiveLocalNotificationSubject =>
      BehaviorSubject<ReceiveNotification>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
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

  void getToken() async{
    var token = await AuthRepository().readSecureData('token');
    String? tokenDevice = await message.getToken();
    print(tokenDevice);
    await ChatQiscusRepo().kirimTokenDevice(tokenDevice, token);

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoGawe',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', '')],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: SplashPage(),
    );
  }
}
