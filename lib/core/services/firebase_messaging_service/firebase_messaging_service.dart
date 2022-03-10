import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';


// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//     description:
//         'This channel is used for important notifications.', // descriptionf
//     importance: Importance.max,
//     enableLights: true,
//     enableVibration: true,
//     showBadge: true,
//     playSound: true);

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

class FirebaseMessagingService {


  notificationOnMessageHandler() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      print("foreground handler${message.data}");
      print(message);
      if (notification != null && android != null) {
        print('here !!!');
        print('notification title: ${notification.title}');
        // flutterLocalNotificationsPlugin.show(
        //     notification.hashCode,
        //     notification.title.toString(),
        //     notification.body.toString(),
        //     NotificationDetails(
        //       android: AndroidNotificationDetails(
        //           channel.id.toString(), channel.name.toString(),
        //           icon: '@drawable/ic_notification_icon',
        //           enableVibration: true,
        //           enableLights: true,
        //           importance: Importance.max,
        //           priority: Priority.max,
        //           channelDescription: channel.description,
        //           playSound: true,
        //           color: AppColors.mainRed),
        //     ));
      } else {
        print('inside else');
      }
    });
  }
  Future iOSNotificationHandler() async {
    if (Platform.isIOS) {
      FirebaseMessaging.instance.requestPermission(alert: true,sound: true);
    }
  }

  Future notificationOnMessageOpened() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      //AwesomeNotifications().cancelAll();
      print("onmesage open handler${message.data}");
      print(message);
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
    });
    return Future.value();
  }
}
