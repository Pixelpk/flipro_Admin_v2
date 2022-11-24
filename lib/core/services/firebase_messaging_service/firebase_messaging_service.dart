import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../global_data/global_data.dart';
import '../../../ui/view/view_project_screen/view_project_screen.dart';
import '../../services/db_service/db_service.dart';
import '../../utilities/app_colors.dart';
import '../../utilities/app_constant.dart';
import '../../view_model/loaded_project/loaded_project.dart';
import '../../view_model/user_provider/user_provider.dart';

class FirebaseMessagingService {
  static Future<void> setupBackgroundInteractedMessage() async {
    /// Also handle any interaction when the app is in the background via a
    /// Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);
  }

  static Future<void> setupTerminatedInteractedMessage(
      BuildContext context) async {
    /// Get any messages which caused the application to open from
    /// a terminated state.
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();
    print("TERMINATED STATE HANDLER");

    /// If the message also contains a data property with a "type" of "chat",
    /// navigate to a chat screen
    if (initialMessage != null) {
      _handleTerminatedMessage(initialMessage, context);
    }
  }

  static _handleBackgroundMessage(RemoteMessage message) async {
    BuildContext context = Get.context!;
    final dbService = DbService();

    ///CHECKS IF CURRENT USER IS LOGGED IN IF YES THEN HANDLE NOTIFICATION
    if (dbService.hasData(AppConstant.getToken) &&
        dbService.readString(AppConstant.getToken) != null &&
        dbService.readJson(AppConstant.getCurrentUser) != null) {
      ///if received notification is not null
      if (message != null && message.notification != null) {
        ///Load current user to memory and set changeUserType to true so
        ///navigation from middlewareScreen will be ignored and below will be used

        ///navigate to specific screen according to type of notification
        print('notification title: ${message.notification!.title}');

        if(message.data.containsKey('id')) {
          int? pId = int.tryParse(message.data['id']);
          await Provider.of<LoadedProjectProvider>(context, listen: false)
              .fetchLoadedProject(pId ?? 0);
          print(Get.currentRoute);
          Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ViewProjectScreen()));
        }}}


  }

  static _handleTerminatedMessage(
      RemoteMessage message, BuildContext context) async {
    final dbService = DbService();
    print("TERMINATED STATE FUNCTIONS");

    ///CHECKS IF CURRENT USER IS LOGGED IN IF YES THEN HANDLE NOTIFICATION
    if (dbService.hasData(AppConstant.getToken) &&
        dbService.readString(AppConstant.getToken) != null &&
        dbService.readJson(AppConstant.getCurrentUser) != null) {
      print("TERMINATED STATE IF TRUE");

      ///if received notification is not null
      if (message.data != null && message.notification != null) {
        ///navigate to specific screen according to type of notification
        print('notification title: ${message.notification!.title}');

        if(message.data.containsKey('id')) {
          int? pId = int.tryParse(message.data['id']);
          await Provider.of<LoadedProjectProvider>(context, listen: false)
              .fetchLoadedProject(pId ?? 0);
          print(Get.currentRoute);
          Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ViewProjectScreen()));
        }


      }
    }
  }

  notificationOnMessageHandler() {
    BuildContext context = Get.context!;
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("${message.data}");
      if( message.notification!=null)
      {
        Get.snackbar(
            message.notification!.title ?? '', message.notification!.body ?? '',
            colorText: AppColors.mainThemeBlue,
            backgroundColor: Colors.white,
            overlayColor: Colors.amber,
            snackPosition: SnackPosition.TOP, onTap: (g) {
          if(message.data.containsKey('id')) {
            int? pId = int.tryParse(message.data['id']);
            Provider.of<LoadedProjectProvider>(context, listen: false)
                .fetchLoadedProject(pId ?? 0);
            print(Get.currentRoute);
            Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ViewProjectScreen()));
          }
          print(Get.currentRoute);
        },
            icon: const Icon(
              Icons.notifications,
              color: AppColors.mainThemeBlue,
            ),
            margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 5.h));
      }
    });
  }

  Future iOSNotificationHandler() async {
    if (Platform.isIOS) {
      FirebaseMessaging.instance.requestPermission(
        alert: false,
        sound: true,
      );
    }
  }
}