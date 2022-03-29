import 'package:fliproadmin/core/model/access_control_object.dart';
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/core/view_model/loaded_project/loaded_project.dart';
import 'package:fliproadmin/core/view_model/project_provider/project_provider.dart';
import 'package:fliproadmin/ui/view/access_control_screen/franchisee_access_control_screen.dart';
import 'package:fliproadmin/ui/view/access_control_screen/home_owner_access_control.dart';
import 'package:fliproadmin/ui/view/add_project_screen/add_project_screen.dart';
import 'package:fliproadmin/ui/view/project_progress_timeline_screen/project_progress_timeline_screen.dart';
import 'package:fliproadmin/ui/widget/colored_label.dart';
import 'package:fliproadmin/ui/widget/custom_app_bar.dart';
import 'package:fliproadmin/ui/widget/helper_widget.dart';
import 'package:fliproadmin/ui/widget/labeledTextField.dart';
import 'package:fliproadmin/ui/widget/main_button.dart';
import 'package:fliproadmin/ui/widget/media_section.dart';
import 'package:fliproadmin/ui/widget/project_info.dart';
import 'package:fliproadmin/ui/widget/trademan_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProjectOverviewScreen extends StatelessWidget {
  const ProjectOverviewScreen({Key? key,this.parentRouteName}) : super(key: key);
  static const routeName = '/ProjectOverviewScreen';
  final String? parentRouteName ;
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
      body: Consumer<LoadedProjectProvider>(builder: (ctx, loadedProject, c) {
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
              const ProjectInfoSection(),
              MediaSection(
                media: loadedProject.getLoadedProject!.projectMedia!,
              ),

              ///IF PROGRESS OBJECT IS NOT NULL
              if (showAppbar != 'true' &&
                  loadedProject.getLoadedProject!.latestProgress != null &&
                  loadedProject.getLoadedProject!.latestProgress!.user != null)
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 1.h),
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

              ///FOR COMPLETED PROJECT
              if (loadedProject.getLoadedProject!.final_progress_reviews !=
                  null)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                  child: LabeledTextField(
                    label: "HomeOwner",
                    maxlines: 4,
                    readonly: false,
                    labelWidget: ColoredLabel(
                      color: loadedProject.getLoadedProject!.progressSatisfied!
                          ? AppColors.green
                          : AppColors.darkRed,
                      text: loadedProject.getLoadedProject!.progressSatisfied!
                          ? 'Satisfied'
                          : "Not-Satisfied",
                      callback: () {
                        Navigator.pushNamed(
                          context,
                          HomeOwnerAccessControlScreen.routeName,
                        );
                      },
                    ),
                  ),
                ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                child: LabeledTextField(
                  label: "Franchisee",
                  maxlines: null,
                  readonly: false,
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
                              routeName:parentRouteName ??ProjectOverviewScreen.routeName));
                    },
                  ),
                ),
              ),

              TradeManSection(
                  currentrouteName: parentRouteName?? ProjectOverviewScreen.routeName,
                  showBuilderRevokeAccess: true,
                  showValuerRevokeAccess: true,
                  showHomeOwnerRevokeAccess: true,
                  projectId: loadedProject.getLoadedProject!.id!,
                  homeOwner: loadedProject.getLoadedProject!.lead,
                  valuer: loadedProject.getLoadedProject!.valuers,
                  builder: loadedProject.getLoadedProject!.builder),
              SizedBox(
                height: 5.h,
              )
            ],
          ),
        );
      }),
      floatingActionButton: Consumer<LoadedProjectProvider>(builder: (ctx, loadedProject, c) {
        if (loadedProject.getLoadingState == loadingState.loading) {
         return Container();
        }
        if (loadedProject.getLoadedProject == null &&
            loadedProject.getLoadingState == loadingState.loaded) {
         return Container();
        }
        if(loadedProject.getLoadedProject!.status == "closed"||loadedProject.getLoadedProject!.status == "completed") {
          return Container();
        }
        return FloatingActionButton(
            mini: true,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.edit),
            onPressed: () async {
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>AddProjectScreen(project: ProjectProvider(loadedProject.getLoadedProject),isNewProject: false,)));

            });
      }),
    );
  }
}
