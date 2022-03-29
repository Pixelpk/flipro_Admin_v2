import 'package:cached_network_image/cached_network_image.dart';
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProfileAppbar extends StatelessWidget {
  const ProfileAppbar({
    Key? key,
    this.pictureEditable = false,
   required this.imageUrl,
  }) : super(key: key);
  final bool pictureEditable;
  final String imageUrl ;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25.h,
      child: Stack(
        children: [
          Container(
            height: 15.h,
            width: 100.w,
            decoration: const BoxDecoration(
                color: AppColors.mainThemeBlue,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25))),
          ),
          SizedBox(
            width: 100.w,
            height: 25.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 7.h,
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 7.h,
                  child: CircleAvatar(
                    radius: 6.8.h,
                    backgroundImage:
                    CachedNetworkImageProvider(imageUrl),
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.bottomLeft,
                      children: [
                        pictureEditable
                            ? const Positioned(
                                bottom: 9,
                                right: -5,
                                child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor: AppColors.mainThemeBlue,
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      size: 20,
                                    )))
                            : Container()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
