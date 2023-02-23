import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

InputDecoration customInputDecoration(
        {required BuildContext context,
        String prefixIcon = '',
        String? prefixText = '',
        required String hintText,
        bool usePrefixIcon = true,
        Widget? suffixIcon,
        Color fillColor = Colors.white,
        double? height,
        Color? prefixColor,
        double? width}) =>
    InputDecoration(
        prefixText: prefixText,
        prefixStyle: Theme.of(context).textTheme.bodyText1,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        fillColor: fillColor,
        filled: true,
        hintText: hintText,
        suffixIcon: suffixIcon,
        hintStyle: Theme.of(context).textTheme.subtitle1!.copyWith(color: AppColors.greyFontColor),
        prefixIcon: usePrefixIcon
            ? Padding(
                padding: EdgeInsets.all(2.2.h),
                child: prefixIcon == 'default'
                    ? const Icon(Icons.search, color: AppColors.mainThemeBlue)
                    : SvgPicture.asset(prefixIcon,
                        color: prefixColor ?? AppColors.blueUnselectedTabColor, height: height, width: width))
            : null);
