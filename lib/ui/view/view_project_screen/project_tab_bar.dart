import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/view_model/home_provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProjectTabBar extends StatefulWidget {
  const ProjectTabBar({Key? key, required this.pageController}) : super(key: key);
  final PageController pageController;

  @override
  State<ProjectTabBar> createState() => _ActivityTabBarState();
}

class _ActivityTabBarState extends State<ProjectTabBar> {
  late HomeProvider homeProvider;

  @override
  Widget build(BuildContext context) {
    homeProvider = Provider.of<HomeProvider>(context);
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.only(top: 2.w, right: 2.w, left: 2.w, bottom: 3),
      child: Column(
        children: [
          Row(
            children: [
              tabBar(context: context, title: "Overview", index: 0),
              tabBar(context: context, title: "Partners", index: 1),
              tabBar(context: context, title: "Agents/Trades", index: 2),
            ],
          ),
        ],
      ),
    );
  }

  Expanded tabBar({required BuildContext context, required String title, required int index}) {
    return Expanded(
        child: InkWell(
      onTap: () {
        widget.pageController
            .animateToPage(index, duration: const Duration(milliseconds: 20), curve: Curves.bounceInOut);
      },
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 0.5.w),
          padding: const EdgeInsets.all(8),
          child: Center(child: Text(title, style: Theme.of(context).textTheme.caption)),
          height: 5.5.h,
          decoration: BoxDecoration(
              color: homeProvider.getProjectViewCurrentPage == index
                  ? AppColors.mainThemeBlue
                  : AppColors.blueUnselectedTabColor,
              borderRadius: BorderRadius.circular(13))),
    ));
  }
}
