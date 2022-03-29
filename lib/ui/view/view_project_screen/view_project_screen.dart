import 'dart:io';

import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/core/view_model/home_provider/home_provider.dart';
import 'package:fliproadmin/core/view_model/loaded_project/loaded_project.dart';
import 'package:fliproadmin/ui/view/closed_project_screen/closed_project_screen.dart';
import 'package:fliproadmin/ui/view/completed_project_screen/completed_project_screen.dart';
import 'package:fliproadmin/ui/view/in_progress_project_screen/in_progress_project_screen.dart';
import 'package:fliproadmin/ui/view/new_project_screen/new_project_screen.dart';
import 'package:fliproadmin/ui/view/project_overview_screen/project_overview_Screen.dart';
import 'package:fliproadmin/ui/view/share_screen/share_screen.dart';
import 'package:fliproadmin/ui/view/view_project_screen/project_tab_bar.dart';
import 'package:fliproadmin/ui/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'builder_tab_screen.dart';
import 'franchisee_tab_screen.dart';
import 'package:share_plus/share_plus.dart';
class ViewProjectScreen extends StatefulWidget {
  const ViewProjectScreen({Key? key}) : super(key: key);
  static const routeName = '/viewProjectScreen';

  @override
  State<ViewProjectScreen> createState() => _ViewProjectScreenState();
}

class _ViewProjectScreenState extends State<ViewProjectScreen> {
  late PageController pageController;
  @override
  void initState() {
    pageController = PageController(
        initialPage: Provider.of<HomeProvider>(context, listen: false)
            .getProjectViewCurrentPage);
    super.initState();
  }

  @override
  void dispose() {
    print("DISPOSING");
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(LogicHelper.getCustomAppBarHeight),
        child: CustomAppBar(
          automaticallyImplyLeading: true,
          shareCallback: () async {

            // Provider.of<LoadedProjectProvider>(context,listen: false).getCachedImages().then((image){
            //   print(image.length);
            //   image as List<String?>;
            //   List<String> i = image.map((e) => "$e").toList();
            //   print(i.runtimeType);
            //   Share.shareFiles(i, text: 'Great picture',);
           // });
Navigator.push(context, MaterialPageRoute(builder: (_)=>ShareScreen()));
          },
          bannerText: homeProvider.getActivityPageViewCurrentPage == 3
              ? "Project Closed"
              : "Project Details",
          bannerColor: homeProvider.getActivityPageViewCurrentPage == 3
              ? AppColors.lightRed
              : AppColors.mainThemeBlue,
          showBothIcon: true,
          showNoteIcon: true,
          showShareIcon: true,
        ),
      ),
      body: Column(
        children: [
          Column(
            children: [
              ProjectTabBar(pageController: pageController),
            ],
          ),
          Expanded(
            child: PageView(
              onPageChanged: homeProvider.onProjectViewPageChange,
              physics: const BouncingScrollPhysics(),
              controller: pageController,
              children: const <Widget>[
                ProjectOverviewScreen(
                  parentRouteName: ViewProjectScreen.routeName,
                ),
                FranchiseeTabScreen(),
                BuilderTabScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
