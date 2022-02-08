import 'dart:io' show Platform;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';


class NotificationClass {
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  var initsetting;

  BehaviorSubject<ReceiveNotification> get didReceiveLocalNotificationSubject =>
      BehaviorSubject<ReceiveNotification>();


  NotificationClass.init()
  {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    if (Platform.isIOS) {
      requestIOSPermission();
    }
    initializePlatform();
  }

  requestIOSPermission() {
    flutterLocalNotificationsPlugin!.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()!
        .requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  initializePlatform() {
    var initsettingAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initsettingIos = IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: (id, title, body, payload) async {
          ReceiveNotification notify = ReceiveNotification(id: id, title: title, body: body, payload: payload);
          didReceiveLocalNotificationSubject.add(notify);
        }
    );

    initsetting = InitializationSettings(
        android: initsettingAndroid, iOS: initsettingIos);
  }

  setOnNotifTerima(Function onNotifTerima){
    didReceiveLocalNotificationSubject.listen((notify) {
      onNotifTerima(notify);
    });
  }

  setOnNotifKlik(Function onNotifKlik) async {
    await flutterLocalNotificationsPlugin!.initialize(initsetting, onSelectNotification: (String? payload) async{
      onNotifKlik(payload);
    });
  }

  Future<void> showNotif() async{
    var androidchannel = AndroidNotificationDetails('CHANNEL_ID', 'CHANNEL_NAME', importance: Importance.max,
        priority: Priority.high, playSound: true, icon: '@mipmap/ic_launcher');

    var ioschanel = IOSNotificationDetails();
    var platformchnl = NotificationDetails(android: androidchannel, iOS: ioschanel);
    await flutterLocalNotificationsPlugin!.show(0, 'title', 'body', platformchnl, payload: 'new');

  }
  Future<void> showjadwalNotif() async{
    var JadwalNotif = DateTime.now().add(Duration(seconds: 6));
    var androidchannel = AndroidNotificationDetails('CHANNEL_ID', 'CHANNEL_NAME', importance: Importance.max,
        priority: Priority.high, playSound: true, timeoutAfter: 5000, enableLights: true);


    var ioschanel = IOSNotificationDetails();
    var platformchnl = NotificationDetails(android: androidchannel, iOS: ioschanel);
    await flutterLocalNotificationsPlugin!.schedule(0, 'title', 'body', JadwalNotif, platformchnl, payload: 'new');

  }
}

NotificationClass notificationClass = NotificationClass.init();

class ReceiveNotification {
  int? id;
  String? title, body, payload;
  ReceiveNotification({required this.id, required this.title, required this.body, required this.payload,});
}