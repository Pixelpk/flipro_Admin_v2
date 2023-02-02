import 'package:cached_network_image/cached_network_image.dart';
import 'package:fliproadmin/core/model/media_compression_model/media_compression_model.dart';
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/core/view_model/loaded_project/loaded_project.dart';
import 'package:fliproadmin/core/view_model/share_provider/share_provider.dart';
import 'package:fliproadmin/ui/widget/custom_cache_network_image.dart';
import 'package:fliproadmin/ui/widget/helper_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'image_sharing.dart';

class VideoSharing extends StatefulWidget {
  const VideoSharing({Key? key}) : super(key: key);

  @override
  _VideoSharingState createState() => _VideoSharingState();
}

class _VideoSharingState extends State<VideoSharing> {

  @override
  Widget build(BuildContext context) {
    return Consumer<LoadedProjectProvider>(builder: (ctx, loadedProject, c) {
      if ((loadedProject.getLoadedProject == null ||
              loadedProject.getLoadedProject!.videos == null) &&
          loadedProject.getLoadingState == LoadingState.loaded) {
        return const Center(
          child: Text("No Video availble"),
        );
      }
      if (loadedProject.getLoadingState == LoadingState.loading) {
        return HelperWidget.progressIndicator();
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Text(
              "Select videos",
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
                itemCount: loadedProject.getLoadedProject!.videos!.length,
                itemBuilder: (BuildContext ctx, index) {
                  MediaCompressionModel video =
                      loadedProject.getLoadedProject!.videos![index];
                  return InkWell(
                    onTap: () {
                      setState(() {
                        if (video.isSelected! == false) {
                          ///IF NOT SELECTED ALREADY THEN SELECT IT AND ADD IT TO SELECTIONLIST
                          Provider.of<ShareProvider>(context, listen: false)
                              .addShareAbleMedia(video);
                        }
                        if (video.isSelected!) {
                          ///IF ALREADY SELECTED THEN REMOVE FROM THE LIST
                          Provider.of<ShareProvider>(context, listen: false)
                              .removeShareAbleMedia(video);
                        }
                        video.isSelected = !video.isSelected!;
                      });
                    },
                    child: Stack(
                      alignment: Alignment.topRight,
                      fit: StackFit.expand,
                      children: [
                        CustomCachedImage(imageUrl: video.thumbnailPath,width: 100.w,fit: BoxFit.cover,),

                        Positioned(
                          top: 0,
                          right: 0,
                          child: Icon(
                            video.isSelected!
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
    });
  }
}
