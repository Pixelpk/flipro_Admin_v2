import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/ui/widget/media_section.dart';
import 'package:fliproadmin/ui/widget/project_info.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'custom_app_bar.dart';

class ViewProjectDetails extends StatelessWidget {
  const ViewProjectDetails({
    Key? key,
  }) : super(key: key);
  static const routeName = '/ViewProjectDetails';

  @override
  Widget build(BuildContext context) {
    final projectRejected =
        ModalRoute.of(context)!.settings.arguments as bool;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(LogicHelper.getCustomAppBarHeight),      child: CustomAppBar(
          bannerText: projectRejected ? "Project Rejected" : "Project Details",
          showBothIcon: true,
          showShareIcon: true,
          showNoteIcon: true,
        automaticallyImplyLeading: true,

        bannerColor: projectRejected ? AppColors.lightRed : null,
        ),
      ),
      body: SizedBox(
        height: 100.h,
        child: ListView(
          children: const [ProjectInfoSection(), MediaSection()],
        ),
      ),
    );
  }
}
