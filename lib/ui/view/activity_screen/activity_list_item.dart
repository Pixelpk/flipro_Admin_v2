import 'package:cached_network_image/cached_network_image.dart';
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/core/view_model/home_provider/home_provider.dart';
import 'package:fliproadmin/core/view_model/loaded_project/loaded_project.dart';
import 'package:fliproadmin/core/view_model/project_provider/project_provider.dart';
import 'package:fliproadmin/ui/view/project_overview_screen/project_overview_Screen.dart';
import 'package:fliproadmin/ui/view/view_project_screen/view_project_screen.dart';
import 'package:fliproadmin/ui/widget/colored_label.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ActivityListItem extends StatelessWidget {
  const ActivityListItem({
    Key? key,
    this.label,
    this.labelColor,
    this.timeStampLabel,
    this.project,
    this.showColoredLabel = false,
  }) : super(key: key);
  final bool showColoredLabel;
  final String? label;
  final Color? labelColor;
  final String? timeStampLabel;
  final ProjectProvider? project;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<HomeProvider>(context,listen: false).onProjectViewPageChange(0);
        Provider.of<LoadedProjectProvider>(context, listen: false)
            .fetchLoadedProject(project!.getProject.id!);
        Navigator.of(context).pushNamed(ViewProjectScreen.routeName,
            arguments: false);
      },
      child: Container(
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
                flex: 11,
                child: ClipRRect(
                  child:  CachedNetworkImage(
                    imageUrl:          project!.getProject.coverPhoto ?? ''
                 ,   fit: BoxFit.cover,
                  height: double.infinity,
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        CircularProgressIndicator(value: downloadProgress.progress),
                    errorWidget: (context, url, error) => Icon(Icons.error),
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
                        project!.getProject.title!,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: AppColors.mainThemeBlue),
                        maxLines: 1,
                      ),
                      Text(
                        project!.getProject.projectAddress!,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: AppColors.greyDark),
                        maxLines: 3,
                        overflow: TextOverflow.fade,
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
                            "${LogicHelper.getTimeAgo(project!.getProject.createdAt!,)}",
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
      ),
    );
  }
}
