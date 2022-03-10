import 'package:fliproadmin/ui/view/project_acceptance_screen/payments/latest_payment_body.dart';
import 'package:fliproadmin/ui/view/project_acceptance_screen/payments/rejected_payment_body.dart';
import 'package:flutter/material.dart';

import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

class ProjectPaymentTabScreen extends StatefulWidget {
  const ProjectPaymentTabScreen({Key? key}) : super(key: key);

  @override
  State<ProjectPaymentTabScreen> createState() =>
      _ProjectPaymentTabScreenState();
}

class _ProjectPaymentTabScreenState extends State<ProjectPaymentTabScreen> {
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
     const Expanded(child: LatestPaymentBody()),
     const Expanded(child: RejectedPaymentBody())
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
