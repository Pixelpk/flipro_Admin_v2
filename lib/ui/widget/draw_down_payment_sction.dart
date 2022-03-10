
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'colored_label.dart';
import 'media_section.dart';

class DrawDownPaymentScetion extends StatelessWidget {
  const DrawDownPaymentScetion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                "Drawdown Payment Request",
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: AppColors.greyDark),
              ),
            ),
            const Spacer(),
            const ColoredLabel(text: 'View All')
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.blueUnselectedTabColor),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "REQUESTED AMOUNT",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: AppColors.mainThemeBlue),
                  ),
                  Expanded(
                      child: ColoredLabel(
                        text: '100,000,000\$',
                        height: 6.h,
                      ))
                ],
              ),
              SizedBox(
                height: 4.h,
              ),
              const MediaSection(),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ColoredLabel(
                    text: 'Approve',
                    height: 6.h,
                    color: AppColors.green,
                    width: 30.w,
                  ),
                  ColoredLabel(
                    text: 'Reject',
                    height: 6.h,
                    color: AppColors.lightRed,
                    width: 30.w,
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
