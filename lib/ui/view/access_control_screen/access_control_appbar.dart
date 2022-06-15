import 'package:cached_network_image/cached_network_image.dart';
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/ui/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AccessControlAppBar extends StatelessWidget {
  const AccessControlAppBar(
      {Key? key, required this.title, required this.imageUrl})
      : super(key: key);
  final String title;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: AppColors.mainThemeBlue,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25))),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              CustomAppBar(
                automaticallyImplyLeading: true,
                bannerText: "$title Access Control",
                showBothIcon: false,
              ),
              Container(
                height: 10.h,
                decoration: const BoxDecoration(
                    color: AppColors.mainThemeBlue,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25))),
              )
            ],
          ),
          Positioned(
            top: 18.h,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 55,
              child: CircleAvatar(
                radius: 53,
                backgroundImage: CachedNetworkImageProvider(imageUrl),
                // AssetImage(AppConstant.defaultProjectImage),
              ),
            ),
          )
        ],
      ),
    );
  }
}
