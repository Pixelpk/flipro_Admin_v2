import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/ui/view/access_control_screen/franchisee_access_control_screen.dart';
import 'package:fliproadmin/ui/view/project_progress_timeline_screen/project_progress_timeline_screen.dart';
import 'package:fliproadmin/ui/widget/colored_label.dart';
import 'package:fliproadmin/ui/widget/custom_app_bar.dart';
import 'package:fliproadmin/ui/widget/labeledTextField.dart';
import 'package:fliproadmin/ui/widget/main_button.dart';
import 'package:fliproadmin/ui/widget/media_section.dart';
import 'package:fliproadmin/ui/widget/project_info.dart';
import 'package:fliproadmin/ui/widget/trademan_section.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProjectOverviewScreen extends StatelessWidget {
  const ProjectOverviewScreen({Key? key}) : super(key: key);
  static const routeName = '/ProjectOverviewScreen';

  @override
  Widget build(BuildContext context) {
    final  showAppbar =
        ModalRoute.of(context)!.settings.arguments.toString();
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
      body: SizedBox(
        height: 100.h,
        child: ListView(
          children: [
            const ProjectInfoSection(),
            const MediaSection(),
            showAppbar != 'true'   ? Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 3.h),
              child: MainButton(
                startALignment: true,
                buttonText: "Project Progress Timeline",
                callback: () {
                  Navigator.pushNamed(context, ProjectProgressTimeLineScreen.routeName);
                },
                radius: 15,
                height: 8.h,
              ),
            ):Container(),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 1.h),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Current Value"),
                  ),
                  MainButton(
                    userArrow: false,
                    buttonText: "100,000\$",
                    callback: () {},
                    radius: 15,
                    width: 100.w,
                    height: 8.h,
                  ),
                ],
              ),
            ),
            ///FOR COMPLETED PROJECT
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
              child:  LabeledTextField(
                label: "HomeOwner",
                maxlines: 4,
                readonly: false,
                labelWidget: ColoredLabel(
                  color: AppColors.green, text: 'Satisfied',callback: (){
                  Navigator.pushNamed(context, FranchiseeAccessControlScreen.routeName);
                },),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
              child:  LabeledTextField(
                label: "Franchisee",
                maxlines: null,
                readonly: false,
                labelWidget: ColoredLabel(
                    color: AppColors.lightRed, text: 'Edit Access',callback: (){
                  Navigator.pushNamed(context, FranchiseeAccessControlScreen.routeName);
                },),
              ),
            ),


            const TradeManSection(
              showBuilderRevokeAccess: true,
              showValuerRevokeAccess: true,

            ),
            SizedBox(
              height: 5.h,
            )
          ],
        ),
      ),
    );
  }
}
