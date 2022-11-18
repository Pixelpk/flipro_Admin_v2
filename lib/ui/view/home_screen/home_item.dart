import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/core/view_model/loaded_project/loaded_project.dart';
import 'package:fliproadmin/core/view_model/project_provider/project_provider.dart';
import 'package:fliproadmin/ui/view/view_unassigned_project/view_unassigned_project.dart';
import 'package:fliproadmin/ui/widget/custom_cache_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'home_screen.dart';

class HomeItem extends StatelessWidget {
  const HomeItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("HOME ITEM REBUIKTS");
    final projectProvider = Provider.of<ProjectProvider>(context).getProject;
    if (projectProvider == null) {
      return Text(
        "shkgfb",
        style: TextStyle(color: Colors.black),
      );
    } else {
      return InkWell(
        onTap: () {
          Provider.of<LoadedProjectProvider>(context, listen: false).fetchLoadedProject(projectProvider.id!);
          Navigator.of(context).pushNamed(ViewUnassignedProject.routeName);
          if (!projectProvider.assigned!) {
          } else {}
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
                    child: CustomCachedImage(
                      imageUrl: projectProvider.coverPhoto ?? '',
                      width: 100.w,
                      fit: BoxFit.cover,
                    ),
                  )),
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
                            Row(
                              children: [
                                const Icon(
                                  Icons.room,
                                  size: 12,
                                  color: AppColors.mainThemeBlue,
                                ),
                                Flexible(
                                    child: Text(
                                  projectProvider.title!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ))
                              ],
                            ),
                            Flexible(
                              child: Text(
                                projectProvider.projectAddress!,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ),
                          ],
                        )),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              projectProvider.assigned! ? AppConstant.approved : AppConstant.rejected,
                              height: 5.w,
                            ),
                            Text(
                              "Unassigned",
                              style: Theme.of(context).textTheme.subtitle2,
                            )
                          ],
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      );
    }
  }
}
