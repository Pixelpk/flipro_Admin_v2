import 'package:fliproadmin/core/services/db_service/db_service.dart';
import 'package:fliproadmin/ui/view/login_screen/login_screen.dart';
import 'package:fliproadmin/ui/widget/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      return "homeowner";
    }
    if (isvaluer) {
      return "evaluator";
    }
    return '';
  }

  static void unauthorizedHandler(){
    DbService().truncateDb();
    Navigator.of(Get.context!).pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
  }



}
