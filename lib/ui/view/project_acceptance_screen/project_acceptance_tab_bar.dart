import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProjectAcceptanceTabBar extends StatelessWidget {
  const ProjectAcceptanceTabBar({Key? key, required this.pageController,required this.index})
      : super(key: key);
  final PageController pageController;
final int index ;
  @override
  Widget build(BuildContext context) {
    print("HOME TAB BAR REBUILT");
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.only(top: 2.w, right: 2.w, left: 2.w, bottom: 3),
      child: Row(
        children: [
          tabBar(
            context: context,
            title: "New Project",
            localindex: 0, index: index,
          ),
          tabBar(
            context: context,
            title: "Payment Request",
            localindex: 1,
             index: index,
          ),
        ],
      ),
    );
  }

  Expanded tabBar(
      {required BuildContext context,
        required String title,
        required int localindex , required index}) {
    return Expanded(
        child: InkWell(
          onTap: () {
           pageController.animateToPage(localindex,
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
                color: index == localindex
                    ? AppColors.mainThemeBlue
                    : AppColors.blueUnselectedTabColor,
                borderRadius: BorderRadius.circular(13)),
          ),
        ));
  }
}