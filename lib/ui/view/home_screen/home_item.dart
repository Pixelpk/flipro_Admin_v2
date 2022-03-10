import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/ui/view/view_unassigned_project/view_unassigned_project.dart';
import 'package:fliproadmin/ui/widget/colored_label.dart';
import 'package:fliproadmin/ui/widget/custom_app_bar.dart';
import 'package:fliproadmin/ui/widget/main_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import 'home_screen.dart';

class HomeItem extends StatelessWidget {
  const HomeItem({Key? key, required this.project}) : super(key: key);

  final home project;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(ViewUnassignedProject.routeName);
      },
      child: Container(
        padding: EdgeInsets.all(1.5.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        // padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
                flex: 40,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      AppConstant.defaultProjectImage,
                      width: 100.w,
                      fit: BoxFit.cover,
                    ))),
            Expanded(
                flex: 13,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              project.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.room,
                                size: 12,
                                color: AppColors.mainThemeBlue,
                              ),
                              Flexible(
                                  child: Text(
                                project.loc,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: Theme.of(context).textTheme.subtitle2,
                              ))
                            ],
                          )
                        ],
                      )),
                      SvgPicture.asset(
                        project.assigned
                            ? AppConstant.approved
                            : AppConstant.rejected,
                        height: 5.w,
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
