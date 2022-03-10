import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class GetXDialog {
  showDialog(
      {String? message,
      String? title,
      Color? backgroundColor,
      Color? textColor,
      Duration? duration}) {
    Get.snackbar(title!, message!,
        backgroundColor: backgroundColor ?? AppColors.mainThemeBlue,
        colorText: textColor ?? Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: duration ?? const Duration(seconds: 3),
        margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h));
  }
}
