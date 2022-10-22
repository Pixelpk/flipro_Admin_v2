import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/core/view_model/home_provider/home_provider.dart';
import 'package:fliproadmin/ui/view/closed_project_screen/closed_project_screen.dart';
import 'package:fliproadmin/ui/view/completed_project_screen/completed_project_screen.dart';
import 'package:fliproadmin/ui/view/in_progress_project_screen/in_progress_project_screen.dart';
import 'package:fliproadmin/ui/view/new_project_screen/new_project_screen.dart';
import 'package:fliproadmin/ui/widget/colored_label.dart';
import 'package:fliproadmin/ui/widget/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../search_projects/search_projects.dart';
import 'activity_list_item.dart';
import 'activity_tabbar.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  late PageController pageController;
  @override
  void initState() {
    pageController = PageController(initialPage: 0);
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
    print("REBUILT");

    final homeProvider = Provider.of<HomeProvider>(context);
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned(
          top: 65,
          left: 0,
          right: 0,
          child: SizedBox(
            height: 100.h - 80,
            child: Column(
              children: [
                ActivityTabBar(pageController: pageController),
                Expanded(
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: homeProvider.onActivityProjectsPageChange,
                    controller: pageController,
                    children: const <Widget>[
                      NewProjectScreen(),
                      InProgressProjectScreen(),
                      CompletedProjectScreen(),
                      ClosedProjectScreen()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
         const Positioned(
          right: 0,
          left: 0,
          top: 5,
          child: SearchProjectsScreen(
            // topMargin: 1.h,
            // width: 85.w,
            // height: 7.5.h,
            // elevation: 0,
            // border: true,
            // key: _searchFieldKey,
          ),
        ),

      ],
    );
  }
}
