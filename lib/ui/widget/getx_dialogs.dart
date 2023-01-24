import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../core/utilities/app_colors.dart';

Future<void> showLoadingDialog({String title = "Processing...", bool showCancelIcon = false}) async {
  return showDialog<void>(
    context: Get.context!,
    barrierDismissible: false,
    // user must tap button!
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () => Future.value(false),
        child: AlertDialog(
          title: showCancelIcon
              ? GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Align(alignment: Alignment.topRight, child: Icon(Icons.cancel)))
              : Container(),
          content: SizedBox(
            width: 80.w,
            height: 8.h,
            child: Row(
              children: [
                const CircularProgressIndicator(),
                Expanded(flex: 5, child: Container()),
                Expanded(flex: 20, child: Text(title)),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class GetXDialog {
  static showDialog({String? message, String? title, Color? backgroundColor, Color? textColor, Duration? duration}) {
    Get.snackbar(title!, message!,
        backgroundColor: backgroundColor ?? AppColors.mainThemeBlue,
        colorText: textColor ?? Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: duration ?? const Duration(seconds: 3),
        margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h));
  }
}
