import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/view_model/home_provider/home_provider.dart';
import 'package:fliproadmin/ui/widget/colored_label.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ActivityTabBar extends StatefulWidget {
  const ActivityTabBar({Key? key, required this.pageController})
      : super(key: key);
  final PageController pageController;

  @override
  State<ActivityTabBar> createState() => _ActivityTabBarState();
}

class _ActivityTabBarState extends State<ActivityTabBar> {
  late HomeProvider homeProvider;
  @override
  Widget build(BuildContext context) {
    homeProvider = Provider.of<HomeProvider>(context);
    print("HOME TAB BAR REBUILT");
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.only(top: 2.w, right: 2.w, left: 2.w, bottom: 3),
      child: Row(
        children: [
          tabBar(
            context: context,
            title: "New",
            index: 0,
          ),
          tabBar(
            context: context,
            title: "In Progress",
            index: 1,
          ),
          tabBar(
            context: context,
            title: "Completed",
            index: 2,
          ),
          tabBar(
            context: context,
            title: "Closed",
            index: 3,
          ),
        ],
      ),
    );
  }

  Expanded tabBar(
      {required BuildContext context,
      required String title,
      required int index}) {
    return Expanded(
        child: InkWell(
      onTap: () {
        widget.pageController.animateToPage(index,
            duration: const Duration(milliseconds: 20),
            curve: Curves.bounceInOut);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 0.5.w),
        padding: const EdgeInsets.all(8),
        child: Center(
            child: Text(title, style: Theme.of(context).textTheme.caption)),
        height: 5.5.h,
        decoration: BoxDecoration(
            color: homeProvider.getActivityPageViewCurrentPage == index
                ? AppColors.mainThemeBlue
                : AppColors.blueUnselectedTabColor,
            borderRadius: BorderRadius.circular(13)),
      ),
    ));
  }
}
