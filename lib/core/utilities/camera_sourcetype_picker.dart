import 'package:fliproadmin/core/services/assets_provider/assets_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import 'app_colors.dart';

class AssetsSourceTypeSheet {
  static Future<void> profileImagePicker(
    BuildContext context,
  ) {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text(
          'Pick Image Source',
          style: TextStyle(
              color: AppColors.mainThemeBlue,
              fontFamily: "OpenSans-SemiBold",
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: const [
                  Icon(
                    Icons.videocam_outlined,
                    color: AppColors.mainThemeBlue,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text('Camera'),
                ],
              ),
            ),
            onPressed: () async {
              Provider.of<AssetProvider>(context, listen: false).singleImageCameraPicker(context, ImageSource.camera);
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: const [
                  Icon(
                    Icons.add_photo_alternate_outlined,
                    color: AppColors.mainThemeBlue,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text('Gallery'),
                ],
              ),
            ),
            onPressed: () async {
              Provider.of<AssetProvider>(context, listen: false).singleImageCameraPicker(context, ImageSource.gallery);
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  static Future<void> imagePickerSheet(BuildContext context,
      {bool allowMultiplePicks = true, required ImageSource imageSource, bool showcamera = false}) {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text(
          'Pick Media Type',
          style: TextStyle(
              color: AppColors.mainThemeBlue,
              fontFamily: "OpenSans-SemiBold",
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: const [
                  Icon(
                    Icons.videocam_outlined,
                    color: AppColors.mainThemeBlue,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text('Video'),
                ],
              ),
            ),
            onPressed: () async {
              Provider.of<AssetProvider>(context, listen: false)
                  .videoCameraPicker(context, imageSource: imageSource, multiplePick: allowMultiplePicks);
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: const [
                  Icon(
                    Icons.add_photo_alternate_outlined,
                    color: AppColors.mainThemeBlue,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text('Image'),
                ],
              ),
            ),
            onPressed: () async {
              bool alowMultiImage = ImageSource.camera == imageSource;
              Provider.of<AssetProvider>(context, listen: false)
                  .imageCameraPicker(context, imageSource: imageSource, multiplePick: !alowMultiImage);

              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  static Future<void> singleImagePicker(BuildContext context,
      {bool allowMultiplePicks = true, required ImageSource imageSource, bool showcamera = false}) {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text(
          'Pick Media Type',
          style: TextStyle(
              color: AppColors.mainThemeBlue,
              fontFamily: "OpenSans-SemiBold",
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: const [
                  Icon(
                    Icons.videocam_outlined,
                    color: AppColors.mainThemeBlue,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text('Video'),
                ],
              ),
            ),
            onPressed: () async {
              Provider.of<AssetProvider>(context, listen: false)
                  .videoCameraPicker(context, imageSource: imageSource, multiplePick: allowMultiplePicks);
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: const [
                  Icon(
                    Icons.add_photo_alternate_outlined,
                    color: AppColors.mainThemeBlue,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text('Image'),
                ],
              ),
            ),
            onPressed: () async {
              bool alowMultiImage = ImageSource.camera == imageSource;
              Provider.of<AssetProvider>(context, listen: false)
                  .imageCameraPicker(context, imageSource: imageSource, multiplePick: !alowMultiImage);

              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
