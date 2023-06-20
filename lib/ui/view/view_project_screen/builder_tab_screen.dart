import 'package:fliproadmin/core/helper/call_helper.dart';
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/core/view_model/loaded_project/loaded_project.dart';
import 'package:fliproadmin/ui/view/access_control_screen/builder_access_control_screen.dart';
import 'package:fliproadmin/ui/view/single_progress_screen/single_progress_screen.dart';
import 'package:fliproadmin/ui/view/view_project_screen/view_project_screen.dart';
import 'package:fliproadmin/ui/widget/colored_label.dart';
import 'package:fliproadmin/ui/widget/labeledTextField.dart';
import 'package:fliproadmin/ui/widget/mask.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../core/model/access_control_object.dart';
import '../assigned_trademan_screen/assigned_trademan_view.dart';

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
                if (loadedProject.getLoadingState == LoadingState.loading) {
                  return SizedBox(height: 1.h);
                }
                if (loadedProject.getLoadedProject != null &&
                    (loadedProject.getLoadedProject!.builder != null ||
                        loadedProject.getLoadedProject!.latestProgress != null)) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                        child: LabeledTextField(
                            label: "Agents/Trades Info",
                            maxLines: null,
                            readonly: true,
                            hintText: loadedProject.getLoadedProject?.latestProgress != null
                                ? loadedProject.getLoadedProject?.latestProgress?.user?.name!
                                : loadedProject.getLoadedProject?.builder != null &&
                                        loadedProject.getLoadedProject!.builder!.isNotEmpty
                                    ? loadedProject.getLoadedProject?.builder![0].name
                                    : "No Agents/Trades Info",
                            labelWidget: loadedProject.getLoadedProject?.builder != null &&
                                        loadedProject.getLoadedProject!.builder!.isNotEmpty ||
                                    loadedProject.getLoadedProject?.latestProgress != null
                                ? ColoredLabel(
                                    color: AppColors.lightRed,
                                    text: 'Edit Access',
                                    callback: () {
                                      Navigator.pushNamed(
                                        context,
                                        BuilderAccessControlScreen.routeName,
                                        arguments: AccessControlObject(
                                          userRoleModel: loadedProject.getBuilderById(
                                            loadedProject.getLoadedProject!.latestProgress != null
                                                ? loadedProject.getLoadedProject!.latestProgress!.userId
                                                : loadedProject.getLoadedProject?.builder != null &&
                                                        loadedProject.getLoadedProject!.builder!.isNotEmpty
                                                    ? loadedProject.getLoadedProject?.builder!.first.id
                                                    : 00,
                                          ),
                                          routeName: ViewProjectScreen.routeName,
                                        ),
                                      );
                                    },
                                  )
                                : null
                            // ? ColoredLabel(
                            //     color: AppColors.lightRed,
                            //     text: 'Edit Access',
                            //     callback: () {
                            //       Navigator.pushNamed(
                            //         context,
                            //         BuilderAccessControlScreen.routeName,
                            //         arguments: AccessControlObject(
                            //           userRoleModel:
                            //               loadedProject.getBuilderById(
                            //             loadedProject.getLoadedProject!
                            //                         .latestProgress !=
                            //                     null
                            //                 ? loadedProject
                            //                     .getLoadedProject!
                            //                     .latestProgress!
                            //                     .userId
                            //                 : loadedProject.getLoadedProject
                            //                                 ?.builder !=
                            //                             null &&
                            //                         loadedProject
                            //                             .getLoadedProject!
                            //                             .builder!
                            //                             .isNotEmpty
                            //                     ? loadedProject
                            //                         .getLoadedProject
                            //                         ?.builder!
                            //                         .first
                            //                         .id
                            //                     : 00,
                            //           ),
                            //           routeName:
                            //               ViewProjectScreen.routeName,
                            //         ),
                            //       );
                            //     },
                            //   )
                            // : loadedProject.getLoadedProject
                            //             ?.latestProgress !=
                            //         null
                            //     ? ColoredLabel(
                            //         color: AppColors.lightRed,
                            //         text: 'Edit Access',
                            //         callback: () {
                            //           print(loadedProject.getLoadedProject
                            //               ?.latestProgress?.user
                            //               ?.toJson());
                            //           Navigator.pushNamed(
                            //               context,
                            //               BuilderAccessControlScreen
                            //                   .routeName,
                            //               arguments: AccessControlObject(
                            //                   userRoleModel: loadedProject
                            //                       .getBuilderById(loadedProject
                            //                                   .getLoadedProject!
                            //                                   .latestProgress !=
                            //                               null
                            //                           ? loadedProject
                            //                               .getLoadedProject!
                            //                               .latestProgress!
                            //                               .user!
                            //                               .id
                            //                           : 00),
                            //                   routeName: ViewProjectScreen
                            //                       .routeName));
                            //         },
                            //       )
                            //     : null,
                            ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                        child: LabeledTextField(
                            label: "Agents/Trades Contact",
                            maxLines: null,
                            onTab: () => launchCaller("${loadedProject.getLoadedProject?.builder![0].phone}"),
                            readonly: true,
                            hintText: MaskedTextController(
                                    mask: "+00 000 000 000",
                                    text: loadedProject.getLoadedProject?.builder != null &&
                                            loadedProject.getLoadedProject!.builder!.isNotEmpty
                                        ? "${loadedProject.getLoadedProject?.builder![0].phoneCode}${loadedProject.getLoadedProject?.builder![0].phone}"
                                        // : loadedProject.getLoadedProject?.latestProgress != null
                                        //     ? loadedProject.getLoadedProject?.latestProgress?.user?.name!
                                        : "No Agents/Trades Contact")
                                .text),
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              }),
              SizedBox(
                  height: 55.h,
                  child: Consumer<LoadedProjectProvider>(builder: (ctx, loadedProject, c) {
                    if (loadedProject.getLoadingState == LoadingState.loading) {
                      return SizedBox(height: 1.h);
                    }
                    if (loadedProject.getLoadedProject != null &&
                        loadedProject.getLoadedProject!.latestProgress != null &&
                        loadedProject.getLoadedProject!.latestProgress!.user!.userType == 'builder') {
                      return SingleProgressScreen(
                          showAppBar: false, progressModel: loadedProject.getLoadedProject!.latestProgress!);
                    } else {
                      return const Center(
                        child: Text("No Progress submitted by Agents/Trades"),
                      );
                    }
                  })),
              Consumer<LoadedProjectProvider>(builder: (ctx, loadedProject, c) {
                if (loadedProject.getLoadingState == LoadingState.loading) {
                  return SizedBox(height: 1.h);
                }
                if (loadedProject.getLoadedProject != null &&
                    loadedProject.getLoadedProject!.latestNote != null &&
                    loadedProject.getLoadedProject!.latestNote!.user!.userType == 'builder') {
                  return LabeledTextField(
                    label: "Note",
                    maxLines: 10,
                    readonly: true,
                    hintText: loadedProject.getLoadedProject!.latestNote!.notes!,
                  );
                } else {
                  return Container();
                }
              }),
              SizedBox(height: 5.h)
            ],
          ),
        ),
      ),
    );
  }
}
