import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/ui/widget/approve_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'latest_project_body.dart';
import 'rejected_project_body.dart';

class ProjectApprovalTabScreen extends StatefulWidget {
  const ProjectApprovalTabScreen({Key? key}) : super(key: key);

  @override
  State<ProjectApprovalTabScreen> createState() =>
      _ProjectApprovalTabScreenState();
}

class _ProjectApprovalTabScreenState extends State<ProjectApprovalTabScreen> {
  int segmentedControlValue = 0;

  Widget segmentedControl() {
    return Container(
      width: 70.w,
      padding: const EdgeInsets.all(8.0),
      child: CupertinoSlidingSegmentedControl(
          groupValue: segmentedControlValue,
          padding: EdgeInsets.zero,
          backgroundColor: AppColors.blueUnselectedTabColor,
          children: const <int, Widget>{
            0: Text('Latest'),
            1: Text('Rejected'),
          },
          onValueChanged: (value) {
            setState(() {
              segmentedControlValue = value as int;
            });
          }),
    );
  }

  List<Widget> bodyWidgets = [
    const Expanded(child: LatestProjectBody()),
    const Expanded(child: RejectedProjectBody())
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              segmentedControl(),
            ],
          ),
          bodyWidgets.elementAt(segmentedControlValue)
        ],
      ),
    );
  }
}
