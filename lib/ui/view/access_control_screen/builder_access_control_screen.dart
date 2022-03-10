import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/ui/widget/SwitchTile.dart';
import 'package:fliproadmin/ui/widget/main_button.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'access_control_appbar.dart';

class BuilderAccessControlScreen extends StatelessWidget {
  const BuilderAccessControlScreen({Key? key}) : super(key: key);
  static const routeName = '/BuilderAccessControlScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(25.h),
        child: const AccessControlAppBar(title: "Builder",),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        width: double.infinity,
        height: 75.h,
        child: ListView(
          children: [
            SizedBox(
              height: 8.h,
            ),
            SizedBox(
              height: 8.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: Text(
                      "BUILDER NAME",
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: AppColors.mainThemeBlue,
                          ),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Flexible(
                    child: Text("LOCATION",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: AppColors.greyDark,
                            ),
                        maxLines: 2,
                        textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            SwitchTile(
              private: true,
              width: 90.w,
              heigth: 7.5.h,
              tileTitle: "Can Update Progress",
            ),
            SizedBox(
              height: 4.h,
            ),
            SwitchTile(
              private: true,
              tileTitle: "Can Add Photos",
            ),
            SizedBox(
              height: 4.h,
            ),
            SwitchTile(
              private: true,
              tileTitle: "Add Notes/Review",
            ),
            SizedBox(
              height: 8.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MainButton(
                  height: 7.h,
                  buttonText: "Confirm",
                  width: 60.w,
                  radius: 15,
                  userArrow: false,
                  callback: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
