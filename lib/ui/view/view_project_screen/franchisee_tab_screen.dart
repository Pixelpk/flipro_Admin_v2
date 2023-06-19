import 'package:fliproadmin/core/model/access_control_object.dart';
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/core/view_model/loaded_project/loaded_project.dart';
import 'package:fliproadmin/ui/view/access_control_screen/franchisee_access_control_screen.dart';
import 'package:fliproadmin/ui/view/single_progress_screen/single_progress_screen.dart';
import 'package:fliproadmin/ui/view/view_project_screen/view_project_screen.dart';
import 'package:fliproadmin/ui/widget/colored_label.dart';
import 'package:fliproadmin/ui/widget/draw_down_payment_sction.dart';
import 'package:fliproadmin/ui/widget/labeledTextField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class FranchiseeTabScreen extends StatelessWidget {
  const FranchiseeTabScreen({Key? key}) : super(key: key);

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
              SizedBox(
                height: 2.h,
              ),
              Consumer<LoadedProjectProvider>(builder: (ctx, loadedProject, c) {
                if (loadedProject.getLoadingState == LoadingState.loading) {
                  return SizedBox(height: 1.h);
                }
                if (loadedProject.getLoadedProject != null && loadedProject.getLoadedProject!.franchisee != null) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                    child: LabeledTextField(
                      label: "Partners Info",
                      maxLines: null,
                      readonly: false,
                      hintText: loadedProject.getLoadedProject!.franchisee![0].name!,
                      labelWidget: ColoredLabel(
                        color: AppColors.lightRed,
                        text: 'Edit Access',
                        callback: () {
                          Navigator.pushNamed(context, FranchiseeAccessControlScreen.routeName,
                              arguments: AccessControlObject(
                                  userRoleModel: loadedProject.getLoadedProject!.franchisee![0],
                                  routeName: ViewProjectScreen.routeName));
                        },
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              }),
              const DrawDownPaymentScetion(),
              SizedBox(height: 2.h),
              SizedBox(
                  height: 55.h,
                  child: Consumer<LoadedProjectProvider>(builder: (ctx, loadedProject, c) {
                    if (loadedProject.getLoadingState == LoadingState.loading) {
                      return SizedBox(
                        height: 1.h,
                      );
                    }
                    if (loadedProject.getLoadedProject != null &&
                        loadedProject.getLoadedProject!.latestProgress != null &&
                        loadedProject.getLoadedProject!.latestProgress!.user!.userType == 'franchise') {
                      return SingleProgressScreen(
                        readOnly: true,
                        showAppBar: false,
                        progressModel: loadedProject.getLoadedProject!.latestProgress!,
                      );
                    } else {
                      return Container();
                    }
                  })),
              Consumer<LoadedProjectProvider>(builder: (ctx, loadedProject, c) {
                if (loadedProject.getLoadingState == LoadingState.loading) {
                  return SizedBox(
                    height: 1.h,
                  );
                }
                if (loadedProject.getLoadedProject != null &&
                    loadedProject.getLoadedProject!.latestNote != null &&
                    loadedProject.getLoadedProject!.latestNote!.user!.userType == 'franchise') {
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
