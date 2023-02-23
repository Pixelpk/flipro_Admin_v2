import 'package:fliproadmin/core/model/access_control_object.dart';
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/core/view_model/loaded_project/loaded_project.dart';
import 'package:fliproadmin/ui/view/access_control_screen/franchisee_access_control_screen.dart';
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

class ViewUnassignedProject extends StatelessWidget {
  const ViewUnassignedProject({Key? key}) : super(key: key);
  static const routeName = '/viewUnassignedProject';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(LogicHelper.getCustomAppBarHeight),
          child: const CustomAppBar(
            bannerText: "Project Details",
            showBothIcon: false,
            automaticallyImplyLeading: true,
          ),
        ),
        body: SizedBox(
            height: 100.h,
            child: Consumer<LoadedProjectProvider>(builder: (ctx, projectProvider, c) {
              if (projectProvider.getLoadingState == LoadingState.loading) {
                return HelperWidget.progressIndicator();
              }
              if (projectProvider.getLoadedProject == null && projectProvider.getLoadingState == LoadingState.loaded) {
                return const Center(
                  child: Text("Please try again later"),
                );
              }

              return ListView(children: [
                ProjectInfoSection(
                  readOnly: true,
                  // projectTitle: projectProvider.getLoadedProject!.title!,
                  // area: projectProvider.getLoadedProject!.area,
                  // description: projectProvider.getLoadedProject!.description
                ),
                MediaSection(
                  media: projectProvider.getLoadedProject!.projectMedia!,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                  child: LabeledTextField(
                    label: "Partners",
                    maxLines: null,
                    readonly: true,
                    hintText: projectProvider.getLoadedProject!.franchisee != null
                        ? projectProvider.getLoadedProject!.franchisee!.name
                        : "Partners Name",
                    labelWidget: ColoredLabel(
                      color: AppColors.lightRed,
                      text: 'Edit Access',
                      callback: () {
                        Navigator.pushNamed(context, FranchiseeAccessControlScreen.routeName,
                            arguments: AccessControlObject(
                                userRoleModel: projectProvider.getLoadedProject!.franchisee!,
                                routeName: ViewUnassignedProject.routeName));
                      },
                    ),
                  ),
                ),
                projectProvider.getLoadedProject!.assigned!
                    ? Container()
                    : Container(
                        width: 100.w,
                        height: 45,
                        margin: EdgeInsets.symmetric(vertical: 2.h),
                        color: AppColors.mainThemeBlue,
                        child: Center(child: Text("Assign Project", style: Theme.of(context).textTheme.headline5))),
                Column(children: [
                  TradeManSection(
                      showBuilderRevokeAccess: true,
                      showValuerRevokeAccess: true,
                      showHomeOwnerRevokeAccess: true,
                      builder: projectProvider.getLoadedProject!.builder!,
                      homeOwner: projectProvider.getLoadedProject!.lead,
                      projectId: projectProvider.getLoadedProject!.id,
                      valuer: projectProvider.getLoadedProject!.valuers,
                      currentrouteName: ViewUnassignedProject.routeName),
                  MainButton(
                      buttonText: "Save",
                      height: 7.h,
                      width: 80.w,
                      callback: () {
                        Navigator.pop(context);
                      },
                      userArrow: false)
                ]),
                SizedBox(height: 5.h)
              ]);
            })));
  }
}
