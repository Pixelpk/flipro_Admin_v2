import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/view_model/home_provider/home_provider.dart';
import 'package:fliproadmin/ui/widget/colored_label.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MemberTabBar extends StatefulWidget {
  const MemberTabBar({Key? key, required this.pageController, required this.pageControllerIndex}) : super(key: key);
  final int pageControllerIndex;
  final PageController pageController;

  @override
  State<MemberTabBar> createState() => _MemberTabBarState();
}

class _MemberTabBarState extends State<MemberTabBar> {
  late HomeProvider homeProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.only(top: 2.w, right: 2.w, left: 2.w, bottom: 3),
      child: Row(
        children: [
          tabBar(context: context, title: "Agents/Trades", localindex: 0),
          tabBar(context: context, title: "Valuer", localindex: 1),
          tabBar(context: context, title: "Partners", localindex: 2),
          tabBar(context: context, title: "Home Owner", localindex: 3),
        ],
      ),
    );
  }

  Expanded tabBar({required BuildContext context, required String title, required int localindex}) {
    return Expanded(
        child: InkWell(
      onTap: () {
        widget.pageController
            .animateToPage(localindex, duration: const Duration(milliseconds: 20), curve: Curves.bounceInOut);
      },
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 0.5.w),
          padding: const EdgeInsets.all(8),
          child: Center(child: Text(title, style: Theme.of(context).textTheme.caption)),
          height: 5.5.h,
          decoration: BoxDecoration(
              color:
                  widget.pageControllerIndex == localindex ? AppColors.mainThemeBlue : AppColors.blueUnselectedTabColor,
              borderRadius: BorderRadius.circular(13))),
    ));
  }
}
