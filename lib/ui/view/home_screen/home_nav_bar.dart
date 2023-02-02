import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/core/view_model/home_provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class HomeNavBar extends StatelessWidget {
  const HomeNavBar({
    Key? key,
    required this.homeProvider,
  }) : super(key: key);

  final HomeProvider homeProvider;

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    return BottomNavigationBar(
        backgroundColor: AppColors.lightGrey,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: AppColors.lightGrey,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppConstant.projectIcon,
              color:
                  homeProvider.getSelectedHomeIndex == 1 ? AppColors.mainThemeBlue : AppColors.blueUnselectedTabColor,
            ),
            label: 'Activity',
            backgroundColor: AppColors.lightGrey,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppConstant.activityIcon,
              color:
                  homeProvider.getSelectedHomeIndex == 2 ? AppColors.mainThemeBlue : AppColors.blueUnselectedTabColor,
            ),
            label: 'Project',
            backgroundColor: AppColors.lightGrey,
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Members',
            backgroundColor: AppColors.lightGrey,
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_sharp),
            label: 'Profile',
            backgroundColor: AppColors.lightGrey,
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppConstant.logoutIcon,
                color:
                    homeProvider.getSelectedHomeIndex == 5 ? AppColors.mainThemeBlue : AppColors.blueUnselectedTabColor,
              ),
              label: 'Logout',
              backgroundColor: AppColors.lightGrey),
        ],
        currentIndex: homeProvider.getSelectedHomeIndex,
        selectedItemColor: AppColors.mainThemeBlue,
        unselectedItemColor: AppColors.blueUnselectedTabColor,
        showUnselectedLabels: true,
        onTap: homeProvider.onItemTapped);
  }
}
