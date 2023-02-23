import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/utils.dart';
import 'package:get_storage/get_storage.dart';
import '../firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("background handler${message.data}");
  if (message.notification != null) {
    print("BACKGROUND NOTIFICATION ${message.notification!.title}");
  }
  print(message);
}

Future initServices() async {
  Get.log('starting services ...');
  await GetStorage.init();
  // await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //     AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  await precacherSVG();
  Get.log('All services started...');
  return Future.value();
}

Future precacherSVG() async {
  List<String> svgs = [AppConstant.logoWhite, AppConstant.homeLogo];
  return Future.wait(List.generate(svgs.length, (index) async {
    print("precaching svg $index");
    await precachePicture(
      ExactAssetPicture(
        SvgPicture.svgStringDecoderBuilder,
        svgs[index],
      ),
      null,
    );
  }));
}
