import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/core/view_model/loaded_project/loaded_project.dart';
import 'package:fliproadmin/core/view_model/projects_provider/projects_provider.dart';
import 'package:fliproadmin/ui/widget/main_button.dart';
import 'package:fliproadmin/ui/widget/media_section.dart';
import 'package:fliproadmin/ui/widget/project_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'custom_app_bar.dart';

class ViewProjectDetails extends StatelessWidget {
  const ViewProjectDetails({
    Key? key,
  }) : super(key: key);
  static const routeName = '/ViewProjectDetails';

  @override
  Widget build(BuildContext context) {
    final projectRejected = ModalRoute.of(context)!.settings.arguments as bool;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(LogicHelper.getCustomAppBarHeight),
        child: CustomAppBar(
          bannerText: projectRejected ? "Project Rejected" : "Project Details",
          showBothIcon: false,
          showShareIcon: true,
          showNoteIcon: true,
          automaticallyImplyLeading: true,
          bannerColor: projectRejected ? AppColors.lightRed : null,
        ),
      ),
      body: SizedBox(
        height: 100.h,
        child:   Consumer<LoadedProjectProvider>(builder: (ctx, project, c) {
          if (project.getLoadedProject == null &&
              project.getLoadingState == loadingState.loaded) {
            return Container();
          }
          if (project.getLoadingState == loadingState.loading) {
            return Container();
          }
            return ListView(
              children: [
                const ProjectInfoSection(),
                 MediaSection(
                   media: project.getLoadedProject!.projectMedia!,
                 ),
                const SizedBox(
                  height: 30,
                ),

                   Row(
                    mainAxisAlignment: projectRejected
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.spaceEvenly,
                    children: [
                      projectRejected
                          ? Container()
                          : MainButton(
                              height: 6.h,
                              buttonText: "Reject",
                              buttonColor: AppColors.darkRed,
                              width: 30.w,
                              radius: 8,
                              userArrow: false,
                              callback: () {
                                Provider.of<ProjectsProvider>(context,
                                        listen: false)
                                    .approveRejectProject(
                                        isApproved: false,
                                        projectId: project.getLoadedProject!.id!,
                                        doPop: true);
                              },
                            ),
                      MainButton(
                        height: 6.h,
                        buttonText: "Approve",
                        buttonColor: AppColors.green,
                        width: 30.w,
                        userArrow: false,
                        radius: 8,
                        callback: () {
                          Provider.of<ProjectsProvider>(context, listen: false)
                              .approveRejectProject(
                                  isApproved: true,
                                  projectId: project.getLoadedProject!.id!,
                                  doPop: true);
                        },
                      ),
                    ],
                  )

              ],
            );
          }
        ),
      ),
    );
  }
}
