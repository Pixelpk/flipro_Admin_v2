import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/ui/widget/custom_app_bar.dart';
import 'package:fliproadmin/ui/widget/labeledTextField.dart';
import 'package:fliproadmin/ui/widget/media_section.dart';
import 'package:fliproadmin/ui/widget/project_info.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SingleProgressScreen extends StatelessWidget {
  const SingleProgressScreen({Key? key,this.showAppBar = true}) : super(key: key);
  static const routeName = '/SingleProgressScreen';
  final bool showAppBar ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: showAppBar ? PreferredSize(
          preferredSize: Size.fromHeight(LogicHelper.getCustomAppBarHeight),
      child: const CustomAppBar(
        automaticallyImplyLeading: true,

        bannerText: "Progress",
        showBothIcon: true,
        showShareIcon: true,
        showNoteIcon: true,
      ),
    ):null,
    body: ListView(
      physics: !showAppBar? const NeverScrollableScrollPhysics():const BouncingScrollPhysics(),
      children: [     
      SizedBox(
      height: !showAppBar ? 35.h: 50.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          LabeledTextField(
            label: "Progress Title:",
            maxlines: null,
            readonly: false,
          ),
          LabeledTextField(
            label: "Description",
            maxlines: 6,
            readonly: false,
          ),
        ],
      ),
    ),
        const MediaSection(),
      ],
    ),

    );
  }
}
