import 'package:cached_network_image/cached_network_image.dart';
import 'package:fliproadmin/core/model/project_response/project_response.dart';
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/ui/widget/colored_label.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TrademanListItem extends StatelessWidget {
  const TrademanListItem({
    Key? key,
    this.userRoleModel,
    this.showAssignButton = false,
  }) : super(key: key);
  final bool showAssignButton;
  final UserRoleModel? userRoleModel;

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
          userRoleModel!.avatar!.isEmpty || userRoleModel!.avatar == null
              ? const CircleAvatar(backgroundImage: AssetImage(AppConstant.defaultProjectImage))
              : CircleAvatar(backgroundImage: CachedNetworkImageProvider(userRoleModel!.avatar!)),
          Container(
            width: 1,
            height: 6.5.h,
            color: AppColors.greyFontColor.withOpacity(0.5),
            margin: EdgeInsets.symmetric(horizontal: 2.w),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              userRoleModel!.userType == "builder" || userRoleModel!.userType == "evaluator"
                  ? SizedBox(
                      width: 45.w,
                      child: Text("${userRoleModel!.companyName}",
                          style: Theme.of(context).textTheme.bodyText1, maxLines: 1, overflow: TextOverflow.ellipsis),
                    )
                  : Container(),
              userRoleModel!.userType == "builder" || userRoleModel!.userType == "evaluator"
                  ? Text("${userRoleModel!.name}",
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(color: AppColors.greyFontColor))
                  : SizedBox(
                      width: 45.w,
                      child: Text("${userRoleModel!.name}",
                          style: Theme.of(context).textTheme.bodyText1, maxLines: 1, overflow: TextOverflow.ellipsis),
                    ),
              Text("${userRoleModel!.address}",
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(color: AppColors.greyFontColor)),
            ],
          ),
          const Spacer(),
          showAssignButton ? ColoredLabel(color: AppColors.mainThemeBlue, text: "Assign", height: 4.h) : Container()
        ],
      ),
    );
  }
}
