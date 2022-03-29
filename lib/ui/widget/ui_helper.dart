import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class UIHelper {
  static void deleteDialog(
      String subtitle, VoidCallback confirmCallBack, BuildContext context ,{String? title}) {
    Get.defaultDialog(
        title:title?? "Delete",
        backgroundColor: AppColors.mainThemeBlue,
        onConfirm: confirmCallBack,

        buttonColor: Colors.white,
        textConfirm: 'Yes',
        titleStyle: Theme.of(context).textTheme.headline5,
        titlePadding: const EdgeInsets.all(12),
        textCancel: "No",
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        confirmTextColor: AppColors.mainThemeBlue,
        radius: 8,
        middleText: subtitle,
        middleTextStyle: TextStyle(color: Colors.white),
        cancelTextColor: Colors.white);
  }

}
