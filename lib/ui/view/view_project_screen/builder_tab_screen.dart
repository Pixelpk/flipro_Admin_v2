import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/core/view_model/loaded_project/loaded_project.dart';
import 'package:fliproadmin/ui/view/single_progress_screen/single_progress_screen.dart';
import 'package:fliproadmin/ui/widget/colored_label.dart';
import 'package:fliproadmin/ui/widget/draw_down_payment_sction.dart';
import 'package:fliproadmin/ui/widget/labeledTextField.dart';
import 'package:fliproadmin/ui/widget/media_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class BuilderTabScreen extends StatelessWidget {
  const BuilderTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 100.w,
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: ListView(
          children:  [
            SizedBox(
                height: 55.h,
                child: Consumer<LoadedProjectProvider>(
                    builder: (ctx, loadedProject, c) {
                      if (loadedProject.getLoadingState == loadingState.loading) {
                        return SizedBox(
                          height: 1.h,
                        );
                      }
                      if (loadedProject.getLoadedProject != null &&
                          loadedProject.getLoadedProject!.latestProgress != null &&
                          loadedProject.getLoadedProject!.latestProgress!.user!
                              .userType ==
                              'builder') {
                        return SingleProgressScreen(
                          showAppBar: false,
                          progressModel:
                          loadedProject.getLoadedProject!.latestProgress!,
                        );
                      } else {
                        return Container();
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
                  loadedProject.getLoadedProject!.latestNote!.user!.userType ==
                      'builder') {
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
            SizedBox(height: 5.h,)
          ],
        ),
      ),
    );
  }
}
