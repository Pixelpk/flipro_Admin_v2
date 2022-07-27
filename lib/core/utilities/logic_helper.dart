// ignore_for_file: unnecessary_null_comparison

import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:fliproadmin/core/services/db_service/db_service.dart';
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/ui/view/login_screen/login_screen.dart';
import 'package:fliproadmin/ui/widget/getx_dialogs.dart';
import 'package:fliproadmin/ui/widget/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

enum appUsers { admin, franchise, evaluator, homeowner, builder }

class LogicHelper {
  static double get getCustomAppBarHeight => AppBar().preferredSize.height + 40;
  static String userTitleHandler(appUsers user) {
    switch (user) {
      case appUsers.admin:
        {
          return 'Admin';
        }
        break;

      case appUsers.franchise:
        {
          return "Franchisee";
        }
        break;
      case appUsers.builder:
        {
          return "Builder";
        }
      case appUsers.evaluator:
        {
          return "Valuer";
        }
      case appUsers.homeowner:
        {
          return "Home Owner";
        }
      default:
        {
          return '';
        }
        break;
    }
  }

  static String getTimeAgo(String date, {bool shortPatter = true}) {
    try {
      DateTime dateTime = DateTime.parse(date);
      if (shortPatter && dateTime != null) {
        return timeago.format(dateTime, locale: 'en_short');
      } else {
        return timeago.format(dateTime);
      }
    } catch (e) {


      return "Some time ago";
    }
  }

  static String getFormattedDate(
    String date,
  ) {
    try {
      DateTime dateTime = DateTime.parse(date);
      return DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);
    } catch (e) {
      print(e);

      return "December 22";
    }
  }

  static String userTypeFromEnum(appUsers user) {
    switch (user) {
      case appUsers.admin:
        {
          return 'admin';
        }
        break;

      case appUsers.franchise:
        {
          return "franchise";
        }
        break;
      case appUsers.builder:
        {
          return "Builder";
        }
      case appUsers.evaluator:
        {
          return "evaluator";
        }
      case appUsers.homeowner:
        {
          return "home-owner";
        }
      default:
        {
          return '';
        }
        break;
    }
  }

  static String getUserTypefromBool(
      {required bool isBuilder,
      required bool isFranchisee,
      required bool isHomeOwner,
      required bool isvaluer}) {
    if (isFranchisee) {
      return "franchise";
    }
    if (isBuilder) {
      return "builder";
    }
    if (isHomeOwner) {
      return "home-owner";
    }
    if (isvaluer) {
      return "evaluator";
    }
    return '';
  }

  static void unauthorizedHandler({bool showMessage = false}) {
    DbService().truncateDb();
    if (showMessage) {
      GetXDialog.showDialog(
          title: "Session Expired", message: "Please Login Again");
    }
    Navigator.of(Get.context!)
        .pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
  }

  static String generateRandomString(int len) {
    var r = Random();
    String randomString =
        String.fromCharCodes(List.generate(len, (index) => r.nextInt(33) + 89));
    return randomString;
  }
}
