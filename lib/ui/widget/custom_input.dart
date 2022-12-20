
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../core/utilities/app_colors.dart';

InputDecoration customInputDecoration1(
    {required BuildContext context,
      String prefixicon = '',
      String? prefixText = '',
      required String hintText,
      bool usePrefixIcon = true,
      Widget? suffixIcon,
      Widget? prefixIcon,
      double? height,
      Color? prefixColor,
      double? width,
      Color fillColor = Colors.white}) {
  return InputDecoration(
    prefixText: prefixText,
    prefixStyle: Theme.of(context).textTheme.bodyText1,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
    fillColor: fillColor,
    filled: true,
    hintText: hintText,
    suffixIcon: suffixIcon,
    hintStyle: Theme.of(context).textTheme.subtitle1!.copyWith(color: AppColors.greyFontColor),
    prefixIcon: usePrefixIcon
        ? prefixIcon ??
        Padding(
          padding: EdgeInsets.all(2.2.h),
          child: prefixicon == 'default'
              ? const Icon(Icons.search, color: AppColors.mainThemeBlue)
              : SvgPicture.asset(
            prefixicon,
            color: prefixColor ??AppColors.blueUnselectedTabColor,
            height: height,
            width: width,
          ),
        )
        : null,
  );
}
