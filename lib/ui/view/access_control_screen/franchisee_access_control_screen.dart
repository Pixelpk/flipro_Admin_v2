import 'package:fliproadmin/core/model/access_control_object.dart';
import 'package:fliproadmin/core/model/project_response/project_response.dart';
import 'package:fliproadmin/core/model/project_roles/project_roles.dart';
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/view_model/access_control_provider/access_control_provider.dart';
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/core/view_model/loaded_project/loaded_project.dart';
import 'package:fliproadmin/core/view_model/projects_provider/projects_provider.dart';
import 'package:fliproadmin/ui/widget/SwitchTile.dart';
import 'package:fliproadmin/ui/widget/main_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'access_control_appbar.dart';

class FranchiseeAccessControlScreen extends StatelessWidget {
  const FranchiseeAccessControlScreen({Key? key}) : super(key: key);
  static const routeName = '/FranchiseeAccessControlScreen';

  @override
  Widget build(BuildContext context) {
    ///WE NEED TWO THING ON THIS SCREEN
    ///one is userObject,
    ///other is routeName to which the user will navigate to then he save the access controll
    ///basically there are two routes where user will be naviagte to, viewUnassigned project & projectOverviewScreen
    final receivedObject = ModalRoute.of(context)!.settings.arguments as AccessControlObject;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(25.h),
        child: AccessControlAppBar(
          title: "Partners",
          imageUrl: receivedObject.userRoleModel.avatar ?? '',
        ),
      ),
      body: ChangeNotifierProxyProvider<LoadedProjectProvider, AccessControlProvider>(
        create: (context) => AccessControlProvider(projectRoles: ProjectRoles()),
        update: (context, loadedProvider, projectsProvider) =>
            AccessControlProvider(projectRoles: loadedProvider.getFrancshiseebyId(receivedObject.userRoleModel.id)),
        // AccessControlProvider(
        //     projectRoles: loadedProvider.getFrancshiseeProjectRoles()),
        child: Consumer2<LoadedProjectProvider, AccessControlProvider>(
            builder: (ctx, loadedProject, accessControlProvider, c) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            width: double.infinity,
            height: 75.h,
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  height: 8.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        child: Text(
                          "${receivedObject.userRoleModel.name}",
                          style: Theme.of(context).textTheme.headline5!.copyWith(
                                color: AppColors.mainThemeBlue,
                              ),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Flexible(
                        child: Text("${receivedObject.userRoleModel.address}",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  color: AppColors.greyDark,
                                ),
                            maxLines: 2,
                            textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                SwitchTile(
                  width: 90.w,
                  heigth: 7.5.h,
                  callback: accessControlProvider.setviewAccess,
                  private: accessControlProvider.getSelectedRoles.view,
                  tileTitle: "View",
                ),
                SizedBox(
                  height: 3.h,
                ),
                SwitchTile(
                  width: 90.w,
                  heigth: 7.5.h,
                  callback: accessControlProvider.setUploadProgressAccess,
                  private: accessControlProvider.getSelectedRoles.uploadProgress,
                  tileTitle: "Update Progress",
                ),
                SizedBox(
                  height: 3.h,
                ),
                SwitchTile(
                    private: accessControlProvider.getSelectedRoles.addValue ?? true,
                    width: 90.w,
                    heigth: 7.5.h,
                    callback: accessControlProvider.setAddValueAccess,
                    tileTitle: "Can Add value"),
                SizedBox(height: 4.h),
                SwitchTile(
                  width: 90.w,
                  heigth: 7.5.h,
                  tileTitle: "Payment Request",
                  callback: accessControlProvider.setRequestPaymentAccess,
                  private: accessControlProvider.getSelectedRoles.requestPayment,
                ),
                SizedBox(
                  height: 3.h,
                ),
                SwitchTile(
                  callback: accessControlProvider.setAddNotesAccess,
                  private: accessControlProvider.getSelectedRoles.addNotes,
                  tileTitle: "Add Notes/Review",
                ),
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MainButton(
                      height: 7.h,
                      buttonText: "Confirm",
                      width: 60.w,
                      radius: 15,
                      isloading: loadedProject.getLoadingState == LoadingState.loading,
                      userArrow: false,
                      callback: () async {
                        // print(accessControlProvider.getSelectedRoles.toJson());
                        // bool projectAssigned = await loadedProject.updateAccess(
                        //     receivedObject.userRoleModel.id!,
                        //     loadedProject.getLoadedProject!.id!,
                        //     accessControlProvider.getSelectedRoles,
                        //     receivedObject.routeName);

                        print(accessControlProvider.getSelectedRoles.toJson());
                        bool projectAssigned = await loadedProject.updateAccess(
                            receivedObject.userRoleModel.id!,
                            loadedProject.getLoadedProject!.id!,
                            accessControlProvider.getSelectedRoles,
                            receivedObject.routeName);

                        if (projectAssigned) {
                          Provider.of<ProjectsProvider>(context, listen: false)
                              .removeProject(projectId: loadedProject.getLoadedProject!.id);
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
