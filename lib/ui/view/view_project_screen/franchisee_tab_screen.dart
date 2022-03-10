import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/ui/view/single_progress_screen/single_progress_screen.dart';
import 'package:fliproadmin/ui/widget/colored_label.dart';
import 'package:fliproadmin/ui/widget/draw_down_payment_sction.dart';
import 'package:fliproadmin/ui/widget/labeledTextField.dart';
import 'package:fliproadmin/ui/widget/media_section.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class FranchiseeTabScreen extends StatelessWidget {
  const FranchiseeTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 100.w,
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: ListView(
          children:  [
            SizedBox(height: 2.h,),
            const DrawDownPaymentScetion(),
            SizedBox(height: 2.h,),
            SizedBox(
                height: 70.h,
                child: const SingleProgressScreen(showAppBar: false,)),
            const LabeledTextField(label: "Note", maxlines: 10, readonly: true),
            SizedBox(height: 5.h,)
          ],
        ),
      ),
    );
  }
}
