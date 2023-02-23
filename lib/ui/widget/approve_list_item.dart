import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/view_model/loaded_project/loaded_project.dart';
import 'package:fliproadmin/core/view_model/project_provider/project_provider.dart';
import 'package:fliproadmin/core/view_model/projects_provider/projects_provider.dart';
import 'package:fliproadmin/ui/widget/view_project_details.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'custom_cache_network_image.dart';

class ApproveListItem extends StatelessWidget {
  const ApproveListItem(
      {Key? key, this.viewProjectCallback, this.rejected = true, this.projectProvider, this.pagingController})
      : super(key: key);
  final VoidCallback? viewProjectCallback;
  final PagingController? pagingController;

  final ProjectProvider? projectProvider;
  final bool rejected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.w),
      margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 50,
              child: InkWell(
                  onTap: () async {
                    Provider.of<LoadedProjectProvider>(context, listen: false)
                        .fetchLoadedProject(projectProvider!.getProject.id!);
                    final refresh =
                        await Navigator.pushNamed(context, ViewProjectDetails.routeName, arguments: rejected);
                    if (refresh != null && refresh == true) {
                      pagingController!.refresh();
                    }
                  },
                  child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    Expanded(
                        flex: 20,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CustomCachedImage(
                                imageUrl: projectProvider!.getProject.coverPhoto ?? '', fit: BoxFit.cover))),
                    Expanded(
                        flex: 30,
                        child: Padding(
                            padding: const EdgeInsets.only(left: 4, right: 2),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("${projectProvider!.getProject.title}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(color: AppColors.mainThemeBlue),
                                      maxLines: 1),
                                  Text("${projectProvider!.getProject.projectAddress}",
                                      style: Theme.of(context).textTheme.subtitle1!.copyWith(color: AppColors.greyDark),
                                      maxLines: 3)
                                ])))
                  ]))),
          Expanded(
              flex: rejected ? 15 : 20,
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                rejected
                    ? Text("Rejected",
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(color: AppColors.lightRed))
                    : Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                        GestureDetector(
                            onTap: () async {
                              bool doRefresh = await Provider.of<ProjectsProvider>(context, listen: false)
                                  .approveRejectProject(
                                      isApproved: true, projectId: projectProvider!.getProject.id!, doPop: false);
                              if (doRefresh != null && doRefresh == true) {
                                pagingController!.refresh();
                              }
                            },
                            child: Column(children: const [
                              Icon(Icons.check_circle, color: AppColors.green),
                              Text("Accept", style: TextStyle(fontSize: 8), overflow: TextOverflow.fade)
                            ])),
                        GestureDetector(
                            onTap: () async {
                              bool doRefresh = await Provider.of<ProjectsProvider>(context, listen: false)
                                  .approveRejectProject(
                                      isApproved: false, projectId: projectProvider!.getProject.id!, doPop: false);
                              if (doRefresh != null && doRefresh == true) {
                                pagingController!.refresh();
                              }
                            },
                            child: Column(children: const [
                              Icon(Icons.cancel, color: AppColors.darkRed),
                              Text("Reject", style: TextStyle(fontSize: 8), overflow: TextOverflow.fade)
                            ]))
                      ])
              ]))
        ],
      ),
    );
  }
}
