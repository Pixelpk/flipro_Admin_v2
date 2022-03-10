import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/ui/view/access_control_screen/franchisee_access_control_screen.dart';
import 'package:fliproadmin/ui/widget/colored_label.dart';
import 'package:fliproadmin/ui/widget/custom_app_bar.dart';
import 'package:fliproadmin/ui/widget/labeledTextField.dart';
import 'package:fliproadmin/ui/widget/main_button.dart';
import 'package:fliproadmin/ui/widget/media_section.dart';
import 'package:fliproadmin/ui/widget/project_info.dart';
import 'package:fliproadmin/ui/widget/trademan_section.dart';
import 'package:flutter/material.dart';
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
          showBothIcon: true,
          showShareIcon: true,
          showNoteIcon: true,
          automaticallyImplyLeading: true,

        ),
      ),
      body: SizedBox(
        height: 100.h,
        child: ListView(
          children: [
            const ProjectInfoSection(),
            const MediaSection(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
              child: LabeledTextField(
                label: "Franchisee",
                maxlines: null,
                readonly: false,
                labelWidget: ColoredLabel(
                  color: AppColors.lightRed,
                  text: 'Edit Access',
                  callback: () {
                    Navigator.pushNamed(
                        context, FranchiseeAccessControlScreen.routeName);
                  },
                ),
              ),
            ),
            Container(
              width: 100.w,
              height: 45,
              margin: EdgeInsets.symmetric(vertical: 2.h),
              color: AppColors.mainThemeBlue,
              child: Center(
                  child: Text(
                "Assign Project",
                style: Theme.of(context).textTheme.headline5,
              )),
            ),
            Column(
              children: [
                const TradeManSection(),
                MainButton(
                  buttonText: "Save",
                  height: 7.h,
                  width: 80.w,
                  callback: () {},
                  userArrow: false,
                ),
              ],
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
