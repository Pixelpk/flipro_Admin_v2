import 'package:cached_network_image/cached_network_image.dart';
import 'package:fliproadmin/core/model/media_compression_model/media_compression_model.dart';
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/view_model/loaded_project/loaded_project.dart';
import 'package:fliproadmin/core/view_model/share_provider/share_provider.dart';
import 'package:fliproadmin/ui/widget/custom_cache_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ImageSharing extends StatefulWidget {
  const ImageSharing({Key? key}) : super(key: key);

  @override
  State<ImageSharing> createState() => _ImageSharingState();
}

class _ImageSharingState extends State<ImageSharing> {
  @override
  void initState() {
    if (Provider.of<LoadedProjectProvider>(context, listen: false)
                .getLoadedProject !=
            null &&
        Provider.of<LoadedProjectProvider>(context, listen: false)
                .getLoadedProject!
                .photoGallery !=
            null) {
      images.addAll(Provider.of<LoadedProjectProvider>(context, listen: false)
          .getLoadedProject!
          .photoGallery!
          .map((e) {
        return MediaCompressionModel(compressedVideoPath: e, thumbnailPath: e);
      }).toList());
      setState(() {});
    }
    super.initState();
  }

  List<MediaCompressionModel> images = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: Text(
            "Select Images",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        Expanded(
          child: GridView.builder(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4),
              itemCount: images.length,
              itemBuilder: (BuildContext ctx, index) {
                MediaCompressionModel image = images[index];
                return InkWell(
                  onTap: () {
                    if (image.isSelected! == false) {
                      ///IF NOT SELECTED ALREADY THEN SELECT IT AND ADD IT TO SELECTIONLIST
                      Provider.of<ShareProvider>(context, listen: false)
                          .addShareAbleMedia(image);
                    }
                    if (image.isSelected!) {
                      ///IF ALREADY SELECTED THEN REMOVE FROM THE LIST
                      Provider.of<ShareProvider>(context, listen: false)
                          .removeShareAbleMedia(image);
                    }
                    setState(() {
                      image.isSelected = !image.isSelected!;
                    });
                  },
                  child: Stack(
                    alignment: Alignment.topRight,
                    fit: StackFit.expand,
                    children: [
                      CustomCachedImage(imageUrl: image.thumbnailPath,width: 100.w,fit: BoxFit.cover,),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Icon(
                          image.isSelected!
                              ? Icons.check_box
                              : Icons.check_box_outline_blank_outlined,
                          color: AppColors.mainThemeBlue,
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}
