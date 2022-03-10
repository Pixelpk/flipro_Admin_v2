import 'package:fliproadmin/core/model/users_model/users_model.dart';
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/ui/view/access_control_screen/builder_access_control_screen.dart';
import 'package:fliproadmin/ui/view/notes_screen/note_view_screen.dart';
import 'package:fliproadmin/ui/widget/colored_label.dart';
import 'package:fliproadmin/ui/widget/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class TrademanListItem extends StatelessWidget {
   TrademanListItem({
    Key? key,
    required this.title,
    required this.member,
  }) : super(key: key);
  Member member ;
  final String title ;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 3.w),
      height: 9.h,
      width: 90.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage(AppConstant.defaultProjectImage),
          ),
          Container(
            width: 1,
            height: 6.5.h,
            color: AppColors.greyFontColor.withOpacity(0.5),
            margin: EdgeInsets.symmetric(
              horizontal: 2.w,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 45.w,
                child: Text(
                  "${member.name}",
                  style: Theme.of(context).textTheme.bodyText1,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(    "${member.address}",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: AppColors.greyFontColor)),
            ],
          ),
          const Spacer(),
          ColoredLabel(
            color: AppColors.mainThemeBlue,
            text: "View Profile",
            height: 4.h,
          )
        ],
      ),
    );
  }
}
