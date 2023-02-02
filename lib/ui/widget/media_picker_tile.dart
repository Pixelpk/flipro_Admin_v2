import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/core/utilities/camera_sourcetype_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class MediaPickedTile extends StatelessWidget {
  const MediaPickedTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          Text("Add Media", style: Theme.of(context).textTheme.headline5),
          const Spacer(),
          mediaIcon(
              userPhoto: false,
              callback: () {
                AssetsSourceTypeSheet.singleImagePicker(context,
                    imageSource: ImageSource.camera, allowMultiplePicks: true);
              }),
          mediaIcon(
              userPhoto: true,
              callback: () {
                AssetsSourceTypeSheet.singleImagePicker(context,
                    imageSource: ImageSource.gallery, allowMultiplePicks: true);
              }),
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      height: 9.h,
      decoration: BoxDecoration(color: AppColors.mainThemeBlue, borderRadius: BorderRadius.circular(8)),
    );
  }

  InkWell mediaIcon({required bool userPhoto, required VoidCallback callback}) {
    return InkWell(
      onTap: callback,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        margin: EdgeInsets.only(right: userPhoto ? 3.w : 2.5.w),
        height: 6.5.h,
        width: 6.5.h,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: userPhoto
            ? Image.asset(AppConstant.photo)
            : const Icon(
                Icons.photo_camera_outlined,
                color: AppColors.mainThemeBlue,
              ),
      ),
    );
  }
}
