
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class LoginAppBar extends StatelessWidget {
  const LoginAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24.h,
      padding: EdgeInsets.symmetric(horizontal: 4.5.w),
      color: AppColors.mainThemeBlue,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SvgPicture.asset(
              AppConstant.logoWhite,
              height: 6.h,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "LOGIN",
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(color: Colors.white),
                    ),
                    Text(
                      "Please sign in to continue",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: Colors.white),
                    )
                  ],
                ),
                Expanded(child: Container()),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 6),
                  child: Text(
                    "ADMIN APP",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: AppColors.mainThemeBlue),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
