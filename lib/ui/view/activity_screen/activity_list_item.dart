import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/ui/view/project_overview_screen/project_overview_Screen.dart';
import 'package:fliproadmin/ui/view/view_project_screen/view_project_screen.dart';
import 'package:fliproadmin/ui/widget/colored_label.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ActivityListItem extends StatelessWidget {
  const ActivityListItem({
    Key? key,
    this.label,
    this.labelColor,
    this.timeStampLabel,
    this.showColoredLabel = false,
  }) : super(key: key);
  final bool showColoredLabel;
  final String? label;
  final Color? labelColor;
  final String? timeStampLabel;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
      padding: EdgeInsets.all(1.2.w),
      child: Row(
        children: [
          Expanded(
              flex: 14,
              child: ClipRRect(
                child: Image.asset(
                  AppConstant.defaultProjectImage,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(15),
              )),
          Expanded(
              flex: 25,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Classify Projects",
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: AppColors.mainThemeBlue),
                      maxLines: 1,
                    ),
                    Text(
                      "Str 123 , Lahore Pakistan ,Punjan ,South asia , Earth , Milkyway Galaxy tr 123 , Lahore Pakistan ,Punjan ,South asia , Earth , Milkyway Galaxytr 123 , Lahore Pakistan ,Punjan ,South asia , Earth , Milkyway Galaxy ",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: AppColors.greyDark),
                      maxLines: 3,
                    ),
                    Row(
                      children: [
                        showColoredLabel
                            ? ColoredLabel(
                                color: labelColor!,
                                text: label!,
                                margin: 0,
                                pading: const EdgeInsets.all(2),
                              )
                            : const Spacer(),
                        const Spacer(),
                        Text(
                          "$timeStampLabel Today",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(
                                  color: AppColors.mainThemeBlue,
                                  overflow: TextOverflow.visible),
                        )
                      ],
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
