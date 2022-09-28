import 'package:fliproadmin/core/model/access_control_object.dart';
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/core/view_model/loaded_project/loaded_project.dart';
import 'package:fliproadmin/core/view_model/project_provider/project_provider.dart';
import 'package:fliproadmin/core/view_model/user_provider/user_provider.dart';
import 'package:fliproadmin/ui/view/access_control_screen/franchisee_access_control_screen.dart';
import 'package:fliproadmin/ui/view/access_control_screen/home_owner_access_control.dart';
import 'package:fliproadmin/ui/view/add_project_screen/add_project_screen.dart';
import 'package:fliproadmin/ui/view/project_activity_timeline_screen/project_progress_timeline_screen.dart';
import 'package:fliproadmin/ui/view/project_progress_timeline_screen/project_progress_timeline_screen.dart';
import 'package:fliproadmin/ui/widget/colored_label.dart';
import 'package:fliproadmin/ui/widget/custom_app_bar.dart';
import 'package:fliproadmin/ui/widget/getx_dialogs.dart';
import 'package:fliproadmin/ui/widget/helper_widget.dart';
import 'package:fliproadmin/ui/widget/labeledTextField.dart';
import 'package:fliproadmin/ui/widget/main_button.dart';
import 'package:fliproadmin/ui/widget/media_section.dart';
import 'package:fliproadmin/ui/widget/project_info.dart';
import 'package:fliproadmin/ui/widget/trademan_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'add_value_bottom_sheet.dart';

class ProjectOverviewScreen extends StatelessWidget {
   ProjectOverviewScreen({Key? key, this.parentRouteName})
      : super(key: key);
  static const routeName = '/ProjectOverviewScreen';
  final String? parentRouteName;
  final _formKey = GlobalKey<FormState>();
   TextEditingController reviewController = TextEditingController();

  bool clientSatisfied = true;
  bool clientNotSatisfied = false;

  @override
  Widget build(BuildContext context) {
    final showAppbar = ModalRoute.of(context)!.settings.arguments.toString();
    // final loadedProject = Provider.of<LoadedProjectProvider>(context);
    return Scaffold(
      appBar: showAppbar == 'true'
          ? PreferredSize(
              preferredSize: Size.fromHeight(LogicHelper.getCustomAppBarHeight),
              child: const CustomAppBar(
                automaticallyImplyLeading: true,
                bannerText: "Project Details",
                showBothIcon: true,
                showShareIcon: true,
                showNoteIcon: true,
              ),
            )
          : null,
      body: RefreshIndicator(
        onRefresh: () => Future.sync(() =>
            Provider.of<LoadedProjectProvider>(context, listen: false)
                .refresh()),
        child:
            Consumer<LoadedProjectProvider>(builder: (ctx, loadedProject, c) {
          if (loadedProject.getLoadingState == loadingState.loading) {
            return SizedBox(
                height: 70.h, child: HelperWidget.progressIndicator());
          }
          if (loadedProject.getLoadedProject == null &&
              loadedProject.getLoadingState == loadingState.loaded) {
            return SizedBox(
              height: 70.h,
              child: const Center(
                child: Text("Encounter an Error ,Please try again later"),
              ),
            );
          }
          return SizedBox(
            height: 100.h,
            child: ListView(
              children: [
                const ProjectInfoSection(
                  readOnly: true,
                ),
                MediaSection(
                  media: loadedProject.getLoadedProject!.projectMedia!,
                ),

                ///IF PROGRESS OBJECT IS NOT NULL
                if (showAppbar != 'true' &&
                    loadedProject.getLoadedProject!.latestProgress != null &&
                    loadedProject.getLoadedProject!.latestProgress!.user !=
                        null)
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                    child: MainButton(
                      startALignment: true,
                      buttonText: "Project Progress Timeline",
                      callback: () {
                        Navigator.pushNamed(
                            context, ProjectProgressTimeLineScreen.routeName);
                      },
                      radius: 15,
                      height: 7.h,
                    ),
                  ),
                ///PROJECT ACTIVITY TIMELINE
                Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.h),
                    child: MainButton(
                      startALignment: true,
                      buttonText: "Activity Timeline",
                      callback: () {
                        Navigator.pushNamed(
                            context, ProjectActivityTimeLineScreen.routeName);
                      },
                      radius: 15,
                      height: 7.h,
                    ),
                  ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 1.h),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Current Value"),
                      ),
                      MainButton(
                        userArrow: false,
                        buttonText:
                            "${loadedProject.getLoadedProject!.currentPropertyValue}\$",
                        callback: () {},
                        radius: 15,
                        width: 100.w,
                        height: 7.h,
                      ),
                    ],
                  ),
                ),

                ///VALUE THAT VALUER WILL MARK WHEN PROJECT GET VALUATED
                ///EDIT EXISTING VALUE
                if (loadedProject.getLoadedProject!.projectLatestMarkedValue !=
                    "0")
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 20.w, vertical: 1.h),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Spacer(),
                              const Text("Marked Value"),
                              const Spacer(),
                              loadedProject.getLoadedProject!.status == "closed"
                                  ? Container()
                                  : InkWell(
                                onTap: () {
                                  addValueBottomSheet();
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Icon(
                                    Icons.edit,
                                    color: AppColors.mainThemeBlue,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        MainButton(
                          userArrow: false,
                          buttonText:
                          "${loadedProject.getLoadedProject!.projectLatestMarkedValue}\$",
                          callback: () {},
                          radius: 15,
                          width: 100.w,
                          height: 7.h,
                        ),
                      ],
                    ),
                  ),

                ///ADD NEW VALUE
                ///IF FRANCHISEE HAVE PERMISSION THAN HE CAN ADD PROJECT VALUE
                if ((loadedProject.getLoadedProject!.projectLatestMarkedValue ==
                        "0"))
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 20.w, vertical: 1.h),
                    child: MainButton(
                      userArrow: false,
                      buttonText: "Add Value",
                      callback: () {
                        addValueBottomSheet();
                      },
                      radius: 15,
                      width: 100.w,
                      height: 7.h,
                    ),
                  ),


                if (loadedProject.getLoadedProject!.status == "complete" &&
                    loadedProject.getLoadedProject?.franchisee?.id == context.read<UserProvider>().getCurrentUser.id &&
                    loadedProject.getLoadedProject!.latestProgress != null &&
                    loadedProject
                        .getLoadedProject!.latestProgress!.finalProgress ==
                        1)
                  StatefulBuilder(
                      builder: (BuildContext context, StateSetter changeState) {
                        return Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Final progress satisfaction",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(color: AppColors.greyFontColor),
                                    ),
                                    if (loadedProject
                                        .getLoadedProject!.progressReviewed!)
                                      ColoredLabel(
                                        width: 90,
                                        text: loadedProject.getLoadedProject!
                                            .progressSatisfied!
                                            ? "Satisfied"
                                            : "Not Satisfied",
                                        color: loadedProject.getLoadedProject!
                                            .progressSatisfied!
                                            ? AppColors.green
                                            : AppColors.darkRed,
                                      ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                if ((loadedProject
                                    .getLoadedProject!.progressReviewed! ||
                                    !loadedProject.getLoadedProject!
                                        .progressReviewed!) &&
                                    !loadedProject
                                        .getLoadedProject!.progressSatisfied!)
                                  Container(
                                    height: 8.h,
                                    width: 100.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 8),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Are you satisfied",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                              color: AppColors.greyFontColor),
                                        ),
                                        Spacer(),
                                        Row(
                                          children: [
                                            Checkbox(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(60)),
                                                value: clientSatisfied,
                                                onChanged: (c) {
                                                  changeState(() {
                                                    clientNotSatisfied = !c!;
                                                    clientSatisfied = c;
                                                  });
                                                }),
                                            Text(
                                              "YES",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1!
                                                  .copyWith(
                                                  color:
                                                  AppColors.greyFontColor),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Checkbox(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(60)),
                                                value: clientNotSatisfied,
                                                onChanged: (c) {
                                                  changeState(() {
                                                    clientNotSatisfied = c!;
                                                    clientSatisfied = !c;
                                                  });
                                                }),
                                            Text(
                                              "NO",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1!
                                                  .copyWith(
                                                  color:
                                                  AppColors.greyFontColor),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),

                                SizedBox(
                                  height: 1.h,
                                ),

                                ///FOR COMPLETED PROJECT
                                LabeledTextField(
                                  label: "Your Remarks",
                                  maxlines: 4,
                                  textEditingController: reviewController,
                                  readonly: loadedProject
                                      .getLoadedProject!.progressReviewed! &&
                                      loadedProject
                                          .getLoadedProject!.progressSatisfied!,
                                  validation: (e) {
                                    if (e == null || e.trim().isEmpty) {
                                      return "Please add final review";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                if (!loadedProject
                                    .getLoadedProject!.progressSatisfied!)
                                  MainButton(
                                      buttonText: loadedProject
                                          .getLoadedProject!.progressReviewed!
                                          ? "Update review"
                                          : "Add Review",
                                      height: 7.h,
                                      width: 60.w,
                                      userArrow: false,
                                      callback: () {
                                        if (_formKey.currentState!.validate() &&
                                            loadedProject.getLoadedProject!
                                                .progressSatisfied! ==
                                                false) {
                                          loadedProject.addProjectReview(
                                              clientSatisfied,
                                              reviewController.text.trim(),
                                              progressSatisfaction: true);
                                        }
                                      },
                                      isloading: loadedProject.getLoadingState ==
                                          loadingState.loading),
                              ],
                            ),
                          ),
                        );
                      }),

                ///FOR COMPLETED PROJECT - final progress reviews
                if (loadedProject.getLoadedProject!.progressReviewed == true)
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                    child: LabeledTextField(
                      label: "Progress Review",
                      maxlines: 4,
                      readonly: true,
                      hintText: loadedProject
                          .getLoadedProject!.final_progress_reviews!,
                      labelWidget: ColoredLabel(
                        color:
                            loadedProject.getLoadedProject!.progressSatisfied!
                                ? AppColors.green
                                : AppColors.darkRed,
                        text: loadedProject.getLoadedProject!.progressSatisfied!
                            ? 'Satisfied'
                            : "Not-Satisfied",

                      ),
                    ),
                  ),


                ///REMOVING THE FUNCTINALITY OF SHOW REMARKS/REVIEW OF EVALUATION
                // if (loadedProject.getLoadedProject!.valuationReviewed!)
                //   Padding(
                //     padding:
                //         EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                //     child: LabeledTextField(
                //       label: "HomeOwner - Evaluation Review",
                //       maxlines: 4,
                //       readonly: true,
                //       hintText:
                //           loadedProject.getLoadedProject!.valuationReviews!,
                //       labelWidget: ColoredLabel(
                //         color:
                //             loadedProject.getLoadedProject!.valuationSatisfied!
                //                 ? AppColors.green
                //                 : AppColors.darkRed,
                //         text:
                //             loadedProject.getLoadedProject!.valuationSatisfied!
                //                 ? 'Satisfied'
                //                 : "Not-Satisfied",
                //         callback: () {
                //           Navigator.pushNamed(
                //             context,
                //             HomeOwnerAccessControlScreen.routeName,
                //           );
                //         },
                //       ),
                //     ),
                //   ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                  child: LabeledTextField(
                    label: "Franchisee",
                    maxlines: null,
                    readonly: true,
                    hintText: loadedProject.getLoadedProject!.franchisee!.name!,
                    labelWidget: ColoredLabel(
                      color: AppColors.lightRed,
                      text: 'Edit Access',
                      callback: () {
                        Navigator.pushNamed(
                            context, FranchiseeAccessControlScreen.routeName,
                            arguments: AccessControlObject(
                                userRoleModel:
                                    loadedProject.getLoadedProject!.franchisee!,
                                routeName: parentRouteName ??
                                    ProjectOverviewScreen.routeName));
                      },
                    ),
                  ),
                ),

                TradeManSection(
                    currentrouteName:
                        parentRouteName ?? ProjectOverviewScreen.routeName,
                    showBuilderRevokeAccess: true,
                    showValuerRevokeAccess: true,
                    showHomeOwnerRevokeAccess: true,
                    projectId: loadedProject.getLoadedProject!.id!,
                    homeOwner: loadedProject.getLoadedProject!.lead,
                    valuer: loadedProject.getLoadedProject!.valuers,
                    builder: loadedProject.getLoadedProject!.builder),
                if(loadedProject.getLoadedProject!.status == 'complete'&&loadedProject.getLoadedProject!.progressReviewed! && loadedProject.getLoadedProject!.projectLatestMarkedValue !=
                    "0")
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                    child: MainButton(
                      startALignment: true,
                      buttonColor: AppColors.darkRed,
                      buttonText: "Close Project",
                      callback: () {

                        loadedProject.closeProject(true, 'NA');
                      },
                      radius: 15,
                      height: 7.h,
                    ),
                  ),

                SizedBox(
                  height: 5.h,
                )
              ],
            ),
          );
        }),
      ),
      floatingActionButton:
          Consumer<LoadedProjectProvider>(builder: (ctx, loadedProject, c) {
        if (loadedProject.getLoadingState == loadingState.loading) {
          return Container();
        }
        if (loadedProject.getLoadedProject == null &&
            loadedProject.getLoadingState == loadingState.loaded) {
          return Container();
        }
        if (loadedProject.getLoadedProject!.status == "closed" ||
            loadedProject.getLoadedProject!.status == "completed" ||
            loadedProject.getLoadedProject!.status == "in-progress") {
          return Container();
        }
        if (loadedProject.getLoadedProject!.status == "new") {
          return FloatingActionButton(
              mini: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.edit),
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => AddProjectScreen(
                          project:
                              ProjectProvider(loadedProject.getLoadedProject),
                          isNewProject: false,
                        )));
              });
        }
        return Container();
      }),
    );
  }
}
