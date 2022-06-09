
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

InputDecoration customInputDecoration(
    {required  BuildContext context,  String prefixicon = '',required String hintText ,bool usePrefixIcon = true ,Widget? suffixIcon , Color fillColor = Colors.white}) {
  return InputDecoration(
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none),
    fillColor: fillColor,
    filled: true,
    hintText: hintText,
    suffixIcon: suffixIcon,
    hintStyle: Theme.of(context)
        .textTheme
        .subtitle1!
        .copyWith(color: AppColors.greyFontColor),
    prefixIcon:usePrefixIcon ? Padding(
      padding: EdgeInsets.all(2.2.h),
      child: prefixicon == 'default' ? Icon(Icons.search,color:AppColors.mainThemeBlue):SvgPicture.asset(
        prefixicon,
        color: AppColors.blueUnselectedTabColor,
      ),
    ):null,
  );
}

