import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/core/view_model/loaded_project/loaded_project.dart';
import 'package:fliproadmin/ui/view/access_control_screen/builder_access_control_screen.dart';
import 'package:fliproadmin/ui/view/single_progress_screen/single_progress_screen.dart';
import 'package:fliproadmin/ui/view/view_project_screen/view_project_screen.dart';
import 'package:fliproadmin/ui/widget/colored_label.dart';
import 'package:fliproadmin/ui/widget/draw_down_payment_sction.dart';
import 'package:fliproadmin/ui/widget/labeledTextField.dart';
import 'package:fliproadmin/ui/widget/media_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../core/model/access_control_object.dart';

class BuilderTabScreen extends StatelessWidget {
  const BuilderTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => Future.sync(() => Provider.of<LoadedProjectProvider>(context, listen: false).refresh()),
        child: Container(
          width: 100.w,
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: ListView(
            children: [
              Consumer<LoadedProjectProvider>(builder: (ctx, loadedProject, c) {
                if (loadedProject.getLoadingState == loadingState.loading) {
                  return SizedBox(
                    height: 1.h,
                  );
                }

                if (loadedProject.getLoadedProject != null &&
                    (loadedProject.getLoadedProject!.builder != null || loadedProject.getLoadedProject!.latestProgress != null)) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                    child: LabeledTextField(
                      label: "Builder Info",
                      maxlines: null,
                      readonly: true,
                      hintText: loadedProject.getLoadedProject?.builder != null && loadedProject.getLoadedProject!.builder!.isNotEmpty
                          ? loadedProject.getLoadedProject?.builder![0].name
                          : loadedProject.getLoadedProject?.latestProgress != null
                              ? loadedProject.getLoadedProject?.latestProgress?.user?.name!
                              : "No Builder Assigned",
                      labelWidget: loadedProject.getLoadedProject?.latestProgress != null
                          ? ColoredLabel(
                              color: AppColors.lightRed,
                              text: 'Edit Access',
                              callback: () {
                                Navigator.pushNamed(context, BuilderAccessControlScreen.routeName,
                                    arguments: AccessControlObject(
                                        userRoleModel: loadedProject.getBuilderById(loadedProject.getLoadedProject!.latestProgress != null
                                            ? loadedProject.getLoadedProject!.latestProgress!.userId
                                            : 00),
                                        routeName: ViewProjectScreen.routeName));
                              },
                            )
                          : loadedProject.getLoadedProject?.builder != null && loadedProject.getLoadedProject!.builder!.isNotEmpty
                              ? ColoredLabel(
                                  color: AppColors.lightRed,
                                  text: 'Edit Access',
                                  callback: () {
                                    Navigator.pushNamed(context, BuilderAccessControlScreen.routeName,
                                        arguments: AccessControlObject(
                                            userRoleModel: loadedProject.getBuilderById(loadedProject.getLoadedProject!.latestProgress != null
                                                ? loadedProject.getLoadedProject!.latestProgress!.userId
                                                : 00),
                                            routeName: ViewProjectScreen.routeName));
                                  },
                                )
                              : null,
                    ),
                  );
                } else {
                  return Container();
                }
              }),
              SizedBox(
                  height: 55.h,
                  child: Consumer<LoadedProjectProvider>(builder: (ctx, loadedProject, c) {
                    if (loadedProject.getLoadingState == loadingState.loading) {
                      return SizedBox(
                        height: 1.h,
                      );
                    }
                    if (loadedProject.getLoadedProject != null &&
                        loadedProject.getLoadedProject!.latestProgress != null &&
                        loadedProject.getLoadedProject!.latestProgress!.user!.userType == 'builder') {
                      return SingleProgressScreen(
                        showAppBar: false,
                        progressModel: loadedProject.getLoadedProject!.latestProgress!,
                      );
                    } else {
                      return const Center(
                        child: Text("No Progress submitted by Builder"),
                      );
                    }
                  })),
              Consumer<LoadedProjectProvider>(builder: (ctx, loadedProject, c) {
                if (loadedProject.getLoadingState == loadingState.loading) {
                  return SizedBox(
                    height: 1.h,
                  );
                }
                if (loadedProject.getLoadedProject != null &&
                    loadedProject.getLoadedProject!.latestNote != null &&
                    loadedProject.getLoadedProject!.latestNote!.user!.userType == 'builder') {
                  return LabeledTextField(
                    label: "Note",
                    maxlines: 10,
                    readonly: true,
                    hintText: loadedProject.getLoadedProject!.latestNote!.notes!,
                  );
                } else {
                  return Container();
                }
              }),
              SizedBox(
                height: 5.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
