import 'package:cached_network_image/cached_network_image.dart';
import 'package:fliproadmin/core/model/media_compression_model/media_compression_model.dart';
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/core/view_model/loaded_project/loaded_project.dart';
import 'package:fliproadmin/ui/view/image_gridview_screen/video_preview.dart';
import 'package:fliproadmin/ui/widget/helper_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class VideosTabBody extends StatelessWidget {
  const VideosTabBody({Key? key, required this.mediaObject}) : super(key: key);
  final MediaObject mediaObject;
  @override
  Widget build(BuildContext context) {
    return Consumer<LoadedProjectProvider>(
        builder: (ctx, loadedProjectProvider, c) {
      if (loadedProjectProvider.getLoadedProject == null ||
          mediaObject.videos == null ||
          mediaObject.videos!.isEmpty) {
        return const Center(
          child: Text("No Media Available"),
        );
      }
      if (loadedProjectProvider.getLoadingState == loadingState.loading) {
        return HelperWidget.progressIndicator();
      }
      return GridView.builder(
          padding: const EdgeInsets.symmetric(vertical: 4),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4),
          itemCount: mediaObject.videos!.length,
          itemBuilder: (BuildContext ctx, index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => VideoPreview(
                          videos: mediaObject.videos!,
                          index: index,
                        )));
              },
              child: Stack(
                alignment: Alignment.center,
                children: [

                  CachedNetworkImage(
                    imageUrl: mediaObject.videos![index].thumbnailPath,
                    width: 100.w,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        CircularProgressIndicator(value: downloadProgress.progress),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  const Icon(
                    Icons.play_circle_filled_outlined,
                    size: 38,
                  )
                ],
              ),
            );
          });
    });
  }
}
