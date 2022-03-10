
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/ui/view/image_gridview_screen/image_grid_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import 'colored_label.dart';

class MediaSection extends StatelessWidget {
  const MediaSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Row(
            children: [
              Text(
                "Media",
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: AppColors.greyFontColor),
              ),
              const Spacer(),
              ColoredLabel(
                  callback: () {
                    Navigator.of(context)
                        .pushNamed(ImageGridViewScreen.routeName);
                  },
                  color: AppColors.mainThemeBlue,
                  text: 'View all')
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 1.h),
          width: 100.w,
          height: 13.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
            separatorBuilder: (context, index) {
              return const SizedBox(
                width: 5,
              );
            },
            itemBuilder: (context, index) {
              return SvgPicture.asset(AppConstant.defaultImage,
                  width: 10.w, height: 13.h);
            },
            itemCount: 10,
            scrollDirection: Axis.horizontal,
          ),
        ),
      ],
    );
  }
}
